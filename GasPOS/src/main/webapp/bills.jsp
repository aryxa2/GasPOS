<%@page import="java.util.List"%>
<%@page import="com.gaspos.model.Transaksi"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Bills - GasPOS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; }
        .sidebar { background-color: white; height: 100vh; border-right: 1px solid #eee; padding: 20px;}
        .nav-item .active { border-left: 4px solid #4f46e5; background-color: #f5f3ff; color: #4f46e5 !important; border-radius: 4px; }
        .btn-cyber { background: #4f46e5; color: white; border: none; font-weight: bold; transition: background-color 0.2s ease, transform 0.1s ease; }
        .btn-cyber:hover { background: #4338ca; color: white; }
        .text-emerald { color: #10b981 !important; }
    </style>
</head>
<%
    String roleAkses = (String) session.getAttribute("userRole");
    boolean isKasir = "Kasir".equals(roleAkses);
%>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-2 sidebar fixed-top" style="width: 16.66%;">
            <h4 class="fw-bold mb-4 mt-2">GasPOS</h4>
            <div class="text-muted small fw-bold mb-3">MENU</div>
            <ul class="nav flex-column gap-2">
                <li class="nav-item"><a href="pos" class="nav-link text-dark fw-bold">Daftar Menu</a></li>
                <% if (!isKasir) { %>
                <li class="nav-item"><a href="produk" class="nav-link text-dark fw-bold">Daftar Produk</a></li>
                <li class="nav-item"><a href="bills" class="nav-link text-dark fw-bold active">Bills</a></li>
                <% } %>
                <li class="nav-item"><a href="settlement" class="nav-link text-dark fw-bold">Settlement</a></li>
                <% if (!isKasir) { %>
                <li class="nav-item"><a href="report" class="nav-link text-dark fw-bold">Report</a></li>
                <li class="nav-item mt-2"><a href="setting" class="nav-link text-danger fw-bold">Setting</a></li>
                <% } %>
                <li class="nav-item"><a href="logout" class="nav-link text-secondary fw-bold"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
            </ul>
        </div>
        <div class="col-md-10 p-4 offset-md-2">
            <h3 class="fw-bold mb-0">Transaksi Harian (Bills)</h3>
            <p class="text-muted">Daftar pesanan yang sudah selesai pada hari ini</p>
            <div class="card border-0 shadow-sm rounded-4 p-4 mt-4">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light text-muted">
                        <tr>
                            <th>INVOICE</th>
                            <th>KASIR / METODE</th>
                            <th>WAKTU TRANSAKSI</th>
                            <th>NAMA PELANGGAN</th>
                            <th>ITEM TERJUAL</th>
                            <th>TOTAL BAYAR</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            List<Transaksi> listTrans = (List<Transaksi>) request.getAttribute("listTransaksi");
                            if (listTrans != null && !listTrans.isEmpty()) {
                                for (Transaksi t : listTrans) {
                                    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd-MM-yyyy HH:mm");
                                    String dateStr = t.getTanggal() != null ? sdf.format(t.getTanggal()) : "-";
                        %>
                                    <tr>
                                        <td><a href="#" class="text-decoration-none fw-bold" style="color: #4f46e5;"><%= t.getNoInvoice() %></a></td>
                                        <td><%= t.getKasir() %> (<%= t.getMetodePembayaran() %>)</td>
                                        <td><%= dateStr %> WIB</td>
                                        <td><%= t.getPelanggan() %></td>
                                        <td><%= t.getItemsSold() %></td>
                                        <td class="fw-bold text-emerald">Rp <%= String.format(java.util.Locale.US, "%,.0f", t.getTotalBayar()) %></td>
                                    </tr>
                        <% 
                                }
                            } else {
                        %>
                                <tr>
                                    <td colspan="6" class="text-center text-muted py-4">Belum ada transaksi hari ini</td>
                                </tr>
                        <% 
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>