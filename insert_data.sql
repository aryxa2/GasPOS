-- --------------------------------------------------------
-- Kueri INSERT DATA untuk Tabel yang Sudah Ada (GasPOS)
-- --------------------------------------------------------

USE gaspos;

-- 1. Input Data untuk Tabel 'pengguna'
INSERT INTO pengguna (username, nama, password_hash, role, status) VALUES 
('admin', 'Administrator', 'admin123', 'Admin', 'Aktif'),
('husni', 'Husni', 'husni123', 'Kasir', 'Aktif'),
('kasir', 'Kasir Utama', 'kasir123', 'Kasir', 'Aktif')
ON DUPLICATE KEY UPDATE username=username;

-- 2. Input Data untuk Tabel 'produk'
INSERT INTO produk (id_produk, nama_produk, stok, harga_jual, gambar, kategori, harga_modal) VALUES
('P001', 'Headband PKKMB ', 96, 10000.0, 'https://i.ytimg.com/vi/IGsTb0nWUL0/maxresdefault.jpg', 'Peralatan', 5000.0),
('P002', 'Nametag PKKMB', 97, 15000.0, 'https://www.dropbox.com/scl/fi/mz7qzdl5cdgvyjhu90of7/Screenshot-2026-06-13-011611.png?rlkey=vpscfxw8ags291lyogmtxx2j0&st=gexopwtt&dl=0', 'Peralatan', 10000.0),
('P003', 'Kain Flanel PKKMB', 98, 15000.0, 'https://thekingdomshop.com/cdn/shop/files/master-kain-flanel-45x90cm-2048x2048.jpg?v=1721968317', 'Peralatan', 10000.0),
('P004', 'Topi Putih', 98, 25000.0, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5MnlmUfpt_aHXQkvTPvV4656j4EmvDgWpV8D0iylFEdy9HObbxSdsT5gg&s=10', 'Perlengkapan', 20000.0),
('P005', 'Pensil B2', 20, 2000.0, 'https://filebroker-cdn.lazada.co.id/kf/S826555b0c56143718f20f7f268610ee2m.jpg', 'Peralatan Tulis dan Gambar', 1500.0)
ON DUPLICATE KEY UPDATE id_produk=id_produk;

-- 3. Input Data untuk Tabel 'transaksi'
INSERT INTO transaksi (no_invoice, tanggal, pelanggan, metode_pembayaran, kasir, subtotal, total_bayar, kembalian) VALUES
('S-260613-GASPOS2819', '2026-06-13 16:28:19', 'Pelanggan Umum', 'Tunai', 'Administrator', 51000.0, 51000.0, 0.0),
('S-260613-GASPOS2845', '2026-06-13 16:28:45', 'Pelanggan Umum', 'QRIS', 'Administrator', 16000.0, 16000.0, 0.0),
('S-260613-GASPOS3410', '2026-06-12 18:34:10', 'Pelanggan Umum', 'Tunai', 'Administrator', 56000.0, 56000.0, 0.0)
ON DUPLICATE KEY UPDATE no_invoice=no_invoice;

-- 4. Input Data untuk Tabel 'transaksi_detail'
INSERT INTO transaksi_detail (id_detail, no_invoice, id_produk, nama_produk, qty, harga, total) VALUES
(1, 'S-260613-GASPOS3410', 'P001', 'Headband PKKMB ', 1, 1000.0, 1000.0),
(2, 'S-260613-GASPOS3410', 'P002', 'Nametag PKKMB', 1, 15000.0, 15000.0),
(3, 'S-260613-GASPOS3410', 'P003', 'Kain Flanel PKKMB', 1, 15000.0, 15000.0),
(4, 'S-260613-GASPOS3410', 'P004', 'Topi Putih', 1, 25000.0, 25000.0),
(8, 'S-260613-GASPOS2819', 'P001', 'Headband PKKMB ', 1, 1000.0, 1000.0),
(9, 'S-260613-GASPOS2819', 'P003', 'Kain Flanel PKKMB', 1, 15000.0, 15000.0),
(10, 'S-260613-GASPOS2819', 'P004', 'Topi Putih', 1, 25000.0, 25000.0),
(11, 'S-260613-GASPOS2819', '0001', 'pembantu coli', 1, 10000.0, 10000.0),
(12, 'S-260613-GASPOS2845', 'P002', 'Nametag PKKMB', 1, 15000.0, 15000.0),
(13, 'S-260613-GASPOS2845', 'P001', 'Headband PKKMB ', 1, 1000.0, 1000.0)
ON DUPLICATE KEY UPDATE id_detail=id_detail;
