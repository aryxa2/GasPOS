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
                Pengguna baru = new Pengguna(
                    request.getParameter("username"),
                    request.getParameter("nama"),
                    request.getParameter("password"),
                    request.getParameter("role"),
                    "Aktif"
                );
                userDAO.addPengguna(baru);
            } else if ("ubah_status".equals(aksi)) {
                String username = request.getParameter("username");
                if (username != null && !username.equals(loggedInUsername)) {
                    userDAO.changeStatus(username);
                }
            } else if ("hapus".equals(aksi)) {
                String username = request.getParameter("username");
                if (username != null && !username.equals(loggedInUsername)) {
                    userDAO.deletePengguna(username);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("setting");
    }
}