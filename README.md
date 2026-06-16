# GasPOS - Point of Sale Application

GasPOS adalah aplikasi Kasir (Point of Sale) berbasis web yang dikembangkan menggunakan **Java EE (Servlets & JSP)**, **Bootstrap 5**, **Maven**, dan **MySQL**. Aplikasi ini dirancang untuk mengelola menu, produk, transaksi harian, settlement (tutup kasir), dan laporan penjualan secara efisien dan dinamis.

---

## Prasyarat (Prerequisites)

Sebelum menjalankan aplikasi, pastikan sistem Anda telah memiliki perangkat lunak berikut:
1. **Java Development Kit (JDK) 8** atau versi yang lebih baru.
2. **Apache Maven** (untuk manajemen dependensi dan build).
3. **Database MySQL / MariaDB** (misalnya melalui XAMPP).
4. **Servlet Container / Web Server** seperti **Apache Tomcat 9.x** atau **GlassFish**.
5. **Web Browser** modern (Google Chrome, Mozilla Firefox, Microsoft Edge, dll.).
6. **IDE (Opsional)** seperti **NetBeans**, **IntelliJ IDEA**, atau **Eclipse** untuk mempermudah proses run/debug.

---

## Langkah-Langkah Menjalankan Aplikasi

### 1. Persiapan Database MySQL

1. Pastikan server database MySQL Anda telah aktif (misal melalui panel kontrol XAMPP).
2. Secara default, aplikasi dikonfigurasi untuk terhubung ke MySQL pada:
   * **Host:** `localhost`
   * **Port:** `3307` *(Bisa disesuaikan jika menggunakan port default `3306`)*
   * **Username:** `root`
   * **Password:** ` ` (kosong)
3. Buat database baru bernama **`gaspos`** melalui phpMyAdmin atau klien database pilihan Anda:
   ```sql
   CREATE DATABASE gaspos;
   ```
4. Impor seluruh tabel dan data awal dari berkas SQL yang disediakan ke database `gaspos`. Berkas SQL berada di:
   `GasPOS/database.sql`
5. Jika port atau kredensial database Anda berbeda, sesuaikan konfigurasinya pada berkas:
   `GasPOS/src/main/java/com/gaspos/config/Database.java` pada baris berikut:
   ```java
   private static final String URL = "jdbc:mysql://localhost:3307/gaspos"; // Ganti 3307 dengan port database Anda (misal 3306)
   private static final String USER = "root"; // Ganti jika username database berbeda
   private static final String PASS = ""; // Ganti dengan password database Anda
   ```

---

### 2. Melakukan Build Aplikasi (Menggunakan Maven)

1. Buka terminal atau Command Prompt (CMD).
2. Masuk ke direktori yang berisi berkas `pom.xml`:
   ```bash
   cd GasPOS
   ```
3. Jalankan perintah Maven berikut untuk mengunduh dependensi dan mengompilasi proyek menjadi paket `.war`:
   ```bash
   mvn clean package
   ```
4. Setelah build berhasil (`BUILD SUCCESS`), berkas hasil kompilasi **`GasPOS.war`** akan berada di dalam folder target:
   `GasPOS/target/GasPOS.war`

---

### 3. Deploy dan Menjalankan Aplikasi Web

Anda dapat menjalankan aplikasi menggunakan salah satu dari dua metode di bawah ini:

#### Metode A: Menjalankan Lewat IDE (NetBeans / IntelliJ IDEA) (Direkomendasikan)
1. Buka proyek **GasPOS** di IDE pilihan Anda (IDE akan mendeteksi ini sebagai proyek Maven).
2. Daftarkan server aplikasi seperti **Apache Tomcat 9.0** di dalam IDE Anda.
3. Klik kanan pada proyek utama -> pilih **Run** atau **Debug**.
4. IDE akan otomatis mem-build proyek, menyalakan server Tomcat lokal, men-deploy aplikasi, dan membuka browser pada halaman login.

#### Metode B: Deploy Manual ke Server Apache Tomcat Mandiri
1. Pastikan Anda telah menginstal Apache Tomcat di komputer Anda.
2. Salin berkas **`GasPOS.war`** yang berada di dalam folder `GasPOS/target/`.
3. Tempel (paste) berkas tersebut ke dalam folder **`webapps`** di direktori instalasi Tomcat Anda:
   * Contoh path Windows: `C:\Program Files\Apache Software Foundation\Tomcat 9.0\webapps\`
4. Jalankan server Tomcat dengan mengeklik berkas `startup.bat` di dalam folder `bin` Tomcat.
5. Buka web browser Anda dan akses aplikasi melalui tautan berikut:
   ```http
   http://localhost:8080/GasPOS/
   ```
   *(Catatan: Sesuaikan port `8080` jika server Tomcat Anda dikonfigurasi dengan port yang berbeda)*.

---

## Akun Login Bawaan (Default Accounts)

Gunakan akun berikut untuk masuk ke sistem setelah aplikasi berhasil berjalan:

| Peran (Role) | Username | Password | Deskripsi |
| :--- | :--- | :--- | :--- |
| **Admin** | `admin` | `admin123` | Akses penuh ke Menu, Produk, Bills, Settlement, Report, & Settings |
| **Kasir** | `kasir` | `kasir123` | Akses terbatas hanya untuk POS/Daftar Menu & Settlement |

---

## Struktur Folder Proyek Utama

* `GasPOS/` - Folder utama proyek.
  * `database.sql` - Skema basis data awal dan data dummy pengguna/produk.
  * `pom.xml` - Konfigurasi Maven dan daftar dependensi proyek.
  * `src/main/java/` - Logika kode Java (Model, Controller, DAO, Config).
  * `src/main/webapp/` - Antarmuka pengguna (halaman JSP, CSS, JS, Bootstrap).
