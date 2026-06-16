package com.gaspos.dao;

import com.gaspos.config.Database;
import com.gaspos.model.User;
import com.gaspos.model.Kasir;
import com.gaspos.model.Admin;
import com.gaspos.model.Pengguna;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Arya Satriawansyah
 */
public class UserDAOImpl implements UserDAO {

    @Override
    public User authenticate(String username, String password) throws Exception {
        try (Connection conn = Database.getConnection()) {
            String sql = "SELECT * FROM pengguna WHERE username = ? AND password_hash = ? AND status = 'Aktif'";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String role = rs.getString("role");
                String nama = rs.getString("nama");
                String passHash = rs.getString("password_hash");

                if ("Admin".equalsIgnoreCase(role)) {
                    Admin admin = new Admin(username, nama, passHash);
                    if (admin.login(username, password)) {
                        return admin;
                    }
                } else if ("Kasir".equalsIgnoreCase(role)) {
                    Kasir kasir = new Kasir(username, nama, passHash);
                    if (kasir.login(username, password)) {
                        return kasir;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return null;
    }

    @Override
    public List<Pengguna> getAllPengguna() throws Exception {
        List<Pengguna> list = new ArrayList<>();
        try (Connection conn = Database.getConnection()) {
            String sql = "SELECT * FROM pengguna";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Pengguna(
                    rs.getString("username"),
                    rs.getString("nama"),
                    rs.getString("password_hash"),
                    rs.getString("role"),
                    rs.getString("status")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return list;
    }

    @Override
    public boolean addPengguna(Pengguna pengguna) throws Exception {
        try (Connection conn = Database.getConnection()) {
            String sql = "INSERT INTO pengguna (username, nama, password_hash, role, status) VALUES (?, ?, ?, ?, 'Aktif')";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, pengguna.getUsername());
            ps.setString(2, pengguna.getNama());
            ps.setString(3, pengguna.getPassword());
            ps.setString(4, pengguna.getRole());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public boolean changeStatus(String username) throws Exception {
        try (Connection conn = Database.getConnection()) {
            String sql = "UPDATE pengguna SET status = IF(status='Aktif', 'Nonaktif', 'Aktif') WHERE username = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public boolean deletePengguna(String username) throws Exception {
        try (Connection conn = Database.getConnection()) {
            String sql = "DELETE FROM pengguna WHERE username = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public boolean isUsernameExists(String username) throws Exception {
        try (Connection conn = Database.getConnection()) {
            String sql = "SELECT COUNT(*) FROM pengguna WHERE username = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return false;
    }
}
