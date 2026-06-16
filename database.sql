
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `gaspos` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `gaspos`;
DROP TABLE IF EXISTS `pengguna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pengguna` (
  `username` varchar(50) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` varchar(50) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'Aktif',
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `pengguna` WRITE;
/*!40000 ALTER TABLE `pengguna` DISABLE KEYS */;
INSERT INTO `pengguna` VALUES ('admin','Administrator','admin123','Admin','Aktif'),('husni','Husni','husni123','Kasir','Aktif'),('kasir','Kasir Utama','kasir123','Kasir','Aktif');
/*!40000 ALTER TABLE `pengguna` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `produk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produk` (
  `id_produk` varchar(50) NOT NULL,
  `nama_produk` varchar(100) NOT NULL,
  `stok` int(11) NOT NULL DEFAULT 0,
  `harga_jual` double NOT NULL DEFAULT 0,
  `gambar` varchar(255) DEFAULT NULL,
  `kategori` varchar(50) DEFAULT NULL,
  `harga_modal` double NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_produk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `produk` WRITE;
/*!40000 ALTER TABLE `produk` DISABLE KEYS */;
INSERT INTO `produk` VALUES ('P001','Headband PKKMB ',96,10000,'https://i.ytimg.com/vi/IGsTb0nWUL0/maxresdefault.jpg','Peralatan',5000),('P002','Nametag PKKMB',97,15000,'https://www.dropbox.com/scl/fi/mz7qzdl5cdgvyjhu90of7/Screenshot-2026-06-13-011611.png?rlkey=vpscfxw8ags291lyogmtxx2j0&st=gexopwtt&dl=0','Peralatan',10000),('P003','Kain Flanel PKKMB',98,15000,'https://thekingdomshop.com/cdn/shop/files/master-kain-flanel-45x90cm-2048x2048.jpg?v=1721968317','Peralatan',10000),('P004','Topi Putih',98,25000,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5MnlmUfpt_aHXQkvTPvV4656j4EmvDgWpV8D0iylFEdy9HObbxSdsT5gg&s=10','Perlengkapan',20000),('P005','Pensil B2',20,2000,'https://filebroker-cdn.lazada.co.id/kf/S826555b0c56143718f20f7f268610ee2m.jpg','Peralatan Tulis dan Gambar',1500);
/*!40000 ALTER TABLE `produk` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `transaksi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaksi` (
  `no_invoice` varchar(50) NOT NULL,
  `tanggal` timestamp NOT NULL DEFAULT current_timestamp(),
  `pelanggan` varchar(100) NOT NULL DEFAULT 'Pelanggan Umum',
  `metode_pembayaran` varchar(50) NOT NULL,
  `kasir` varchar(100) NOT NULL DEFAULT 'Kasir Utama',
  `subtotal` double NOT NULL DEFAULT 0,
  `total_bayar` double NOT NULL DEFAULT 0,
  `kembalian` double NOT NULL DEFAULT 0,
  PRIMARY KEY (`no_invoice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `transaksi` WRITE;
/*!40000 ALTER TABLE `transaksi` DISABLE KEYS */;
INSERT INTO `transaksi` VALUES ('S-260613-GASPOS2819','2026-06-13 16:28:19','Pelanggan Umum','Tunai','Administrator',51000,51000,0),('S-260613-GASPOS2845','2026-06-13 16:28:45','Pelanggan Umum','QRIS','Administrator',16000,16000,0),('S-260613-GASPOS3410','2026-06-12 18:34:10','Pelanggan Umum','Tunai','Administrator',56000,56000,0);
/*!40000 ALTER TABLE `transaksi` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `transaksi_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaksi_detail` (
  `id_detail` int(11) NOT NULL AUTO_INCREMENT,
  `no_invoice` varchar(50) NOT NULL,
  `id_produk` varchar(50) NOT NULL,
  `nama_produk` varchar(100) NOT NULL,
  `qty` int(11) NOT NULL,
  `harga` double NOT NULL,
  `total` double NOT NULL,
  PRIMARY KEY (`id_detail`),
  KEY `no_invoice` (`no_invoice`),
  CONSTRAINT `transaksi_detail_ibfk_1` FOREIGN KEY (`no_invoice`) REFERENCES `transaksi` (`no_invoice`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `transaksi_detail` WRITE;
/*!40000 ALTER TABLE `transaksi_detail` DISABLE KEYS */;
INSERT INTO `transaksi_detail` VALUES (1,'S-260613-GASPOS3410','P001','Headband PKKMB ',1,1000,1000),(2,'S-260613-GASPOS3410','P002','Nametag PKKMB',1,15000,15000),(3,'S-260613-GASPOS3410','P003','Kain Flanel PKKMB',1,15000,15000),(4,'S-260613-GASPOS3410','P004','Topi Putih',1,25000,25000),(8,'S-260613-GASPOS2819','P001','Headband PKKMB ',1,1000,1000),(9,'S-260613-GASPOS2819','P003','Kain Flanel PKKMB',1,15000,15000),(10,'S-260613-GASPOS2819','P004','Topi Putih',1,25000,25000),(11,'S-260613-GASPOS2819','0001','pembantu coli',1,10000,10000),(12,'S-260613-GASPOS2845','P002','Nametag PKKMB',1,15000,15000),(13,'S-260613-GASPOS2845','P001','Headband PKKMB ',1,1000,1000);
/*!40000 ALTER TABLE `transaksi_detail` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

