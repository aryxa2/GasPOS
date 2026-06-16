<%@page import="java.util.List"%>
<%@page import="com.gaspos.model.Transaksi"%>
<%@page import="com.gaspos.model.MenuTerjual"%>
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
        .nav-item .active { border-left: 4px solid #4f46e5; background-color: #f5f3ff; color: #4f46e5 !important; border-radius: 4px; }
        .btn-cyber { background: #4f46e5; color: white; border: none; font-weight: bold; transition: background-color 0.2s ease, transform 0.1s ease; }
        .btn-cyber:hover { background: #4338ca; color: white; }
        .text-cyber { color: #4f46e5 !important; }
        .text-emerald { color: #10b981 !important; }

        @media print {
            .sidebar, form, .btn {
                display: none !important;
            }
            .col-md-10 {
                width: 100% !important;
                margin-left: 0 !important;
                padding: 0 !important;
            }
            .offset-md-2 {
                margin-left: 0 !important;
            }
            body {
                background-color: #fff !important;
                font-size: 12px;
            }
            .card {
                box-shadow: none !important;
                border: 1px solid #ddd !important;
            }
        }
    </style>
</head>
<body>
<%
    String range = (String) request.getAttribute("range");
    if (range == null) range = "semua";
    
    Integer totalTx = (Integer) request.getAttribute("totalTx");
    if (totalTx == null) totalTx = 0;
    
    Integer totalQty = (Integer) request.getAttribute("totalQty");
    if (totalQty == null) totalQty = 0;
    
    Double totalHpp = (Double) request.getAttribute("totalHpp");
    if (totalHpp == null) totalHpp = 0.0;
    
    Double totalRevenue = (Double) request.getAttribute("totalRevenue");
    if (totalRevenue == null) totalRevenue = 0.0;
    
    Double laba = (Double) request.getAttribute("laba");
    if (laba == null) laba = 0.0;
    
    List<Transaksi> listTrans = (List<Transaksi>) request.getAttribute("listTransaksi");
    List<MenuTerjual> listMenu = (List<MenuTerjual>) request.getAttribute("listMenuTerjual");
    
    java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance(java.util.Locale.US);
    
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
                <li class="nav-item"><a href="bills" class="nav-link text-dark fw-bold">Bills</a></li>
                <% } %>
                <li class="nav-item"><a href="settlement" class="nav-link text-dark fw-bold">Settlement</a></li>
                <% if (!isKasir) { %>
                <li class="nav-item"><a href="report" class="nav-link text-dark fw-bold active">Report</a></li>
                <li class="nav-item mt-2"><a href="setting" class="nav-link text-danger fw-bold">Setting</a></li>
                <% } %>
                <li class="nav-item"><a href="logout" class="nav-link text-secondary fw-bold"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
            </ul>
        </div>
        <div class="col-md-10 p-4 offset-md-2">
            <h3 class="fw-bold mb-4">Laporan Penjualan Detail</h3>
            
            <form action="report" method="GET" class="card border-0 shadow-sm rounded-4 p-4 mb-4">
                <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
                    <div class="d-flex gap-3 align-items-center flex-wrap">
                        <div>
                            <label class="form-label text-muted small fw-bold mb-1">Pilih Periode Laporan</label>
                            <select name="range" class="form-select fw-bold border-2" style="min-width: 250px;" onchange="this.form.submit()">
                                <option value="semua" <%= "semua".equals(range) ? "selected" : "" %>>Semua Transaksi</option>
                                <option value="1" <%= "1".equals(range) ? "selected" : "" %>>Hari Ini (1 Hari Terakhir)</option>
                                <option value="3" <%= "3".equals(range) ? "selected" : "" %>>3 Hari Terakhir</option>
                                <option value="7" <%= "7".equals(range) ? "selected" : "" %>>7 Hari Terakhir</option>
                            </select>
                        </div>
                    </div>
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-light border fw-bold" onclick="window.print()"><i class="fas fa-print me-2"></i> Cetak Laporan</button>
                    </div>
                </div>
            </form>

            <div class="row g-3 mb-4">
                <div class="col-md">
                    <div class="card border-0 shadow-sm rounded-4 p-4 h-100">
                        <h6 class="text-muted fw-bold mb-3">TOTAL TRANSAKSI</h6>
                        <h3 class="text-cyber fw-bold mb-0"><%= totalTx %></h3>
                    </div>
                </div>
                <div class="col-md">
                    <div class="card border-0 shadow-sm rounded-4 p-4 h-100">
                        <h6 class="text-muted fw-bold mb-3">PRODUK TERJUAL</h6>
                        <h3 class="fw-bold mb-0"><%= totalQty %></h3>
                    </div>
                </div>
                <div class="col-md">
                    <div class="card border-0 shadow-sm rounded-4 p-4 h-100">
                        <h6 class="text-muted fw-bold mb-3">TOTAL MODAL (HPP)</h6>
                        <h3 class="text-warning fw-bold mb-0">Rp <%= nf.format(totalHpp) %></h3>
                    </div>
                </div>
                <div class="col-md">
                    <div class="card border-0 shadow-sm rounded-4 p-4 h-100">
                        <h6 class="text-muted fw-bold mb-3">TOTAL PENJUALAN</h6>
                        <h3 class="fw-bold mb-0">Rp <%= nf.format(totalRevenue) %></h3>
                    </div>
                </div>
                <div class="col-md">
                    <div class="card border-0 shadow-sm rounded-4 p-4 h-100">
                        <h6 class="text-muted fw-bold mb-3">LABA</h6>
                        <h3 class="text-emerald fw-bold mb-0">Rp <%= nf.format(laba) %></h3>
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
                                    <th>INVOICE</th>
                                    <th>WAKTU</th>
                                    <th>KASIR</th>
                                    <th>TOTAL BAYAR</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    if (listTrans != null && !listTrans.isEmpty()) {
                                        for (Transaksi t : listTrans) {
                                            java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm");
                                            String dateStr = t.getTanggal() != null ? sdf.format(t.getTanggal()) : "-";
                                %>
                                            <tr>
                                                <td class="fw-bold"><%= t.getNoInvoice() %></td>
                                                <td><%= dateStr %> WIB</td>
                                                <td><%= t.getKasir() %></td>
                                                <td class="fw-bold text-emerald">Rp <%= nf.format(t.getTotalBayar()) %></td>
                                            </tr>
                                <% 
                                        }
                                    } else {
                                %>
                                        <tr>
                                            <td colspan="4" class="text-center text-muted py-4">Belum ada transaksi pada periode ini</td>
                                        </tr>
                                <% 
                                    }
                                %>
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
                                <% 
                                    if (listMenu != null && !listMenu.isEmpty()) {
                                        for (MenuTerjual m : listMenu) {
                                %>
                                            <tr>
                                                <td class="fw-bold"><%= m.getNamaMenu() %></td>
                                                <td class="text-center"><%= m.getQty() %></td>
                                                <td class="text-end fw-bold text-emerald">Rp <%= nf.format(m.getTotal()) %></td>
                                            </tr>
                                <% 
                                        }
                                    } else {
                                %>
                                        <tr>
                                            <td colspan="3" class="text-center text-muted py-4">Belum ada menu terjual pada periode ini</td>
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
    </div>
</div>
</body>
</html>