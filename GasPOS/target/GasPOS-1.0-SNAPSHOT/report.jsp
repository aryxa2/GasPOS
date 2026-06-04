<%-- 
    Document   : report
    Created on : 4 Jun 2026, 23.34.14
    Author     : Arya Satriawansyah
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Report - GasPOS</title>
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
                <li class="nav-item"><a href="settlement.jsp" class="nav-link text-dark fw-bold">Settlement</a></li>
                <li class="nav-item"><a href="report.jsp" class="nav-link text-dark fw-bold active">Report</a></li>
                <li class="nav-item mt-2"><a href="setting.jsp" class="nav-link text-danger fw-bold">Setting</a></li>
            </ul>
        </div>
        <div class="col-md-10 p-4 offset-md-2">
            <h3 class="fw-bold mb-4">Laporan Penjualan Detail</h3>
            <div class="card border-0 shadow-sm rounded-4 p-4 mb-4">
                <div class="d-flex justify-content-between align-items-center">
                    <div class="d-flex gap-4">
                        <div>
                            <div class="text-muted small fw-bold">Dari Tanggal</div>
                            <div class="fw-bold mt-1">Semua</div>
                        </div>
                        <div>
                            <div class="text-muted small fw-bold">Sampai Tanggal</div>
                            <div class="fw-bold mt-1">04/06/2026</div>
                        </div>
                        <div class="align-self-end">
                            <button class="btn btn-cyber px-4">Filter Laporan</button>
                        </div>
                    </div>
                    <div class="d-flex gap-2">
                        <button class="btn btn-light border fw-bold"><i class="fas fa-download me-2"></i> Download PDF</button>
                        <button class="btn btn-light border fw-bold"><i class="fas fa-print me-2"></i> Cetak</button>
                    </div>
                </div>
            </div>
            <div class="row g-3 mb-4">
                <div class="col-md">
                    <div class="card border-0 shadow-sm rounded-4 p-4 h-100">
                        <h6 class="text-muted fw-bold mb-3">TOTAL TRANSAKSI</h6>
                        <h3 class="text-cyber fw-bold mb-0">2</h3>
                    </div>
                </div>
                <div class="col-md">
                    <div class="card border-0 shadow-sm rounded-4 p-4 h-100">
                        <h6 class="text-muted fw-bold mb-3">PRODUK TERJUAL</h6>
                        <h3 class="fw-bold mb-0">3</h3>
                    </div>
                </div>
                <div class="col-md">
                    <div class="card border-0 shadow-sm rounded-4 p-4 h-100">
                        <h6 class="text-muted fw-bold mb-3">TOTAL MODAL (HPP)</h6>
                        <h3 class="text-warning fw-bold mb-0">Rp 40.000</h3>
                    </div>
                </div>
                <div class="col-md">
                    <div class="card border-0 shadow-sm rounded-4 p-4 h-100">
                        <h6 class="text-muted fw-bold mb-3">TOTAL PENJUALAN</h6>
                        <h3 class="fw-bold mb-0">Rp 65.000</h3>
                    </div>
                </div>
                <div class="col-md">
                    <div class="card border-0 shadow-sm rounded-4 p-4 h-100">
                        <h6 class="text-muted fw-bold mb-3">LABA</h6>
                        <h3 class="text-success fw-bold mb-0">Rp 25.000</h3>
                    </div>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-md-7">
                    <div class="card border-0 shadow-sm rounded-4 p-4">
                        <h6 class="fw-bold mb-4">Daftar Transaksi Lunas</h6>
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light text-muted">
                                <tr>
                                    <th>ID PESANAN</th>
                                    <th>WAKTU</th>
                                    <th>KASIR</th>
                                    <th>TOTAL BAYAR</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="fw-bold">INV-20260604-2-1</td>
                                    <td>4/6/2026, 21.31.41</td>
                                    <td>Arya Satriawansyah</td>
                                    <td class="fw-bold">Rp 35.000</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">INV-20260601-1-1</td>
                                    <td>2/6/2026, 00.11.57</td>
                                    <td>Ngawi</td>
                                    <td class="fw-bold">Rp 30.000</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="col-md-5">
                    <div class="card border-0 shadow-sm rounded-4 p-4">
                        <h6 class="fw-bold mb-4">Detail Menu Terjual</h6>
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light text-muted">
                                <tr>
                                    <th>MENU</th>
                                    <th class="text-center">QTY</th>
                                    <th class="text-end">TOTAL JUAL</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="fw-bold">Buku Panduan PKKMB</td>
                                    <td class="text-center">1</td>
                                    <td class="text-end fw-bold">Rp 35.000</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">Nametag PKKMB</td>
                                    <td class="text-center">2</td>
                                    <td class="text-end fw-bold">Rp 30.000</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>