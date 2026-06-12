package com.gaspos.controller;

import com.gaspos.config.Database;
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

@WebServlet(name = "BillsController", urlPatterns = {"/bills"})
public class BillsController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !"Admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("pos");
            return;
        }
        
        List<Transaksi> listTransaksi = new ArrayList<>();
        
        String sql = "SELECT t.no_invoice, t.tanggal, t.pelanggan, t.metode_pembayaran, t.kasir, t.subtotal, t.total_bayar, t.kembalian, " +
                     "GROUP_CONCAT(CONCAT(d.qty, 'x ', d.nama_produk) SEPARATOR ', ') AS items_sold " +
                     "FROM transaksi t " +
                     "LEFT JOIN transaksi_detail d ON t.no_invoice = d.no_invoice " +
                     "GROUP BY t.no_invoice, t.tanggal, t.metode_pembayaran, t.kasir, t.subtotal, t.total_bayar, t.kembalian " +
                     "ORDER BY t.tanggal DESC";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                String items = rs.getString("items_sold");
                listTransaksi.add(new Transaksi(
                    rs.getString("no_invoice"),
                    rs.getTimestamp("tanggal"),
                    rs.getString("pelanggan"),
                    rs.getString("metode_pembayaran"),
                    rs.getString("kasir"),
                    rs.getDouble("subtotal"),
                    rs.getDouble("total_bayar"),
                    rs.getDouble("kembalian"),
                    items != null ? items : "-"
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        request.setAttribute("listTransaksi", listTransaksi);
        request.getRequestDispatcher("bills.jsp").forward(request, response);
    }
}
