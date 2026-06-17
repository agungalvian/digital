const { Client } = require('pg');
const fs = require('fs');
const path = require('path');
require('dotenv').config();

const client = new Client({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  port: process.env.DB_PORT,
});

async function seed() {
  await client.connect();
  console.log("Connected to database");

  const dataDir = path.join(__dirname, 'data');

  try {
    // Seed Pilar
    if (fs.existsSync(path.join(dataDir, 'pilar.json'))) {
        const pilarData = JSON.parse(fs.readFileSync(path.join(dataDir, 'pilar.json'), 'utf-8').replace(/^\uFEFF/, ''));
        for (const p of pilarData) {
            await client.query(
                `INSERT INTO pilar (kode_pilar, nama_pilar) VALUES ($1, $2) ON CONFLICT (kode_pilar) DO NOTHING`,
                [p.kode_pilar, p.nama_pilar]
            );
        }
        console.log("Seeded pilar");
    }

    // Seed Kelompok
    if (fs.existsSync(path.join(dataDir, 'kelompok.json'))) {
        const kelompokData = JSON.parse(fs.readFileSync(path.join(dataDir, 'kelompok.json'), 'utf-8').replace(/^\uFEFF/, ''));
        for (const k of kelompokData) {
            await client.query(
                `INSERT INTO kelompok (kode_kelompok, kode_pilar, nama_kelompok) VALUES ($1, $2, $3) ON CONFLICT (kode_kelompok) DO NOTHING`,
                [k.kode_kelompok, k.kode_pilar, k.nama_kelompok]
            );
        }
        console.log("Seeded kelompok");
    }

    // Seed Aspek
    if (fs.existsSync(path.join(dataDir, 'aspek.json'))) {
        const aspekData = JSON.parse(fs.readFileSync(path.join(dataDir, 'aspek.json'), 'utf-8').replace(/^\uFEFF/, ''));
        await client.query('TRUNCATE TABLE aspek');
        for (const a of aspekData) {
            await client.query(
                `INSERT INTO aspek (kode_aspek, kode_kelompok, kode_pilar, nama_aspek, keterangan_aspek) VALUES ($1, $2, $3, $4, $5)`,
                [a.kode_aspek, a.kode_kelompok, a.kode_pilar, a.nama_aspek, a.keterangan_aspek]
            );
        }
        console.log("Seeded aspek");
    }

    // Seed Organisasi
    if (fs.existsSync(path.join(dataDir, 'organisasi.json'))) {
        const orgData = JSON.parse(fs.readFileSync(path.join(dataDir, 'organisasi.json'), 'utf-8').replace(/^\uFEFF/, ''));
        await client.query(`TRUNCATE TABLE organisasi`);
        await client.query(`INSERT INTO organisasi (data) VALUES ($1)`, [orgData]);
        console.log("Seeded organisasi");
    }

    // Seed Aktivitas
    if (fs.existsSync(path.join(dataDir, 'aktivitas.json'))) {
        const aktivitasData = JSON.parse(fs.readFileSync(path.join(dataDir, 'aktivitas.json'), 'utf-8').replace(/^\uFEFF/, ''));
        for (const act of aktivitasData) {
            await client.query(
                `INSERT INTO aktivitas 
                (id, nama_aktivitas, deskripsi, jenis_kolaborasi, aspek, output, outcome, unit_internal, nama_mitra, jenis_mitra, prediksi_pelaksanaan, target_pelaksanaan, teknik_integrasi, pola_integrasi, risiko, kontrol, created_at)
                VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17)
                ON CONFLICT (id) DO NOTHING`,
                [
                    act.id, act.nama_aktivitas, act.deskripsi, act.jenis_kolaborasi, 
                    JSON.stringify(act.aspek || []), act.output, act.outcome, 
                    act.unit_internal, act.nama_mitra, act.jenis_mitra, 
                    act.prediksi_pelaksanaan, act.target_pelaksanaan, 
                    act.teknik_integrasi, act.pola_integrasi, act.risiko, act.kontrol, 
                    act.created_at ? new Date(act.created_at) : new Date()
                ]
            );
        }
        console.log("Seeded aktivitas");
    }

    // Seed Users (Admin)
    const bcrypt = require('bcryptjs');
    const hashedPassword = await bcrypt.hash('admin123', 10);
    await client.query(
        `INSERT INTO users (username, password, role) VALUES ($1, $2, $3) ON CONFLICT (username) DO NOTHING`,
        ['admin', hashedPassword, 'admin']
    );
    console.log("Seeded admin user");

  } catch (err) {
    console.error("Error seeding data:", err);
  } finally {
    await client.end();
  }
}

seed();
