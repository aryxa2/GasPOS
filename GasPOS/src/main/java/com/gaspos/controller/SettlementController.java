package com.gaspos.controller;

import com.gaspos.config.Database;
import com.gaspos.model.MenuTerjual;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "SettlementController", urlPatterns = {"/settlement"})
public class SettlementController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Format Tanggal Hari Ini
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        String todayStr = sdf.format(new Date());
        
        int totalTxToday = 0;
        double subtotalToday = 0;
        double totalRevenueToday = 0;
        List<MenuTerjual> listMenuTerjual = new ArrayList<>();
        
        try (Connection conn = Database.getConnection()) {
            
            // 1. Hitung total transaksi hari ini
            String qTx = "SELECT COUNT(*) AS total_tx FROM transaksi WHERE DATE(tanggal) = CURDATE()";
            try (PreparedStatement ps = conn.prepareStatement(qTx);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    totalTxToday = rs.getInt("total_tx");
                }
            }
            
            // 2. Ambil ringkasan keuangan hari ini
            String qRev = "SELECT SUM(subtotal) AS total_sub, SUM(total_bayar) AS total_rev FROM transaksi WHERE DATE(tanggal) = CURDATE()";
            try (PreparedStatement ps = conn.prepareStatement(qRev);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    subtotalToday = rs.getDouble("total_sub");
                    totalRevenueToday = rs.getDouble("total_rev");
                }
            }
            
            // 3. Ambil detail menu terjual hari ini
            String qMenu = "SELECT d.nama_produk, SUM(d.qty) AS total_qty, SUM(d.total) AS total_harga " +
                           "FROM transaksi_detail d " +
                           "JOIN transaksi t ON d.no_invoice = t.no_invoice " +
                           "WHERE DATE(t.tanggal) = CURDATE() " +
                           "GROUP BY d.nama_produk";
            try (PreparedStatement ps = conn.prepareStatement(qMenu);
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
        
        request.setAttribute("settlementDate", todayStr);
        request.setAttribute("totalTxToday", totalTxToday);
        request.setAttribute("subtotalToday", subtotalToday);
        request.setAttribute("totalRevenueToday", totalRevenueToday);
        request.setAttribute("listMenuTerjual", listMenuTerjual);
        
        request.getRequestDispatcher("settlement.jsp").forward(request, response);
    }
}
