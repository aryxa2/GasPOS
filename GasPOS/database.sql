CREATE DATABASE IF NOT EXISTS gaspos;
USE gaspos;

CREATE TABLE IF NOT EXISTS pengguna (
    username VARCHAR(50) PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Aktif'
);

CREATE TABLE IF NOT EXISTS produk (
    id_produk VARCHAR(50) PRIMARY KEY,
    nama_produk VARCHAR(100) NOT NULL,
    stok INT NOT NULL DEFAULT 0,
    harga_jual DOUBLE NOT NULL DEFAULT 0.0,
    gambar VARCHAR(255),
    kategori VARCHAR(50),
    harga_modal DOUBLE NOT NULL DEFAULT 0.0
);

-- Insert default users
INSERT INTO pengguna (username, nama, password_hash, role, status) VALUES 
('admin', 'Administrator', 'admin123', 'Admin', 'Aktif')
ON DUPLICATE KEY UPDATE username=username;

INSERT INTO pengguna (username, nama, password_hash, role, status) VALUES 
('kasir', 'Kasir Utama', 'kasir123', 'Kasir', 'Aktif')
ON DUPLICATE KEY UPDATE username=username;

-- Insert sample products
INSERT INTO produk (id_produk, nama_produk, stok, harga_jual, gambar, kategori, harga_modal) VALUES
('P001', 'Buku Panduan PKKMB', 50, 35000.0, 'https://via.placeholder.com/150', 'Peralatan', 20000.0),
('P002', 'Nametag PKKMB', 100, 15000.0, 'https://via.placeholder.com/150', 'Peralatan', 10000.0)
ON DUPLICATE KEY UPDATE id_produk=id_produk;

-- Table for transactions
CREATE TABLE IF NOT EXISTS transaksi (
    no_invoice VARCHAR(50) PRIMARY KEY,
    tanggal TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    pelanggan VARCHAR(100) NOT NULL DEFAULT 'Pelanggan Umum',
    metode_pembayaran VARCHAR(50) NOT NULL,
    kasir VARCHAR(100) NOT NULL DEFAULT 'Kasir Utama',
    subtotal DOUBLE NOT NULL DEFAULT 0.0,
    total_bayar DOUBLE NOT NULL DEFAULT 0.0,
    kembalian DOUBLE NOT NULL DEFAULT 0.0
);

-- Table for transaction details
CREATE TABLE IF NOT EXISTS transaksi_detail (
    id_detail INT AUTO_INCREMENT PRIMARY KEY,
    no_invoice VARCHAR(50) NOT NULL,
    id_produk VARCHAR(50) NOT NULL,
    nama_produk VARCHAR(100) NOT NULL,
    qty INT NOT NULL,
    harga DOUBLE NOT NULL,
    total DOUBLE NOT NULL,
    FOREIGN KEY (no_invoice) REFERENCES transaksi(no_invoice) ON DELETE CASCADE
);
