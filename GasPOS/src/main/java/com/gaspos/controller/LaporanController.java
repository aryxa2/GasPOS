package com.gaspos.controller;

import com.gaspos.config.Database;
import com.gaspos.model.MenuTerjual;
import com.gaspos.model.Transaksi;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.http.HttpSession;

@WebServlet(name = "LaporanController", urlPatterns = {"/report"})
public class LaporanController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !"Admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("pos");
            return;
        }
        
        String range = request.getParameter("range");
        if (range == null || range.trim().isEmpty()) {
            range = "semua";
        }
        
        String filterSql = "";
        if ("1".equals(range)) {
            filterSql = "DATE(t.tanggal) = CURDATE()";
        } else if ("3".equals(range)) {
            filterSql = "t.tanggal >= DATE_SUB(NOW(), INTERVAL 3 DAY)";
        } else if ("7".equals(range)) {
            filterSql = "t.tanggal >= DATE_SUB(NOW(), INTERVAL 7 DAY)";
        }
        
        int totalTx = 0;
        int totalQty = 0;
        double totalHpp = 0;
        double totalRevenue = 0;
        
        List<Transaksi> listTransaksi = new ArrayList<>();
        List<MenuTerjual> listMenuTerjual = new ArrayList<>();
        
        try (Connection conn = Database.getConnection()) {
            String whereClause = filterSql.isEmpty() ? "" : "WHERE " + filterSql;
            
            // Total Tx and Revenue
            String sqlSummary = "SELECT COUNT(*) AS total_tx, IFNULL(SUM(t.total_bayar), 0) AS total_rev " +
                                "FROM transaksi t " + whereClause;
            try (PreparedStatement ps = conn.prepareStatement(sqlSummary);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    totalTx = rs.getInt("total_tx");
                    totalRevenue = rs.getDouble("total_rev");
                }
            }
            
            // HPP and Qty sold
            String sqlHpp = "SELECT IFNULL(SUM(d.qty * p.harga_modal), 0) AS total_hpp, IFNULL(SUM(d.qty), 0) AS total_qty " +
                            "FROM transaksi_detail d " +
                            "JOIN transaksi t ON d.no_invoice = t.no_invoice " +
                            "JOIN produk p ON d.id_produk = p.id_produk " + whereClause;
            try (PreparedStatement ps = conn.prepareStatement(sqlHpp);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    totalHpp = rs.getDouble("total_hpp");
                    totalQty = rs.getInt("total_qty");
                }
            }
            
            // 2. Query Daftar Transaksi
            String sqlTrans = "SELECT t.no_invoice, t.tanggal, t.pelanggan, t.metode_pembayaran, t.kasir, t.subtotal, t.total_bayar, t.kembalian " +
                              "FROM transaksi t " + whereClause + " ORDER BY t.tanggal DESC";
            try (PreparedStatement ps = conn.prepareStatement(sqlTrans);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    listTransaksi.add(new Transaksi(
                        rs.getString("no_invoice"),
                        rs.getTimestamp("tanggal"),
                        rs.getString("pelanggan"),
                        rs.getString("metode_pembayaran"),
                        rs.getString("kasir"),
                        rs.getDouble("subtotal"),
                        rs.getDouble("total_bayar"),
                        rs.getDouble("kembalian"),
                        ""
                    ));
                }
            }
            
            // 3. Query Detail Menu Terjual
            String sqlMenu = "SELECT d.nama_produk, SUM(d.qty) AS total_qty, SUM(d.total) AS total_harga " +
                             "FROM transaksi_detail d " +
                             "JOIN transaksi t ON d.no_invoice = t.no_invoice " +
                             whereClause + " GROUP BY d.nama_produk ORDER BY total_qty DESC";
            try (PreparedStatement ps = conn.prepareStatement(sqlMenu);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    listMenuTerjual.add(new MenuTerjual(
                        rs.getString("nama_produk"),
                        rs.getInt("total_qty"),
                        rs.getDouble("total_harga")
                    ));
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        double laba = totalRevenue - totalHpp;
        
        request.setAttribute("range", range);
        request.setAttribute("totalTx", totalTx);
        request.setAttribute("totalQty", totalQty);
        request.setAttribute("totalHpp", totalHpp);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("laba", laba);
        request.setAttribute("listTransaksi", listTransaksi);
        request.setAttribute("listMenuTerjual", listMenuTerjual);
        
        request.getRequestDispatcher("report.jsp").forward(request, response);
    }
}
