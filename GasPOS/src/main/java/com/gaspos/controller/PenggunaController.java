/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.gaspos.controller;

import com.gaspos.config.Database;
import com.gaspos.model.Pengguna;
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

/**
 *
 * @author Arya Satriawansyah
 */
import javax.servlet.http.HttpSession;

@WebServlet(name = "PenggunaController", urlPatterns = {"/setting"})
public class PenggunaController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !"Admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("pos");
            return;
        }
        List<Pengguna> listUser = new ArrayList<>();
        try (Connection conn = Database.getConnection()) {
            String sql = "SELECT * FROM pengguna";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                listUser.add(new Pengguna(rs.getString("username"), rs.getString("nama"), rs.getString("password_hash"), rs.getString("role"), rs.getString("status")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("listUser", listUser);
        request.getRequestDispatcher("setting.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !"Admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("pos");
            return;
        }
        String aksi = request.getParameter("aksi");

        try (Connection conn = Database.getConnection()) {
            if ("tambah".equals(aksi)) {
                String sql = "INSERT INTO pengguna (username, nama, password_hash, role, status) VALUES (?, ?, ?, ?, 'Aktif')";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, request.getParameter("username"));
                ps.setString(2, request.getParameter("nama"));
                ps.setString(3, request.getParameter("password"));
                ps.setString(4, request.getParameter("role"));
                ps.executeUpdate();
            } else if ("ubah_status".equals(aksi)) {
                String sql = "UPDATE pengguna SET status = IF(status='Aktif', 'Nonaktif', 'Aktif') WHERE username = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, request.getParameter("username"));
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("setting");
    }
}