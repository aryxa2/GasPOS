package com.gaspos.controller;

import com.gaspos.config.Database;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "TransaksiController", urlPatterns = {"/save-transaction"})
public class TransaksiController extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String noInvoice = request.getParameter("invoiceId");
        String pelanggan = request.getParameter("customerName");
        String metodePembayaran = request.getParameter("paymentMethod");
        String kasir = request.getParameter("cashierName");
        
        double subtotal = 0;
        double totalBayar = 0;
        double kembalian = 0;
        
        try {
            subtotal = Double.parseDouble(request.getParameter("subtotal"));
            totalBayar = Double.parseDouble(request.getParameter("totalBayar"));
            kembalian = Double.parseDouble(request.getParameter("kembalian"));
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        
        String[] idProduk = request.getParameterValues("idProduk");
        String[] namaProduk = request.getParameterValues("namaProduk");
        String[] qty = request.getParameterValues("qty");
        String[] harga = request.getParameterValues("harga");
        
        Connection conn = null;
        PreparedStatement psTrans = null;
        PreparedStatement psDetail = null;
        PreparedStatement psStok = null;
        
        try {
            conn = Database.getConnection();
            conn.setAutoCommit(false); // Transaction wrapper
            
            // Insert transaksi
            String queryTrans = "INSERT INTO transaksi (no_invoice, pelanggan, metode_pembayaran, kasir, subtotal, total_bayar, kembalian) VALUES (?, ?, ?, ?, ?, ?, ?)";
            psTrans = conn.prepareStatement(queryTrans);
            psTrans.setString(1, noInvoice);
            psTrans.setString(2, pelanggan != null && !pelanggan.trim().isEmpty() ? pelanggan : "Pelanggan Umum");
            psTrans.setString(3, metodePembayaran);
            psTrans.setString(4, kasir != null && !kasir.trim().isEmpty() ? kasir : "Kasir Utama");
            psTrans.setDouble(5, subtotal);
            psTrans.setDouble(6, totalBayar);
            psTrans.setDouble(7, kembalian);
            psTrans.executeUpdate();
            
            // Insert transaksi detail & kurangi stok produk
            if (idProduk != null && idProduk.length > 0) {
                String queryDetail = "INSERT INTO transaksi_detail (no_invoice, id_produk, nama_produk, qty, harga, total) VALUES (?, ?, ?, ?, ?, ?)";
                psDetail = conn.prepareStatement(queryDetail);
                
                String queryStok = "UPDATE produk SET stok = stok - ? WHERE id_produk = ?";
                psStok = conn.prepareStatement(queryStok);
                
                for (int i = 0; i < idProduk.length; i++) {
                    psDetail.setString(1, noInvoice);
                    psDetail.setString(2, idProduk[i]);
                    psDetail.setString(3, namaProduk[i]);
                    
                    int quantity = Integer.parseInt(qty[i]);
                    double price = Double.parseDouble(harga[i]);
                    double total = quantity * price;
                    
                    psDetail.setInt(4, quantity);
                    psDetail.setDouble(5, price);
                    psDetail.setDouble(6, total);
                    psDetail.addBatch();
                    
                    // Update stock
                    psStok.setInt(1, quantity);
                    psStok.setString(2, idProduk[i]);
                    psStok.addBatch();
                }
                psDetail.executeBatch();
                psStok.executeBatch();
                
                // Secara otomatis update status menjadi 'Tidak Aktif' jika stok <= 0
                try (PreparedStatement psUpdateStatus = conn.prepareStatement("UPDATE produk SET status = 'Tidak Aktif' WHERE stok <= 0")) {
                    psUpdateStatus.executeUpdate();
                }
            }
            
            conn.commit();
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("OK");
        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error: " + e.getMessage());
        } finally {
            try {
                if (psTrans != null) psTrans.close();
                if (psDetail != null) psDetail.close();
                if (psStok != null) psStok.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
