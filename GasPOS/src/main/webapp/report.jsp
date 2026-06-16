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
        .btn-cyber { background: #4f46e5; color: white; border: none; font-weight: bold; transition: background-color 0.2s ease, transform 0.1s ease; }
        .btn-cyber:hover { background: #4338ca; color: white; }
        .text-cyber { color: #4f46e5 !important; }
        .text-emerald { color: #10b981 !important; }

        #reportPrintArea {
            display: none;
        }

        @media print {
            /* Sembunyikan elemen web biasa */
            .container-fluid,
            .modal,
            .modal-backdrop,
            button,
            form {
                display: none !important;
            }
            
            body {
                background-color: #fff !important;
            }

            /* Tampilkan area cetak laporan */
            #reportPrintArea {
                display: block !important;
                width: 100% !important;
                margin: 0 !important;
                padding: 20px !important;
                box-sizing: border-box !important;
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
        <div class="col-md-2 sidebar fixed-top d-flex flex-column justify-content-between" style="width: 16.66%; height: 100vh;">
            <div>
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
                </ul>
            </div>
            <div class="mb-4">
                <hr>
                <a href="logout" class="logout-btn"><i class="fas fa-sign-out-alt me-2"></i>Logout</a>
            </div>
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

<!-- Area Cetak Laporan Profesional (Hanya Muncul saat Diprint) -->
<div id="reportPrintArea">
    <!-- Header Laporan -->
    <div style="width: 100%; font-family: 'Times New Roman', Georgia, serif; line-height: 1.2;">
        <!-- Logo -->
        <div style="float: left; width: 35%;">
            <h1 style="font-family: 'Times New Roman', Georgia, serif; font-size: 38px; font-weight: bold; margin: 0; color: #000; letter-spacing: 1px;">GasPOS</h1>
            <p style="font-size: 11px; margin: 3px 0 0 0; font-style: italic; color: #333;">Premium Point of Sales System</p>
        </div>
        
        <!-- Judul Laporan -->
        <div style="float: left; width: 40%; text-align: center; margin-top: 10px;">
            <div style="border: 2px solid #000; padding: 6px 15px; display: inline-block; background-color: #fff; box-shadow: 4px 4px 0px #000; min-width: 250px;">
                <h3 style="font-family: 'Times New Roman', Georgia, serif; font-size: 16px; font-weight: bold; margin: 0; text-transform: uppercase; letter-spacing: 1px;">Laporan Penjualan Detail</h3>
            </div>
            <p style="font-family: 'Times New Roman', Georgia, serif; font-size: 12px; margin: 8px 0 0 0; font-weight: bold;">
                Periode: <%= "semua".equals(range) ? "Semua Transaksi" : range + " Hari Terakhir" %>
            </p>
        </div>
        
        <!-- Metadata -->
        <div style="float: right; width: 25%; text-align: right; font-family: 'Times New Roman', Georgia, serif; font-size: 12px; margin-top: 5px;">
            <p style="margin: 0; font-weight: bold;" id="printReportDateStr">-</p>
            <p style="margin: 3px 0 0 0;" id="printReportTimeStr">-</p>
            <p style="margin: 3px 0 0 0;">Page: 1</p>
        </div>
        <div style="clear: both; margin-bottom: 25px;"></div>
    </div>

    <!-- Ringkasan Keuangan -->
    <div style="border-top: 2px solid #000; border-bottom: 2px solid #000; padding: 8px 0; margin-bottom: 25px;">
        <table style="width: 100%; font-family: 'Times New Roman', Georgia, serif; font-size: 13px; border-collapse: collapse;">
            <tr>
                <td style="width: 20%;"><strong>Total Transaksi:</strong> <span style="font-weight: normal;"><%= totalTx %></span></td>
                <td style="width: 25%;"><strong>Produk Terjual:</strong> <span style="font-weight: normal;"><%= totalQty %> Unit</span></td>
                <td style="width: 25%;"><strong>Total HPP:</strong> <span style="font-weight: normal;">Rp <%= nf.format(totalHpp) %></span></td>
                <td style="width: 30%; text-align: right;"><strong>Laba Bersih:</strong> <span style="font-weight: bold;">Rp <%= nf.format(laba) %></span></td>
            </tr>
        </table>
    </div>

    <!-- Tabel 1: Detail Transaksi Per Kasir -->
    <div style="margin-bottom: 30px;">
        <h4 style="font-family: 'Times New Roman', Georgia, serif; font-size: 14px; font-weight: bold; border-bottom: 2px solid #000; padding-bottom: 3px; margin: 0 0 10px 0; text-transform: uppercase;">Detail Transaksi Per Kasir</h4>
        <table style="width: 100%; border-collapse: collapse; font-family: 'Times New Roman', Georgia, serif; font-size: 12px;">
            <thead>
                <tr style="font-weight: bold;">
                    <th style="text-align: left; padding: 5px 0; width: 15%; border-bottom: 1px solid #000; text-decoration: underline;">Kasir</th>
                    <th style="text-align: left; padding: 5px 0; width: 25%; border-bottom: 1px solid #000; text-decoration: underline;">No. Invoice</th>
                    <th style="text-align: left; padding: 5px 0; width: 20%; border-bottom: 1px solid #000; text-decoration: underline;">Pelanggan</th>
                    <th style="text-align: left; padding: 5px 0; width: 15%; border-bottom: 1px solid #000; text-decoration: underline;">Metode</th>
                    <th style="text-align: left; padding: 5px 0; width: 13%; border-bottom: 1px solid #000; text-decoration: underline;">Waktu</th>
                    <th style="text-align: right; padding: 5px 0; width: 12%; border-bottom: 1px solid #000; text-decoration: underline;">Total</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    if (listTrans != null && !listTrans.isEmpty()) {
                        String currentKasir = "";
                        for (Transaksi t : listTrans) {
                            java.text.SimpleDateFormat sdfPrint = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm");
                            String dateStr = t.getTanggal() != null ? sdfPrint.format(t.getTanggal()) : "-";
                            
                            boolean showKasirHeader = !t.getKasir().equals(currentKasir);
                            if (showKasirHeader) {
                                currentKasir = t.getKasir();
                            }
                %>
                            <tr>
                                <td style="padding: 5px 0; font-weight: bold; vertical-align: top;"><%= showKasirHeader ? currentKasir : "" %></td>
                                <td style="padding: 5px 0; vertical-align: top;"><%= t.getNoInvoice() %></td>
                                <td style="padding: 5px 0; vertical-align: top;"><%= t.getPelanggan() %></td>
                                <td style="padding: 5px 0; vertical-align: top;"><%= t.getMetodePembayaran() %></td>
                                <td style="padding: 5px 0; vertical-align: top;"><%= dateStr %></td>
                                <td style="padding: 5px 0; text-align: right; vertical-align: top;">Rp <%= nf.format(t.getTotalBayar()) %></td>
                            </tr>
                <% 
                        }
                    } else {
                %>
                        <tr>
                            <td colspan="6" style="padding: 12px 0; text-align: center; font-style: italic; color: #444;">Belum ada transaksi</td>
                        </tr>
                <% 
                    }
                %>
            </tbody>
        </table>
    </div>

    <!-- Tabel 2: Ringkasan Menu Terjual -->
    <div style="margin-bottom: 40px;">
        <h4 style="font-family: 'Times New Roman', Georgia, serif; font-size: 14px; font-weight: bold; border-bottom: 2px solid #000; padding-bottom: 3px; margin: 0 0 10px 0; text-transform: uppercase;">Ringkasan Menu Terjual</h4>
        <table style="width: 100%; border-collapse: collapse; font-family: 'Times New Roman', Georgia, serif; font-size: 12px;">
            <thead>
                <tr style="font-weight: bold;">
                    <th style="text-align: left; padding: 5px 0; width: 60%; border-bottom: 1px solid #000; text-decoration: underline;">Nama Menu</th>
                    <th style="text-align: center; padding: 5px 0; width: 20%; border-bottom: 1px solid #000; text-decoration: underline;">Qty Terjual</th>
                    <th style="text-align: right; padding: 5px 0; width: 20%; border-bottom: 1px solid #000; text-decoration: underline;">Total Penjualan</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    if (listMenu != null && !listMenu.isEmpty()) {
                        for (MenuTerjual m : listMenu) {
                %>
                            <tr>
                                <td style="padding: 5px 0;"><%= m.getNamaMenu() %></td>
                                <td style="padding: 5px 0; text-align: center;"><%= m.getQty() %></td>
                                <td style="padding: 5px 0; text-align: right;">Rp <%= nf.format(m.getTotal()) %></td>
                            </tr>
                <% 
                        }
                    } else {
                %>
                        <tr>
                            <td colspan="3" style="padding: 12px 0; text-align: center; font-style: italic; color: #444;">Belum ada menu terjual</td>
                        </tr>
                <% 
                    }
                %>
            </tbody>
        </table>
    </div>

    <!-- Tanda Tangan Laporan -->
    <div style="margin-top: 50px; font-family: 'Times New Roman', Georgia, serif; font-size: 13px;">
        <table style="width: 100%;">
            <tr>
                <td style="width: 50%; text-align: center;">
                    <p style="margin: 0 0 60px 0;">Dipersiapkan Oleh,</p>
                    <p style="font-weight: bold; margin: 0;">( ____________________ )</p>
                    <p style="margin: 5px 0 0 0; font-size: 11px; font-style: italic; color: #333;">Admin Kasir</p>
                </td>
                <td style="width: 50%; text-align: center;">
                    <p style="margin: 0 0 60px 0;">Disetujui Oleh,</p>
                    <p style="font-weight: bold; margin: 0;">( ____________________ )</p>
                    <p style="margin: 5px 0 0 0; font-size: 11px; font-style: italic; color: #333;">Supervisor / Owner</p>
                </td>
            </tr>
        </table>
    </div>

    <!-- Footer Struk Laporan -->
    <div style="margin-top: 60px; text-align: center; font-family: 'Times New Roman', Georgia, serif; font-size: 11px; font-style: italic; color: #333; border-top: 1px dashed #000; padding-top: 10px;">
        <p style="margin: 0;" id="printReportTimestampStr"></p>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        let now = new Date();
        const months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
        
        let monthName = months[now.getMonth()];
        let day = now.getDate();
        let year = now.getFullYear();
        let formattedDate = monthName + " " + day + ", " + year;
        
        let hours = now.getHours();
        let minutes = now.getMinutes();
        let seconds = now.getSeconds();
        let ampm = hours >= 12 ? 'pm' : 'am';
        hours = hours % 12;
        hours = hours ? hours : 12; // 0 should be 12
        let formattedTime = hours + ":" + minutes.toString().padStart(2, '0') + ":" + seconds.toString().padStart(2, '0') + " " + ampm;
        
        document.getElementById('printReportDateStr').innerText = formattedDate;
        document.getElementById('printReportTimeStr').innerText = formattedTime;
        
        // Timestamp at the bottom
        let dayStr = day.toString().padStart(2, '0');
        let monthStr = (now.getMonth() + 1).toString().padStart(2, '0');
        let timeStr = now.getHours().toString().padStart(2, '0') + ":" + 
                      now.getMinutes().toString().padStart(2, '0') + ":" + 
                      now.getSeconds().toString().padStart(2, '0');
        document.getElementById('printReportTimestampStr').innerText = "Dicetak pada: " + dayStr + "-" + monthStr + "-" + year + " " + timeStr + " WIB";
    });
</script>
</body>
</html>