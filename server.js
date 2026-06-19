const express = require('express');
const { Pool } = require('pg');
const path = require('path');
const dotenv = require('dotenv');
const session = require('express-session');
const expressLayouts = require('express-ejs-layouts');
const bcrypt = require('bcryptjs');

dotenv.config();

const app = express();
const port = process.env.PORT || 3000;

// Inisialisasi PostgreSQL Pool
const pool = new Pool({
    host: process.env.DB_HOST || 'db',
    user: process.env.DB_USER || 'postgres',
    password: process.env.DB_PASSWORD || 'postgres',
    database: process.env.DB_NAME || 'digital_db',
    port: process.env.DB_PORT || 5432,
});

// Otomatis membuat admin jika tabel users kosong & migrasi schema
async function ensureDbInit() {
    try {
        // Cek tabel users
        const res = await pool.query("SELECT to_regclass('public.users') as exists");
        if(res.rows[0].exists) {
            const countRes = await pool.query('SELECT COUNT(*) FROM users');
            if (parseInt(countRes.rows[0].count) === 0) {
                const bcrypt = require('bcryptjs');
                const hashedPassword = await bcrypt.hash('admin123', 10);
                await pool.query(
                    `INSERT INTO users (username, password, role) VALUES ($1, $2, $3) ON CONFLICT (username) DO NOTHING`,
                    ['admin', hashedPassword, 'admin']
                );
                console.log("Auto-seeded default admin user: admin / admin123");
            }
        }

        // Migrasi untuk kolom status_ketersediaan pada aspek
        const aspekColRes = await pool.query(`
            SELECT column_name 
            FROM information_schema.columns 
            WHERE table_name='aspek' AND column_name='status_ketersediaan';
        `);
        if (aspekColRes.rows.length === 0) {
            await pool.query(`ALTER TABLE aspek ADD COLUMN status_ketersediaan VARCHAR(50) DEFAULT 'Tersedia';`);
            console.log("Migrasi schema: menambahkan kolom status_ketersediaan pada tabel aspek.");
        }

        // Migrasi untuk kolom status pada aktivitas
        const aktivitasColRes = await pool.query(`
            SELECT column_name 
            FROM information_schema.columns 
            WHERE table_name='aktivitas' AND column_name='status';
        `);
        if (aktivitasColRes.rows.length === 0) {
            await pool.query(`ALTER TABLE aktivitas ADD COLUMN status VARCHAR(100) DEFAULT 'Usulan';`);
            console.log("Migrasi schema: menambahkan kolom status pada tabel aktivitas.");
        }
    } catch (e) {
        console.error("Error ensuring db init:", e);
    }
}
ensureDbInit();

// Middleware
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));
app.use(expressLayouts);
app.set('layout', 'layout');

app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(express.static('public'));

app.use(session({
    secret: 'mysecretkey123',
    resave: false,
    saveUninitialized: false,
    cookie: { secure: false } // Set true if HTTPS
}));

app.use((req, res, next) => {
    res.locals.user = req.session.user || null;
    res.locals.path = req.path;
    next();
});

// Auth Middleware
function requireAuth(req, res, next) {
    if (req.session.user) {
        return next();
    }
    res.redirect('/login');
}

// Routes
app.get('/', (req, res) => {
  res.redirect('/aktivitas');
});

// --- Auth Routes ---
app.get('/login', (req, res) => {
    if (req.session.user) return res.redirect('/aktivitas');
    res.render('login', { layout: false, error: null });
});

app.post('/login', async (req, res) => {
    const { username, password } = req.body;
    try {
        const result = await pool.query('SELECT * FROM users WHERE username = $1', [username]);
        if (result.rows.length > 0) {
            const user = result.rows[0];
            const match = await bcrypt.compare(password, user.password);
            if (match) {
                req.session.user = { id: user.id, username: user.username, role: user.role };
                return res.redirect('/aktivitas');
            }
        }
        res.render('login', { layout: false, error: 'Username atau password salah' });
    } catch (err) {
        console.error(err);
        res.render('login', { layout: false, error: 'Terjadi kesalahan pada server' });
    }
});

app.get('/logout', (req, res) => {
    req.session.destroy();
    res.redirect('/login');
});

// --- API or Data Fetching routes (for dropdowns) ---
app.get('/api/data', requireAuth, async (req, res) => {
    try {
        const pilarRes = await pool.query('SELECT * FROM pilar ORDER BY kode_pilar');
        const kelompokRes = await pool.query('SELECT * FROM kelompok ORDER BY kode_kelompok');
        const aspekRes = await pool.query('SELECT * FROM aspek ORDER BY kode_aspek');
        const orgRes = await pool.query('SELECT data FROM organisasi LIMIT 1');
        
        res.json({
            pilar: pilarRes.rows,
            kelompok: kelompokRes.rows,
            aspek: aspekRes.rows,
            organisasi: orgRes.rows.length > 0 ? orgRes.rows[0].data : null
        });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});

// --- Ganti Password ---
app.get('/ganti_password', requireAuth, (req, res) => {
    res.render('ganti_password', { error: null, success: null });
});

app.post('/ganti_password', requireAuth, async (req, res) => {
    const { old_password, new_password, confirm_password } = req.body;
    try {
        if (new_password !== confirm_password) {
            return res.render('ganti_password', { error: 'Konfirmasi password baru tidak cocok.', success: null });
        }

        // Get current user password
        const userRes = await pool.query('SELECT password FROM users WHERE id = $1', [req.session.userId]);
        if (userRes.rows.length === 0) {
            return res.render('ganti_password', { error: 'User tidak ditemukan.', success: null });
        }

        const validPassword = await bcrypt.compare(old_password, userRes.rows[0].password);
        if (!validPassword) {
            return res.render('ganti_password', { error: 'Password lama salah.', success: null });
        }

        const hashedPassword = await bcrypt.hash(new_password, 10);
        await pool.query('UPDATE users SET password = $1 WHERE id = $2', [hashedPassword, req.session.userId]);

        res.render('ganti_password', { error: null, success: 'Password berhasil diubah!' });
    } catch (err) {
        console.error(err);
        res.render('ganti_password', { error: 'Terjadi kesalahan sistem.', success: null });
    }
});

// --- Aktivitas CRUD ---
app.get('/aktivitas', requireAuth, async (req, res) => {
    try {
        const msg = req.query.msg;
        const result = await pool.query('SELECT * FROM aktivitas ORDER BY created_at DESC');
        
        res.render('crud_aktivitas', {
            listData: result.rows,
            msg: msg
        });
    } catch (err) {
        console.error(err);
        res.status(500).send('Internal Server Error');
    }
});

app.get('/aktivitas/add', requireAuth, (req, res) => {
    res.render('add_aktivitas');
});

app.post('/aktivitas', requireAuth, async (req, res) => {
    try {
        if (req.body.action === 'add') {
            const actId = 'act_' + Math.random().toString(36).substr(2, 9);
            const {
                nama_aktivitas, deskripsi, jenis_kolaborasi, aspek,
                output, outcome, unit_internal, nama_mitra, jenis_mitra,
                prediksi_pelaksanaan, target_pelaksanaan, teknik_integrasi,
                pola_integrasi, risiko, kontrol, status
            } = req.body;
            
            const aspekArray = Array.isArray(aspek) ? aspek : (aspek ? [aspek] : []);
            const unitInternalArray = Array.isArray(unit_internal) ? unit_internal : (unit_internal ? [unit_internal] : []);

            await pool.query(
                `INSERT INTO aktivitas 
                (id, nama_aktivitas, deskripsi, jenis_kolaborasi, aspek, output, outcome, unit_internal, nama_mitra, jenis_mitra, prediksi_pelaksanaan, target_pelaksanaan, teknik_integrasi, pola_integrasi, risiko, kontrol, status)
                VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17)`,
                [
                    actId, nama_aktivitas, deskripsi, jenis_kolaborasi, JSON.stringify(aspekArray),
                    output, outcome, JSON.stringify(unitInternalArray), nama_mitra, jenis_mitra, prediksi_pelaksanaan,
                    target_pelaksanaan, teknik_integrasi, pola_integrasi, risiko, kontrol, status || 'Usulan'
                ]
            );
            res.redirect('/aktivitas?msg=success');
        } else {
            res.status(400).send('Bad Request');
        }
    } catch (err) {
        console.error(err);
        res.status(500).send('Internal Server Error');
    }
});

app.get('/aktivitas/delete/:id', requireAuth, async (req, res) => {
    try {
        await pool.query('DELETE FROM aktivitas WHERE id = $1', [req.params.id]);
        res.redirect('/aktivitas?msg=deleted');
    } catch (err) {
        console.error(err);
        res.status(500).send('Internal Server Error');
    }
});

app.get('/aktivitas/edit/:id', requireAuth, async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM aktivitas WHERE id = $1', [req.params.id]);
        if (result.rows.length === 0) return res.status(404).send('Aktivitas tidak ditemukan');
        res.render('edit_aktivitas', { data: result.rows[0] });
    } catch (err) {
        console.error(err);
        res.status(500).send('Internal Server Error');
    }
});

app.post('/aktivitas/edit/:id', requireAuth, async (req, res) => {
    try {
        const {
            nama_aktivitas, deskripsi, jenis_kolaborasi, aspek,
            output, outcome, unit_internal, nama_mitra, jenis_mitra,
            prediksi_pelaksanaan, target_pelaksanaan, teknik_integrasi,
            pola_integrasi, risiko, kontrol, status
        } = req.body;
        
        let aspekArr = [];
        if (aspek) {
            aspekArr = Array.isArray(aspek) ? aspek : [aspek];
        }

        let unitArr = [];
        if (unit_internal) {
            unitArr = Array.isArray(unit_internal) ? unit_internal : [unit_internal];
        }

        await pool.query(
            `UPDATE aktivitas SET 
                nama_aktivitas = $1, deskripsi = $2, jenis_kolaborasi = $3, aspek = $4,
                output = $5, outcome = $6, unit_internal = $7, nama_mitra = $8, jenis_mitra = $9,
                prediksi_pelaksanaan = $10, target_pelaksanaan = $11, teknik_integrasi = $12,
                pola_integrasi = $13, risiko = $14, kontrol = $15, status = $16
            WHERE id = $17`,
            [
                nama_aktivitas, deskripsi, jenis_kolaborasi, JSON.stringify(aspekArr),
                output, outcome, JSON.stringify(unitArr), nama_mitra, jenis_mitra,
                prediksi_pelaksanaan, target_pelaksanaan, teknik_integrasi,
                pola_integrasi, risiko, kontrol, status || 'Usulan', req.params.id
            ]
        );
        res.redirect('/aktivitas?msg=updated');
    } catch (err) {
        console.error(err);
        res.status(500).send('Internal Server Error');
    }
});

// --- Organisasi ---
app.get('/organisasi', requireAuth, async (req, res) => {
    try {
        const result = await pool.query('SELECT data FROM organisasi LIMIT 1');
        const data = result.rows.length > 0 ? result.rows[0].data : null;
        res.render('organisasi', { data });
    } catch (err) {
        console.error(err);
        res.status(500).send('Internal Server Error');
    }
});

// --- Kegiatan ---
app.get('/kegiatan', requireAuth, (req, res) => {
    res.render('kegiatan');
});

// ==========================================
// MASTER DATA MANAGEMENT ROUTES
// ==========================================

// --- Manajemen User ---
app.get('/manajemen/users', requireAuth, async (req, res) => {
    try {
        const result = await pool.query('SELECT id, username, role, created_at FROM users ORDER BY id');
        res.render('manajemen/users', { data: result.rows, error: null });
    } catch (err) {
        res.status(500).send('Internal Server Error');
    }
});

app.post('/manajemen/users', requireAuth, async (req, res) => {
    const { action, username, password, role, id } = req.body;
    try {
        if (action === 'add') {
            const bcrypt = require('bcryptjs');
            const hashedPassword = await bcrypt.hash(password, 10);
            await pool.query('INSERT INTO users (username, password, role) VALUES ($1, $2, $3)', [username, hashedPassword, role]);
        } else if (action === 'delete') {
            await pool.query('DELETE FROM users WHERE id = $1', [id]);
        }
        res.redirect('/manajemen/users');
    } catch (err) {
        res.status(500).send('Error memproses data user');
    }
});

// --- Manajemen Pilar ---
app.get('/manajemen/pilar', requireAuth, async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM pilar ORDER BY kode_pilar');
        res.render('manajemen/pilar', { data: result.rows, error: null });
    } catch (err) {
        res.status(500).send('Internal Server Error');
    }
});

app.post('/manajemen/pilar', requireAuth, async (req, res) => {
    const { action, kode_pilar, nama_pilar } = req.body;
    try {
        if (action === 'add') {
            await pool.query('INSERT INTO pilar (kode_pilar, nama_pilar) VALUES ($1, $2)', [kode_pilar, nama_pilar]);
        } else if (action === 'delete') {
            await pool.query('DELETE FROM pilar WHERE kode_pilar = $1', [kode_pilar]);
        }
        res.redirect('/manajemen/pilar');
    } catch (err) {
        res.status(500).send('Error memproses data pilar');
    }
});

// --- Manajemen Kelompok ---
app.get('/manajemen/kelompok', requireAuth, async (req, res) => {
    try {
        const pilarRes = await pool.query('SELECT kode_pilar, nama_pilar FROM pilar ORDER BY kode_pilar');
        const result = await pool.query('SELECT * FROM kelompok ORDER BY kode_kelompok');
        res.render('manajemen/kelompok', { data: result.rows, pilarList: pilarRes.rows, error: null });
    } catch (err) {
        res.status(500).send('Internal Server Error');
    }
});

app.post('/manajemen/kelompok', requireAuth, async (req, res) => {
    const { action, kode_kelompok, kode_pilar, nama_kelompok } = req.body;
    try {
        if (action === 'add') {
            // Auto-generate kode_kelompok based on kode_pilar
            let genKode = kode_kelompok;
            if (!genKode) {
                const maxRes = await pool.query('SELECT MAX(kode_kelompok) FROM kelompok WHERE kode_pilar = $1', [kode_pilar]);
                let nextNum = 1;
                if (maxRes.rows[0].max) {
                    const parts = maxRes.rows[0].max.split('.');
                    nextNum = parseInt(parts[parts.length - 1]) + 1;
                }
                genKode = `${kode_pilar}.${nextNum.toString().padStart(3, '0')}`;
            }
            await pool.query('INSERT INTO kelompok (kode_kelompok, kode_pilar, nama_kelompok) VALUES ($1, $2, $3)', [genKode, kode_pilar, nama_kelompok]);
        } else if (action === 'delete') {
            await pool.query('DELETE FROM kelompok WHERE kode_kelompok = $1', [kode_kelompok]);
        }
        res.redirect('/manajemen/kelompok');
    } catch (err) {
        res.status(500).send('Error memproses data kelompok');
    }
});

// --- Manajemen Aspek ---
app.get('/manajemen/aspek', requireAuth, async (req, res) => {
    try {
        const pilarRes = await pool.query('SELECT kode_pilar, nama_pilar FROM pilar ORDER BY kode_pilar');
        const kelompokRes = await pool.query('SELECT kode_kelompok, nama_kelompok FROM kelompok ORDER BY kode_kelompok');
        const result = await pool.query('SELECT * FROM aspek ORDER BY kode_aspek');
        res.render('manajemen/aspek', { data: result.rows, pilarList: pilarRes.rows, kelompokList: kelompokRes.rows, error: null });
    } catch (err) {
        res.status(500).send('Internal Server Error');
    }
});

app.post('/manajemen/aspek', requireAuth, async (req, res) => {
    const { action, kode_aspek, kode_kelompok, kode_pilar, nama_aspek, keterangan_aspek, status_ketersediaan, id_lama } = req.body;
    try {
        if (action === 'add') {
            let genKode = kode_aspek;
            if (!genKode) {
                const maxRes = await pool.query('SELECT MAX(kode_aspek) FROM aspek WHERE kode_kelompok = $1', [kode_kelompok]);
                let nextNum = 1;
                if (maxRes.rows[0].max) {
                    const parts = maxRes.rows[0].max.split('.');
                    nextNum = parseInt(parts[parts.length - 1]) + 1;
                }
                genKode = `${kode_kelompok}.${nextNum.toString().padStart(3, '0')}`;
            }
            await pool.query('INSERT INTO aspek (kode_aspek, kode_kelompok, kode_pilar, nama_aspek, keterangan_aspek, status_ketersediaan) VALUES ($1, $2, $3, $4, $5, $6)', 
            [genKode, kode_kelompok, kode_pilar, nama_aspek, keterangan_aspek, status_ketersediaan || 'Tersedia']);
        } else if (action === 'edit') {
            await pool.query('UPDATE aspek SET nama_aspek = $1, keterangan_aspek = $2, status_ketersediaan = $3 WHERE kode_aspek = $4', 
            [nama_aspek, keterangan_aspek, status_ketersediaan, id_lama]);
        } else if (action === 'delete') {
            await pool.query('DELETE FROM aspek WHERE kode_aspek = $1', [kode_aspek]);
        }
        res.redirect('/manajemen/aspek');
    } catch (err) {
        res.status(500).send('Error memproses data aspek');
    }
});

// Start Server
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
