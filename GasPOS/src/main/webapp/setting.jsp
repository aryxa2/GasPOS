<%-- 
    Document   : setting
    Created on : 4 Jun 2026, 23.34.39
    Author     : Arya Satriawansyah
--%>
<%@page import="java.util.List"%>
<%@page import="com.gaspos.model.Pengguna"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String roleAkses = (String) session.getAttribute("userRole");
    boolean isAdmin = "Admin".equals(roleAkses);
    String loggedInUsername = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Setting - GasPOS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; }
        .sidebar { background-color: white; height: 100vh; border-right: 1px solid #eee; padding: 20px;}
        .nav-item .active { border-left: 4px solid #4f46e5; background-color: #f5f3ff; color: #4f46e5 !important; border-radius: 4px; }
        .logout-btn {
            display: flex;
            align-items: center;
            padding: 10px 15px;
            color: #6c757d !important;
            background-color: #f8f9fa;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            transition: all 0.2s ease;
        }
        .logout-btn:hover {
            background-color: #fff5f5;
            color: #dc3545 !important;
        }
        .badge-aktif { background-color: #e6f4ea; color: #1e8e3e; padding: 5px 15px; border-radius: 20px; font-size: 12px; font-weight: bold;}
        .badge-nonaktif { background-color: #fff5f5; color: #dc3545; padding: 5px 15px; border-radius: 20px; font-size: 12px; font-weight: bold;}
        .badge-role { background-color: #f5f3ff; color: #4f46e5; padding: 5px 15px; border-radius: 20px; font-size: 12px; font-weight: bold;}
        .btn-cyber { background: #4f46e5; color: white; border: none; font-weight: bold; transition: background-color 0.2s ease, transform 0.1s ease; }
        .btn-cyber:hover { background: #4338ca; color: white; }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-2 sidebar fixed-top d-flex flex-column justify-content-between" style="width: 16.66%; height: 100vh;">
            <div>
                <h4 class="fw-bold mb-4 mt-2">GasPOS</h4>
                <div class="text-muted small fw-bold mb-3">MENU</div>
                <ul class="nav flex-column gap-2">
                    <li class="nav-item"><a href="pos" class="nav-link text-dark fw-bold">Daftar Menu</a></li>
                    <% if (isAdmin) { %>
                    <li class="nav-item"><a href="produk" class="nav-link text-dark fw-bold">Daftar Produk</a></li>
                    <li class="nav-item"><a href="bills" class="nav-link text-dark fw-bold">Bills</a></li>
                    <% } %>
                    <li class="nav-item"><a href="settlement" class="nav-link text-dark fw-bold">Settlement</a></li>
                    <% if (isAdmin) { %>
                    <li class="nav-item"><a href="report" class="nav-link text-dark fw-bold">Report</a></li>
                    <li class="nav-item mt-2"><a href="setting" class="nav-link text-danger fw-bold active">Setting</a></li>
                    <% } %>
                </ul>
            </div>
            <div class="mb-4">
                <hr>
                <a href="logout" class="logout-btn"><i class="fas fa-sign-out-alt me-2"></i>Logout</a>
            </div>
        </div>
        <div class="col-md-10 p-4 offset-md-2">
            
            <div id="viewList">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h3 class="fw-bold mb-0">Setting / Manajemen Kasir</h3>
                        <p class="text-muted mb-0">Kelola data karyawan dan akses sistem kasir</p>
                    </div>
                    <% if(isAdmin) { %>
                    <button class="btn btn-dark fw-bold px-4" onclick="showForm()"><i class="fas fa-plus me-2"></i> Tambah Karyawan</button>
                    <% } %>
                </div>
                <div class="card border-0 shadow-sm rounded-4 p-0 overflow-hidden">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light text-muted">
                            <tr>
                                <th class="ps-4">NAMA KARYAWAN</th>
                                <th>USERNAME</th>
                                <th>PASSWORD</th>
                                <th>ROLE</th>
                                <th>STATUS</th>
                                <% if(isAdmin) { %><th>AKSI</th><% } %>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                List<Pengguna> list = (List<Pengguna>) request.getAttribute("listUser");
                                if(list != null) {
                                    for(Pengguna u : list) { 
                                        String badgeStatus = "Aktif".equals(u.getStatus()) ? "badge-aktif" : "badge-nonaktif";
                                        String passwordTampil = isAdmin ? u.getPassword() : "***";
                            %>
                            <tr>
                                <td class="ps-4 fw-bold"><%= u.getNama() %></td>
                                <td><%= u.getUsername() %></td>
                                <td><%= passwordTampil %></td>
                                <td><span class="badge-role"><%= u.getRole() %></span></td>
                                <td><span class="<%= badgeStatus %>"><%= u.getStatus() %></span></td>
                                <% if(isAdmin) { %>
                                <td>
                                    <% if (u.getUsername() != null && !u.getUsername().equals(loggedInUsername)) { %>
                                        <form action="setting" method="POST" style="display:inline;">
                                            <input type="hidden" name="aksi" value="ubah_status">
                                            <input type="hidden" name="username" value="<%= u.getUsername() %>">
                                            <button type="submit" class="btn btn-sm btn-outline-secondary fw-bold me-1">Ubah Status</button>
                                        </form>
                                        <form action="setting" method="POST" style="display:inline;" onsubmit="return confirm('Apakah Anda yakin ingin menghapus karyawan <%= u.getNama() %>?')">
                                            <input type="hidden" name="aksi" value="hapus">
                                            <input type="hidden" name="username" value="<%= u.getUsername() %>">
                                            <button type="submit" class="btn btn-sm btn-danger text-white fw-bold">Hapus</button>
                                        </form>
                                    <% } else { %>
                                        <span class="text-muted small">Aktif (Anda)</span>
                                    <% } %>
                                </td>
                                <% } %>
                            </tr>
                            <% } } %>
                        </tbody>
                    </table>
                </div>
            </div>

            <% if(isAdmin) { %>
            <div id="viewForm" style="display: none;">
                <div class="d-flex align-items-center mb-4">
                    <button class="btn btn-link text-dark text-decoration-none fs-5 me-3 p-0" onclick="hideForm()"><i class="fas fa-arrow-left"></i></button>
                    <div>
                        <h3 class="fw-bold mb-0">Tambah Karyawan Baru</h3>
                        <p class="text-muted mb-0">Masukkan detail akun untuk akses kasir</p>
                    </div>
                </div>
                <div class="card border-0 shadow-sm rounded-4 p-4 mt-4">
                    <form action="setting" method="POST">
                        <input type="hidden" name="aksi" value="tambah">
                        <div class="row g-4 mb-4">
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Nama Lengkap</label>
                                <input type="text" class="form-control p-2" name="nama" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Role Akses</label>
                                <select class="form-select p-2" name="role">
                                    <option value="Kasir">Kasir</option>
                                    <option value="Admin">Admin</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Username</label>
                                <input type="text" class="form-control p-2" name="username" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Password</label>
                                <input type="password" class="form-control p-2" name="password" required>
                            </div>
                        </div>
                        <div class="text-end border-top pt-4">
                            <button type="button" class="btn btn-light border px-4 py-2 me-2 fw-bold" onclick="hideForm()">Batal</button>
                            <button type="submit" class="btn btn-cyber px-4 py-2 fw-bold"><i class="fas fa-save me-2"></i> Simpan Data</button>
                        </div>
                    </form>
                </div>
            </div>
            <% } %>

        </div>
    </div>
</div>

<script>
    function showForm() {
        document.getElementById('viewList').style.display = 'none';
        document.getElementById('viewForm').style.display = 'block';
    }
    function hideForm() {
        document.getElementById('viewList').style.display = 'block';
        document.getElementById('viewForm').style.display = 'none';
    }
</script>
</body>
</html>