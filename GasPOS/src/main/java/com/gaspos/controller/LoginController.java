/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.gaspos.controller;

import com.gaspos.dao.UserDAO;
import com.gaspos.dao.UserDAOImpl;
import com.gaspos.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Arya Satriawansyah
 */
@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String usernameInput = request.getParameter("username");
        String passwordInput = request.getParameter("password");

        try {
            User loggedInUser = userDAO.authenticate(usernameInput, passwordInput);

            if (loggedInUser != null) {
                HttpSession session = request.getSession();
                session.setAttribute("username", loggedInUser.getUsername());
                session.setAttribute("userRole", loggedInUser.getRole());
                session.setAttribute("namaUser", loggedInUser.getNama());
                response.sendRedirect("pos");
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("loginError", "Username atau password salah!");
                response.sendRedirect("index.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = request.getSession();
            session.setAttribute("loginError", "Koneksi Database Gagal: " + e.toString());
            response.sendRedirect("index.jsp");
        }
    }
}