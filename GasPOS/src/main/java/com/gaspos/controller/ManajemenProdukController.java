/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.gaspos.controller;

/**
 *
 * @author Arya Satriawansyah
 */
import com.gaspos.config.Database;
import com.gaspos.model.Produk;
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

@WebServlet(name = "ManajemenProdukController", urlPatterns = {"/produk"})
public class ManajemenProdukController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Produk> daftarProduk = new ArrayList<>();
        try (Connection conn = Database.getConnection()) {
            String sql = "SELECT * FROM produk";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                daftarProduk.add(new Produk(rs.getString("id_produk"), rs.getString("nama_produk"), rs.getInt("stok"), rs.getDouble("harga_jual"), rs.getString("gambar"), rs.getString("kategori"), rs.getDouble("harga_modal")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("daftarProduk", daftarProduk);
        request.getRequestDispatcher("produk.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String aksi = request.getParameter("aksi");
        String idProduk = request.getParameter("id_produk");
        String namaProduk = request.getParameter("nama_produk");
        String kategori = request.getParameter("kategori");
        String gambar = request.getParameter("gambar");
        String stokStr = request.getParameter("stok");
        String hargaModalStr = request.getParameter("harga_modal");
        String hargaJualStr = request.getParameter("harga_jual");

        try (Connection conn = Database.getConnection()) {
            if ("tambah".equals(aksi)) {
                String sql = "INSERT INTO produk (id_produk, nama_produk, stok, harga_jual, gambar, kategori, harga_modal) VALUES (?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, idProduk);
                ps.setString(2, namaProduk);
                ps.setInt(3, Integer.parseInt(stokStr));
                ps.setDouble(4, Double.parseDouble(hargaJualStr));
                ps.setString(5, gambar);
                ps.setString(6, kategori);
                ps.setDouble(7, Double.parseDouble(hargaModalStr));
                ps.executeUpdate();
            } else if ("edit".equals(aksi)) {
                String sql = "UPDATE produk SET nama_produk = ?, stok = ?, harga_jual = ?, gambar = ?, kategori = ?, harga_modal = ? WHERE id_produk = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, namaProduk);
                ps.setInt(2, Integer.parseInt(stokStr));
                ps.setDouble(3, Double.parseDouble(hargaJualStr));
                ps.setString(4, gambar);
                ps.setString(5, kategori);
                ps.setDouble(6, Double.parseDouble(hargaModalStr));
                ps.setString(7, idProduk);
                ps.executeUpdate();
            } else if ("hapus".equals(aksi)) {
                String sql = "DELETE FROM produk WHERE id_produk = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, idProduk);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("produk");
    }
}