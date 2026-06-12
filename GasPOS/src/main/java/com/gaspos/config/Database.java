/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.gaspos.config;

/**
 *
 * @author Arya Satriawansyah
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {
    private static final String URL = "jdbc:mysql://localhost:3307/gaspos";
    private static final String USER = "root";
    private static final String PASS = "";
    private static boolean isInitialized = false;

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(URL, USER, PASS);
        if (!isInitialized) {
            initializeTables(conn);
            isInitialized = true;
        }
        return conn;
    }

    private static void initializeTables(Connection conn) {
        String createTransaksi = "CREATE TABLE IF NOT EXISTS transaksi (" +
                                 "  no_invoice VARCHAR(50) PRIMARY KEY," +
                                 "  tanggal TIMESTAMP DEFAULT CURRENT_TIMESTAMP," +
                                 "  pelanggan VARCHAR(100) NOT NULL DEFAULT 'Pelanggan Umum'," +
                                 "  metode_pembayaran VARCHAR(50) NOT NULL," +
                                 "  kasir VARCHAR(100) NOT NULL DEFAULT 'Kasir Utama'," +
                                 "  subtotal DOUBLE NOT NULL DEFAULT 0.0," +
                                 "  total_bayar DOUBLE NOT NULL DEFAULT 0.0," +
                                 "  kembalian DOUBLE NOT NULL DEFAULT 0.0" +
                                 ")";
        
        String createDetail = "CREATE TABLE IF NOT EXISTS transaksi_detail (" +
                              "  id_detail INT AUTO_INCREMENT PRIMARY KEY," +
                              "  no_invoice VARCHAR(50) NOT NULL," +
                              "  id_produk VARCHAR(50) NOT NULL," +
                              "  nama_produk VARCHAR(100) NOT NULL," +
                              "  qty INT NOT NULL," +
                              "  harga DOUBLE NOT NULL," +
                              "  total DOUBLE NOT NULL," +
                              "  FOREIGN KEY (no_invoice) REFERENCES transaksi(no_invoice) ON DELETE CASCADE" +
                              ")";
        
        try (java.sql.Statement stmt = conn.createStatement()) {
            stmt.execute(createTransaksi);
            stmt.execute(createDetail);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
