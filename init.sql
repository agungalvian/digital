CREATE TABLE IF NOT EXISTS aktivitas (
    id VARCHAR(50) PRIMARY KEY,
    nama_aktivitas TEXT NOT NULL,
    deskripsi TEXT,
    jenis_kolaborasi VARCHAR(100),
    aspek JSONB,
    output TEXT,
    outcome TEXT,
    unit_internal VARCHAR(255),
    nama_mitra VARCHAR(255),
    jenis_mitra VARCHAR(100),
    prediksi_pelaksanaan VARCHAR(50),
    target_pelaksanaan VARCHAR(50),
    teknik_integrasi VARCHAR(100),
    pola_integrasi VARCHAR(100),
    risiko VARCHAR(100),
    kontrol VARCHAR(100),
    status VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS pilar (
    kode_pilar VARCHAR(50) PRIMARY KEY,
    nama_pilar VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS kelompok (
    kode_kelompok VARCHAR(50) PRIMARY KEY,
    kode_pilar VARCHAR(50),
    nama_kelompok VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS aspek (
    kode_aspek VARCHAR(50) PRIMARY KEY,
    kode_kelompok VARCHAR(50),
    kode_pilar VARCHAR(50),
    nama_aspek VARCHAR(255),
    keterangan_aspek TEXT,
    status_ketersediaan VARCHAR(50) DEFAULT 'Tersedia'
);

CREATE TABLE IF NOT EXISTS organisasi (
    id SERIAL PRIMARY KEY,
    data JSONB
);

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) DEFAULT 'admin',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
