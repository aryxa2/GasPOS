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

@WebServlet(name = "ProdukController", urlPatterns = {"/pos"})
public class ProdukController extends HttpServlet {

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
        request.getRequestDispatcher("pos.jsp").forward(request, response);
    }
}