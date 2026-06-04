<%-- 
    Document   : settlement
    Created on : 4 Jun 2026, 23.15.15
    Author     : Arya Satriawansyah
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Settlement - GasPOS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; }
        .sidebar { background-color: white; height: 100vh; border-right: 1px solid #eee; padding: 20px;}
        .nav-item .active { border-left: 4px solid #dc3545; background-color: #fff5f5; color: #dc3545 !important; border-radius: 4px; }
        .btn-cyber { background: linear-gradient(135deg, #00dbde 0%, #fc00ff 100%); color: white; border: none; font-weight: bold;}
        .btn-cyber:hover { opacity: 0.9; color: white; }
        .text-cyber { background: -webkit-linear-gradient(135deg, #00dbde 0%, #fc00ff 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
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
                <li class="nav-item"><a href="bills.jsp" class="nav-link text-dark fw-bold">Bills</a></li>
                <li class="nav-item"><a href="settlement.jsp" class="nav-link text-dark fw-bold active">Settlement</a></li>
                <li class="nav-item"><a href="report.jsp" class="nav-link text-dark fw-bold">Report</a></li>
                <li class="nav-item mt-2"><a href="setting.jsp" class="nav-link text-danger fw-bold">Setting</a></li>
            </ul>
        </div>
        <div class="col-md-10 p-4 offset-md-2">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="fw-bold mb-0">Settlement (Tutup Kasir)</h3>
                <button class="btn btn-cyber px-4"><i class="fas fa-print me-2"></i> Print Report</button>
            </div>
            <div class="row g-4">
                <div class="col-md-6">
                    <div class="card border-0 shadow-sm rounded-4 p-4 h-100">
                        <h6 class="text-muted fw-bold mb-3">TANGGAL</h6>
                        <h2 class="text-cyber fw-bold mb-0">04/06/2026</h2>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card border-0 shadow-sm rounded-4 p-4 h-100">
                        <h6 class="text-muted fw-bold mb-3">TOTAL TRANSAKSI LUNAS</h6>
                        <h2 class="fw-bold mb-0">1</h2>
                    </div>
                </div>
                <div class="col-md-8">
                    <div class="card border-0 shadow-sm rounded-4 p-4">
                        <h6 class="text-muted fw-bold mb-4">DETAIL MENU TERJUAL HARI INI</h6>
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light text-muted">
                                <tr>
                                    <th>MENU</th>
                                    <th class="text-center">QTY</th>
                                    <th class="text-end">TOTAL</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="fw-bold">Buku Panduan PKKMB</td>
                                    <td class="text-center">1</td>
                                    <td class="text-end fw-bold text-success">Rp 35.000</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card border-0 shadow-sm rounded-4 p-4 h-100 d-flex flex-column">
                        <h6 class="text-muted fw-bold mb-4">RINGKASAN KEUANGAN</h6>
                        <div class="d-flex justify-content-between mb-3">
                            <span class="text-muted">Subtotal Penjualan</span>
                            <span class="fw-bold">Rp 35.000</span>
                        </div>
                        <div class="d-flex justify-content-between mt-3">
                            <span class="text-cyber fw-bold fs-5">TOTAL PENDAPATAN</span>
                            <span class="text-cyber fw-bold fs-5">Rp 35.000</span>
                        </div>
                        <div class="mt-auto pt-4 d-flex gap-2">
                            <button class="btn btn-danger w-50 fw-bold">Tutup Kasir</button>
                            <button class="btn btn-light w-50 border fw-bold">Buka Kasir</button>
                        </div>
                        <div class="text-cyber mt-3 text-center small fw-bold">
                            Status: Kasir Dibuka
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
