<?php
// ==========================================
// INISIALISASI FOLDER & FILE JSON (AUTO-SETUP)
// ==========================================
$dataDir = 'data';
if (!is_dir($dataDir)) {
    mkdir($dataDir, 0777, true);
}

// File utama tempat menyimpan input user
$aktivitasFile = $dataDir . '/aktivitas.json';
if (!file_exists($aktivitasFile)) {
    file_put_contents($aktivitasFile, json_encode([]));
}

// CRUD: LOGIKA SIMPAN DATA (CREATE)
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'add') {
    $currentData = json_decode(file_get_contents($aktivitasFile), true) ?? [];
    
    $newData = [
        'id' => uniqid('act_'),
        'nama_aktivitas' => $_POST['nama_aktivitas'] ?? '',
        'deskripsi' => $_POST['deskripsi'] ?? '',
        'jenis_kolaborasi' => $_POST['jenis_kolaborasi'] ?? '',
        'aspek' => $_POST['aspek'] ?? [], // Array (Multi-select)
        'output' => $_POST['output'] ?? '',
        'outcome' => $_POST['outcome'] ?? '',
        'unit_internal' => $_POST['unit_internal'] ?? '',
        'nama_mitra' => $_POST['nama_mitra'] ?? '',
        'jenis_mitra' => $_POST['jenis_mitra'] ?? '',
        'prediksi_pelaksanaan' => $_POST['prediksi_pelaksanaan'] ?? '',
        'target_pelaksanaan' => $_POST['target_pelaksanaan'] ?? '',
        'teknik_integrasi' => $_POST['teknik_integrasi'] ?? '',
        'pola_integrasi' => $_POST['pola_integrasi'] ?? '',
        'risiko' => $_POST['risiko'] ?? '',
        'kontrol' => $_POST['kontrol'] ?? '',
        'created_at' => date('Y-m-d H:i:s')
    ];
    
    $currentData[] = $newData;
    file_put_contents($aktivitasFile, json_encode($currentData, JSON_PRETTY_PRINT));
    
    header("Location: ?msg=success");
    exit;
}

// CRUD: LOGIKA HAPUS DATA (DELETE)
if (isset($_GET['delete'])) {
    $deleteId = $_GET['delete'];
    $currentData = json_decode(file_get_contents($aktivitasFile), true) ?? [];
    $filteredData = array_filter($currentData, function($item) use ($deleteId) {
        return $item['id'] !== $deleteId;
    });
    file_put_contents($aktivitasFile, json_encode(array_values($filteredData), JSON_PRETTY_PRINT));
    header("Location: ?msg=deleted");
    exit;
}

// ==========================================
// MEMBACA SUMBER DATA (MASTER DATA JSON)
// ==========================================
// Fungsi helper untuk membaca JSON, jika tidak ada kembalikan array kosong
function getJsonData($filepath) {
    if (file_exists($filepath)) {
        return file_get_contents($filepath);
    }
    return '[]';
}

$pilarJson = getJsonData($dataDir . '/pilar.json');
$kelompokJson = getJsonData($dataDir . '/kelompok.json');
$aspekJson = getJsonData($dataDir . '/aspek.json');
$organisasiJson = getJsonData($dataDir . '/organisasi.json');

// Jika file organisasi kosong/tidak format json yg benar, berikan fallback dummy sesuai struktur BP Tapera
if ($organisasiJson == '[]' || !json_decode($organisasiJson)) {
    $organisasiJson = json_encode([
        "komisioner" => [
            "unit_di_bawah" => [
                [
                    "jabatan" => "Deputi Komisioner Bidang Pengerahan Dana Tapera",
                    "direktorat" => [["nama" => "Direktorat Kepesertaan"], ["nama" => "Direktorat Operasi Pengerahan"]]
                ],
                [
                    "jabatan" => "Deputi Komisioner Bidang Pemupukan",
                    "direktorat" => [["nama" => "Direktorat Pengelolaan Dana"], ["nama" => "Direktorat Investasi"]]
                ]
            ]
        ]
    ]);
}

// Set default Minggu Ini untuk Input type week (Format: 2026-W24)
$currentWeek = date('Y-\WW'); 
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manajemen Aktivitas Kolaborasi IT</title>
    <!-- Bootstrap 5 CSS Theme Biru -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        /* Penyesuaian Tema Biru */
        body { background-color: #f0f4f8; }
        .bg-primary-custom { background-color: #0d6efd !important; }
        .text-primary-custom { color: #0d6efd !important; }
        .card-header { background-color: #0d6efd; color: white; font-weight: bold; }
        .btn-primary { background-color: #0d6efd; border-color: #0d6efd; }
        .form-label { font-weight: 600; color: #334155; font-size: 0.9rem;}
        .form-control:focus, .form-select:focus { border-color: #0d6efd; box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25); }
        select[multiple] { height: 120px; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary-custom mb-4 shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand" href="#"><i class="bi bi-hdd-network"></i> SI-KOLABORASI IT</a>
    </div>
</nav>

<div class="container-fluid px-4 pb-5">
    
    <?php if(isset($_GET['msg']) && $_GET['msg'] == 'success'): ?>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle"></i> Data aktivitas berhasil disimpan ke <strong>data/aktivitas.json</strong>!
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <?php endif; ?>
    
    <?php if(isset($_GET['msg']) && $_GET['msg'] == 'deleted'): ?>
        <div class="alert alert-warning alert-dismissible fade show" role="alert">
            <i class="bi bi-trash"></i> Data aktivitas berhasil dihapus.
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <?php endif; ?>

    <ul class="nav nav-pills mb-3 gap-2" id="pills-tab" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active btn btn-outline-primary" id="pills-form-tab" data-bs-toggle="pill" data-bs-target="#pills-form" type="button" role="tab"><i class="bi bi-plus-circle"></i> Tambah Aktivitas</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link btn btn-outline-primary" id="pills-data-tab" data-bs-toggle="pill" data-bs-target="#pills-data" type="button" role="tab"><i class="bi bi-table"></i> Data Aktivitas</button>
        </li>
    </ul>

    <div class="tab-content" id="pills-tabContent">
        
        <!-- ============================================== -->
        <!-- TAB 1: FORM TAMBAH DATA                        -->
        <!-- ============================================== -->
        <div class="tab-pane fade show active" id="pills-form" role="tabpanel">
            <div class="card shadow-sm border-0">
                <div class="card-header rounded-top">
                    <i class="bi bi-journal-plus"></i> Form Tambah Aktivitas
                </div>
                <div class="card-body bg-white">
                    <form action="" method="POST">
                        <input type="hidden" name="action" value="add">
                        
                        <div class="row g-4">
                            <!-- Bagian Kiri -->
                            <div class="col-md-6">
                                <h6 class="text-primary-custom border-bottom pb-2 mb-3">A. Informasi Utama</h6>
                                
                                <div class="mb-3">
                                    <label class="form-label">1. Nama Aktivitas Kolaborasi</label>
                                    <input type="text" name="nama_aktivitas" class="form-control" required placeholder="Judul/Nama Kegiatan">
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label">2. Deskripsi Aktivitas</label>
                                    <textarea name="deskripsi" class="form-control" rows="3" required placeholder="Penjelasan singkat mengenai aktivitas..."></textarea>
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label">3. Jenis Kolaborasi</label>
                                    <select name="jenis_kolaborasi" class="form-select" required>
                                        <option value="">-- Pilih Jenis --</option>
                                        <option value="Kolaborasi">Kolaborasi</option>
                                        <option value="Non Kolaborasi">Non Kolaborasi</option>
                                    </select>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">5. Output (Keluaran)</label>
                                    <textarea name="output" class="form-control" rows="2" placeholder="Sistem baru, API dokumen, dll..."></textarea>
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label">6. Outcome (Hasil/Dampak)</label>
                                    <textarea name="outcome" class="form-control" rows="2" placeholder="Efisiensi waktu, peningkatan layanan..."></textarea>
                                </div>

                                <h6 class="text-primary-custom border-bottom pb-2 mt-4 mb-3">B. Filter Aspek Terkait (Multi-Pilihan)</h6>
                                <div class="mb-3">
                                    <label class="form-label text-muted small">Pilih Pilar</label>
                                    <select id="combo_pilar" class="form-select mb-2">
                                        <option value="">-- Pilih Pilar --</option>
                                    </select>
                                    
                                    <label class="form-label text-muted small">Pilih Kelompok</label>
                                    <select id="combo_kelompok" class="form-select mb-2" disabled>
                                        <option value="">-- Pilih Kelompok --</option>
                                    </select>
                                    
                                    <label class="form-label">4. Aspek Terpilih (Bisa pilih lebih dari satu)</label>
                                    <select name="aspek[]" id="combo_aspek" class="form-select" multiple disabled>
                                        <!-- Options diisi via JS -->
                                    </select>
                                    <small class="text-muted"><i class="bi bi-info-circle"></i> Tahan tombol <code>Ctrl</code> (Windows) / <code>Cmd</code> (Mac) untuk memilih multi-aspek.</small>
                                </div>
                            </div>
                            
                            <!-- Bagian Kanan -->
                            <div class="col-md-6">
                                <h6 class="text-primary-custom border-bottom pb-2 mb-3">C. Stakeholder & Mitra</h6>
                                
                                <div class="mb-3">
                                    <label class="form-label text-muted small">Pilih Deputi (Unit Internal)</label>
                                    <select id="combo_deputi" class="form-select mb-2">
                                        <option value="">-- Pilih Deputi --</option>
                                    </select>

                                    <label class="form-label">7. Direktorat / Unit Internal</label>
                                    <select name="unit_internal" id="combo_direktorat" class="form-select" readonly required>
                                        <option value="">-- Pilih Direktorat --</option>
                                    </select>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">8. Nama Mitra</label>
                                        <input type="text" name="nama_mitra" class="form-control" placeholder="Contoh: PT. ABC / Kemen PUPR">
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">9. Jenis Mitra</label>
                                        <select name="jenis_mitra" class="form-select">
                                            <option value="">-- Pilih --</option>
                                            <option value="Pemerintah Pusat">Pemerintah Pusat</option>
                                            <option value="Pemerintah Daerah">Pemerintah Daerah</option>
                                            <option value="Kemitraan Non Pemerintah">Kemitraan Non Pemerintah</option>
                                        </select>
                                    </div>
                                </div>

                                <h6 class="text-primary-custom border-bottom pb-2 mt-2 mb-3">D. Pelaksanaan & Teknis IT</h6>
                                
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">10. Prediksi Pelaksanaan</label>
                                        <input type="week" name="prediksi_pelaksanaan" class="form-control" value="<?= $currentWeek ?>">
                                        <small class="text-muted">Pilih Minggu & Tahun</small>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">11. Target Pelaksanaan</label>
                                        <input type="week" name="target_pelaksanaan" class="form-control" value="<?= $currentWeek ?>">
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">12. Teknik Integrasi</label>
                                    <select name="teknik_integrasi" class="form-select">
                                        <option value="">-- Pilih Teknik IT --</option>
                                        <option value="RESTful API (JSON)">RESTful API (JSON)</option>
                                        <option value="SOAP (XML)">SOAP (XML)</option>
                                        <option value="GraphQL">GraphQL</option>
                                        <option value="Webhooks">Webhooks</option>
                                        <option value="File Transfer (SFTP/ETL)">File Transfer (SFTP/ETL)</option>
                                        <option value="Direct Database Link">Direct Database Link</option>
                                    </select>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">13. Pola Integrasi</label>
                                    <select name="pola_integrasi" class="form-select">
                                        <option value="">-- Pilih Pola --</option>
                                        <option value="Synchronous (Real-time P2P)">Synchronous (Real-time P2P)</option>
                                        <option value="Asynchronous (Message Queue / Kafka)">Asynchronous (Message Queue / Kafka)</option>
                                        <option value="Batch Processing (Terjadwal)">Batch Processing (Terjadwal)</option>
                                        <option value="Hub and Spoke (ESB/API Gateway)">Hub and Spoke (ESB/API Gateway)</option>
                                    </select>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">14. Risiko IT</label>
                                        <select name="risiko" class="form-select">
                                            <option value="">-- Pilih Risiko --</option>
                                            <option value="Kebocoran Data (Security)">Kebocoran Data (Security)</option>
                                            <option value="Latensi / Downtime (Availability)">Latensi / Downtime</option>
                                            <option value="Inkompatibilitas Format Data">Inkompatibilitas Format Data</option>
                                            <option value="Kegagalan API Pihak Ketiga">Kegagalan API Pihak Ketiga</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">15. Kontrol / Mitigasi</label>
                                        <select name="kontrol" class="form-select">
                                            <option value="">-- Pilih Kontrol --</option>
                                            <option value="Autentikasi OAuth 2.0 / JWT">Autentikasi OAuth 2.0 / JWT</option>
                                            <option value="Enkripsi End-to-End (TLS)">Enkripsi End-to-End (TLS)</option>
                                            <option value="Rate Limiting & WAF">Rate Limiting & WAF</option>
                                            <option value="Log Audit & Monitoring (APM)">Log Audit & Monitoring (APM)</option>
                                        </select>
                                    </div>
                                </div>

                            </div>
                        </div>
                        
                        <hr class="mt-4 mb-3">
                        <div class="text-end">
                            <button type="reset" class="btn btn-light border"><i class="bi bi-arrow-counterclockwise"></i> Reset</button>
                            <button type="submit" class="btn btn-primary px-4"><i class="bi bi-save"></i> Simpan Aktivitas</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- ============================================== -->
        <!-- TAB 2: DATA LIST / READ DATA                   -->
        <!-- ============================================== -->
        <div class="tab-pane fade" id="pills-data" role="tabpanel">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-secondary rounded-top">
                    <i class="bi bi-table"></i> Daftar Data Aktivitas Kolaborasi (Aktivitas.json)
                </div>
                <div class="card-body bg-white table-responsive">
                    <table class="table table-bordered table-striped table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>No</th>
                                <th>Nama Aktivitas</th>
                                <th>Kolaborasi</th>
                                <th>Unit & Mitra</th>
                                <th>Pelaksanaan</th>
                                <th>Aspek</th>
                                <th>Integrasi IT</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php 
                                $listData = json_decode(file_get_contents($aktivitasFile), true) ?? [];
                                if(empty($listData)):
                            ?>
                            <tr><td colspan="8" class="text-center text-muted py-4">Belum ada data aktivitas.</td></tr>
                            <?php 
                                else: 
                                    $no = 1;
                                    // Sort by terbaru (Reverse Array)
                                    $listData = array_reverse($listData);
                                    foreach($listData as $row):
                            ?>
                            <tr>
                                <td><?= $no++; ?></td>
                                <td>
                                    <strong><?= htmlspecialchars($row['nama_aktivitas']) ?></strong><br>
                                    <small class="text-muted"><?= htmlspecialchars($row['deskripsi']) ?></small>
                                </td>
                                <td><span class="badge bg-<?= $row['jenis_kolaborasi'] == 'Kolaborasi' ? 'success' : 'secondary' ?>"><?= htmlspecialchars($row['jenis_kolaborasi']) ?></span></td>
                                <td>
                                    <small><b>Unit:</b> <?= htmlspecialchars($row['unit_internal']) ?></small><br>
                                    <small><b>Mitra:</b> <?= htmlspecialchars($row['nama_mitra']) ?> (<?= htmlspecialchars($row['jenis_mitra']) ?>)</small>
                                </td>
                                <td>
                                    <small>P: <?= htmlspecialchars($row['prediksi_pelaksanaan']) ?></small><br>
                                    <small>T: <?= htmlspecialchars($row['target_pelaksanaan']) ?></small>
                                </td>
                                <td>
                                    <?php 
                                        if(!empty($row['aspek']) && is_array($row['aspek'])) {
                                            foreach($row['aspek'] as $asp) {
                                                echo '<span class="badge bg-info text-dark mb-1 me-1">'.$asp.'</span>';
                                            }
                                        } else {
                                            echo '-';
                                        }
                                    ?>
                                </td>
                                <td>
                                    <small><?= htmlspecialchars($row['teknik_integrasi']) ?></small>
                                </td>
                                <td>
                                    <a href="?delete=<?= $row['id'] ?>" class="btn btn-sm btn-danger" onclick="return confirm('Yakin hapus data ini?')"><i class="bi bi-trash"></i></a>
                                </td>
                            </tr>
                            <?php 
                                    endforeach;
                                endif; 
                            ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
    </div>
</div>

<!-- ============================================== -->
<!-- JAVASCRIPT LOGIC UNTUK FILTER CASCADING DROPDOWN-->
<!-- ============================================== -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // 1. Parsing JSON Data dari PHP ke Javascript Variable
    const dataPilar = <?= $pilarJson ?>;
    const dataKelompok = <?= $kelompokJson ?>;
    const dataAspek = <?= $aspekJson ?>;
    const dataOrganisasi = <?= $organisasiJson ?>;

    // Elemen DOM Aspek (Pilar -> Kelompok -> Aspek)
    const cmbPilar = document.getElementById('combo_pilar');
    const cmbKelompok = document.getElementById('combo_kelompok');
    const cmbAspek = document.getElementById('combo_aspek');

    // Elemen DOM Organisasi (Deputi -> Direktorat)
    const cmbDeputi = document.getElementById('combo_deputi');
    const cmbDirektorat = document.getElementById('combo_direktorat');

    document.addEventListener("DOMContentLoaded", () => {
        // --- SETUP PILAR ---
        if(Array.isArray(dataPilar)) {
            dataPilar.forEach(p => {
                let opt = new Option(p.kode_pilar + " - " + p.nama_pilar, p.kode_pilar);
                cmbPilar.add(opt);
            });
        }

        // Event Ganti Pilar
        cmbPilar.addEventListener("change", function() {
            cmbKelompok.innerHTML = '<option value="">-- Pilih Kelompok --</option>';
            cmbAspek.innerHTML = '';
            cmbKelompok.disabled = true;
            cmbAspek.disabled = true;

            const selectedPilar = this.value;
            if(selectedPilar && Array.isArray(dataKelompok)) {
                const filteredKel = dataKelompok.filter(k => k.kode_pilar === selectedPilar);
                if(filteredKel.length > 0) {
                    cmbKelompok.disabled = false;
                    filteredKel.forEach(k => {
                        let opt = new Option(k.kode_kelompok + " - " + k.nama_kelompok, k.kode_kelompok);
                        cmbKelompok.add(opt);
                    });
                }
            }
        });

        // Event Ganti Kelompok
        cmbKelompok.addEventListener("change", function() {
            cmbAspek.innerHTML = '';
            cmbAspek.disabled = true;

            const selectedKel = this.value;
            if(selectedKel && Array.isArray(dataAspek)) {
                const filteredAspek = dataAspek.filter(a => a.kode_kelompok === selectedKel);
                if(filteredAspek.length > 0) {
                    cmbAspek.disabled = false;
                    filteredAspek.forEach(a => {
                        // Value yang disimpan adalah nama aspek, text yg tampil kode+nama
                        let opt = new Option("["+a.kode_aspek+"] " + a.nama_aspek, a.nama_aspek);
                        cmbAspek.add(opt);
                    });
                } else {
                     cmbAspek.innerHTML = '<option disabled>Aspek kosong di kelompok ini</option>';
                }
            }
        });

        // --- SETUP ORGANISASI (Deputi -> Direktorat) ---
        let listDeputi = [];
        try {
            // Menyesuaikan dengan struktur JSON organisasi yang diberikan
            listDeputi = dataOrganisasi.komisioner.unit_di_bawah.filter(u => u.jabatan);
        } catch(e) { console.warn("Format JSON Organisasi berbeda", e); }

        if(listDeputi.length > 0) {
            listDeputi.forEach((dep, index) => {
                let opt = new Option(dep.jabatan, index); // simpan index array
                cmbDeputi.add(opt);
            });
        }

        // Event Ganti Deputi
        cmbDeputi.addEventListener("change", function() {
            cmbDirektorat.innerHTML = '<option value="">-- Pilih Direktorat --</option>';
            cmbDirektorat.readOnly = true;

            const idx = this.value;
            if(idx !== "") {
                const direkData = listDeputi[idx].direktorat;
                if(direkData && direkData.length > 0) {
                    cmbDirektorat.readOnly = false;
                    direkData.forEach(dir => {
                        // Value format: Deputi - Direktorat
                        let valText = listDeputi[idx].jabatan + " | " + dir.nama;
                        let opt = new Option(dir.nama, valText);
                        cmbDirektorat.add(opt);
                    });
                }
            }
        });

    });
</script>

</body>
</html>