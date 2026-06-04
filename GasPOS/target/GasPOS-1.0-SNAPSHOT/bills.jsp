<%-- 
    Document   : bills
    Created on : 4 Jun 2026, 23.15.06
    Author     : Arya Satriawansyah
--%>
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
        .nav-item .active { border-left: 4px solid #dc3545; background-color: #fff5f5; color: #dc3545 !important; border-radius: 4px; }
        .btn-cyber { background: linear-gradient(135deg, #00dbde 0%, #fc00ff 100%); color: white; border: none; font-weight: bold;}
        .btn-cyber:hover { opacity: 0.9; color: white; }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-2 sidebar fixed-top" style="width: 16.66%;">
            <h4 class="fw-bold mb-4 mt-2">GasPOS</h4>
            <div class="text-muted small fw-bold mb-3">MENU</div>
            <ul class="nav flex-column gap-2">
                <li class="nav-item"><a href="pos" class="nav-link text-dark fw-bold">Daftar Menu</a></li>
                <li class="nav-item"><a href="produk" class="nav-link text-dark fw-bold">Daftar Produk</a></li>
                <li class="nav-item"><a href="bills.jsp" class="nav-link text-dark fw-bold active">Bills</a></li>
                <li class="nav-item"><a href="settlement.jsp" class="nav-link text-dark fw-bold">Settlement</a></li>
                <li class="nav-item"><a href="report.jsp" class="nav-link text-dark fw-bold">Report</a></li>
                <li class="nav-item mt-2"><a href="setting.jsp" class="nav-link text-danger fw-bold">Setting</a></li>
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
                            <th>ID PESANAN</th>
                            <th>WAKTU TRANSAKSI</th>
                            <th>NAMA PELANGGAN</th>
                            <th>ITEM TERJUAL</th>
                            <th>TOTAL BAYAR</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><a href="#" class="text-decoration-none fw-bold" style="color: #00dbde;">INV-20260604-2-1</a></td>
                            <td>#2 (No: 1)</td>
                            <td>21.31 WIB</td>
                            <td>jsda</td>
                            <td>1x Buku Panduan PKKMB</td>
                            <td class="fw-bold text-success">Rp 35.000</td>
                        </tr>
                        <tr>
                            <td><a href="#" class="text-decoration-none fw-bold" style="color: #00dbde;">INV-20260601-1-1</a></td>
                            <td>#1 (No: 1)</td>
                            <td>00.11 WIB</td>
                            <td>arya test</td>
                            <td>2x Nametag PKKMB</td>
                            <td class="fw-bold text-success">Rp 30.000</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>