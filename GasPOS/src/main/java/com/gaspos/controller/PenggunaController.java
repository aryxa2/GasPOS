/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.gaspos.controller;

import com.gaspos.dao.UserDAO;
import com.gaspos.dao.UserDAOImpl;
import com.gaspos.model.Pengguna;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "PenggunaController", urlPatterns = {"/setting"})
public class PenggunaController extends HttpServlet {

    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !"Admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("pos");
            return;
        }
        try {
            List<Pengguna> listUser = userDAO.getAllPengguna();
            request.setAttribute("listUser", listUser);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Gagal mengambil data pengguna: " + e.getMessage());
        }
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

        try {
            String loggedInUsername = (String) session.getAttribute("username");
            if ("tambah".equals(aksi)) {
                String username = request.getParameter("username");
                String nama = request.getParameter("nama");
                String password = request.getParameter("password");
                String role = request.getParameter("role");

                if (username == null || username.trim().isEmpty() ||
                    nama == null || nama.trim().isEmpty() ||
                    password == null || password.trim().isEmpty()) {
                    session.setAttribute("errorSetting", "Semua field harus diisi!");
                } else if (userDAO.isUsernameExists(username)) {
                    session.setAttribute("errorSetting", "Username '" + username + "' sudah terdaftar!");
                } else {
                    Pengguna baru = new Pengguna(username, nama, password, role, "Aktif");
                    if (userDAO.addPengguna(baru)) {
                        session.setAttribute("successSetting", "Karyawan baru berhasil ditambahkan!");
                    } else {
                        session.setAttribute("errorSetting", "Gagal menambahkan karyawan!");
                    }
                }
            } else if ("ubah_status".equals(aksi)) {
                String username = request.getParameter("username");
                if (username != null && !username.equals(loggedInUsername)) {
                    if (userDAO.changeStatus(username)) {
                        session.setAttribute("successSetting", "Status karyawan berhasil diubah!");
                    } else {
                        session.setAttribute("errorSetting", "Gagal mengubah status karyawan!");
                    }
                }
            } else if ("hapus".equals(aksi)) {
                String username = request.getParameter("username");
                if (username != null && !username.equals(loggedInUsername)) {
                    if (userDAO.deletePengguna(username)) {
                        session.setAttribute("successSetting", "Karyawan berhasil dihapus!");
                    } else {
                        session.setAttribute("errorSetting", "Gagal menghapus karyawan!");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorSetting", "Terjadi kesalahan: " + e.getMessage());
        }
        response.sendRedirect("setting");
    }
}