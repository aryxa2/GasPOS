<%@page import="java.util.List"%>
<%@page import="com.gaspos.model.MenuTerjual"%>
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
        .nav-item .active { border-left: 4px solid #4f46e5; background-color: #f5f3ff; color: #4f46e5 !important; border-radius: 4px; }
        .btn-cyber { background: #4f46e5; color: white; border: none; font-weight: bold; transition: background-color 0.2s ease, transform 0.1s ease; }
        .btn-cyber:hover { background: #4338ca; color: white; }
        .text-cyber { color: #4f46e5 !important; }
        .text-emerald { color: #10b981 !important; }
        .bg-emerald { background-color: #10b981 !important; }
        .btn-emerald { background: #10b981; color: white; border: none; transition: background-color 0.2s ease, transform 0.1s ease; }
        .btn-emerald:hover { background: #059669; color: white; }

        #settlementPrintArea {
            display: none;
        }

        @media print {
            /* Sembunyikan elemen web biasa */
            .container-fluid,
            .modal,
            .modal-backdrop,
            button {
                display: none !important;
            }
            
            body {
                background-color: #fff !important;
            }

            /* Tampilkan area cetak laporan */
            #settlementPrintArea {
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
    String tgl = (String) request.getAttribute("settlementDate");
    if (tgl == null) tgl = "04/06/2026";
    
    Integer totalTx = (Integer) request.getAttribute("totalTxToday");
    if (totalTx == null) totalTx = 0;
    
    Double subtotalVal = (Double) request.getAttribute("subtotalToday");
    if (subtotalVal == null) subtotalVal = 0.0;
    
    Double revenueVal = (Double) request.getAttribute("totalRevenueToday");
    if (revenueVal == null) revenueVal = 0.0;
    
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
                    <li class="nav-item"><a href="settlement" class="nav-link text-dark fw-bold active">Settlement</a></li>
                    <% if (!isKasir) { %>
                    <li class="nav-item"><a href="report" class="nav-link text-dark fw-bold">Report</a></li>
                    <li class="nav-item mt-2"><a href="setting" class="nav-link text-danger fw-bold">Setting</a></li>
                    <% } %>
                </ul>
            </div>
            <div class="mb-4">
                <hr>
                <a href="logout" class="nav-link text-secondary fw-bold"><i class="fas fa-sign-out-alt me-2"></i>Logout</a>
            </div>
        </div>
        <div class="col-md-10 p-4 offset-md-2">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="fw-bold mb-0">Settlement (Tutup Kasir)</h3>
                <button class="btn btn-cyber px-4" onclick="prepareAndPrintReport()"><i class="fas fa-print me-2"></i> Print Report</button>
            </div>
            <div class="row g-4">
                <div class="col-md-6">
                    <div class="card border-0 shadow-sm rounded-4 p-4 h-100">
                        <h6 class="text-muted fw-bold mb-3">TANGGAL</h6>
                        <h2 class="text-cyber fw-bold mb-0" id="settlementDateText"><%= tgl %></h2>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card border-0 shadow-sm rounded-4 p-4 h-100">
                        <h6 class="text-muted fw-bold mb-3">TOTAL TRANSAKSI LUNAS</h6>
                        <h2 class="fw-bold mb-0" id="settlementTotalTx"><%= totalTx %></h2>
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
                            <tbody id="menuTerjualTableBody">
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
                                            <td colspan="3" class="text-center text-muted py-3">Belum ada menu terjual hari ini</td>
                                        </tr>
                                <% 
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card border-0 shadow-sm rounded-4 p-4 h-100 d-flex flex-column">
                        <h6 class="text-muted fw-bold mb-4">RINGKASAN KEUANGAN</h6>
                        <div class="d-flex justify-content-between mb-3">
                            <span class="text-muted">Subtotal Penjualan</span>
                            <span class="fw-bold" id="subtotalPenjualanText">Rp <%= nf.format(subtotalVal) %></span>
                        </div>
                        <div class="d-flex justify-content-between mt-3">
                            <span class="text-cyber fw-bold fs-5">TOTAL PENDAPATAN</span>
                            <span class="text-cyber fw-bold fs-5" id="totalPendapatanText">Rp <%= nf.format(revenueVal) %></span>
                        </div>
                        <div class="mt-auto pt-4 d-flex gap-2">
                            <button id="btnTutupKasir" class="btn btn-danger w-50 fw-bold" data-bs-toggle="modal" data-bs-target="#confirmTutupModal">Tutup Kasir</button>
                            <button id="btnBukaKasir" class="btn btn-light w-50 border fw-bold" data-bs-toggle="modal" data-bs-target="#confirmBukaModal" disabled>Buka Kasir</button>
                        </div>
                        <div id="statusKasir" class="text-cyber mt-3 text-center small fw-bold">
                            Status: Kasir Dibuka
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Area Cetak Laporan Settlement (Hanya Muncul saat Diprint) -->
<div id="settlementPrintArea">
    <!-- Header Laporan -->
    <div style="width: 100%; font-family: 'Times New Roman', Georgia, serif; line-height: 1.2;">
        <!-- Logo -->
        <div style="float: left; width: 35%;">
            <h1 style="font-family: 'Times New Roman', Georgia, serif; font-size: 38px; font-weight: bold; margin: 0; color: #000; letter-spacing: 1px;">GasPOS</h1>
            <p style="font-size: 11px; margin: 3px 0 0 0; font-style: italic; color: #333;">BOJONGSOANG 187 • LENGKONG</p>
        </div>
        
        <!-- Judul Laporan -->
        <div style="float: left; width: 40%; text-align: center; margin-top: 10px;">
            <div style="border: 2px solid #000; padding: 6px 15px; display: inline-block; background-color: #fff; box-shadow: 4px 4px 0px #000; min-width: 250px;">
                <h3 style="font-family: 'Times New Roman', Georgia, serif; font-size: 15px; font-weight: bold; margin: 0; text-transform: uppercase; letter-spacing: 1px;">Laporan Tutup Kasir</h3>
            </div>
            <p style="font-family: 'Times New Roman', Georgia, serif; font-size: 12px; margin: 8px 0 0 0; font-weight: bold; font-style: italic;">
                (Settlement Kasir)
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

    <!-- Info Tutup Kasir -->
    <div style="border-top: 2px solid #000; border-bottom: 2px solid #000; padding: 8px 0; margin-bottom: 25px;">
        <table style="width: 100%; font-family: 'Times New Roman', Georgia, serif; font-size: 13px; border-collapse: collapse;">
            <tr>
                <td style="width: 33%;"><strong>Tanggal Laporan:</strong> <span style="font-weight: normal;" id="printReportDate">04/06/2026</span></td>
                <td style="width: 33%; text-align: center;"><strong>Status Kasir:</strong> <span style="font-weight: bold;" id="printReportStatus">Kasir Dibuka</span></td>
                <td style="width: 34%; text-align: right;"><strong>Total Transaksi Lunas:</strong> <span style="font-weight: normal;" id="printReportTotalTx">0</span></td>
            </tr>
        </table>
    </div>

    <!-- Detail Menu Terjual -->
    <div style="margin-bottom: 30px;">
        <h4 style="font-family: 'Times New Roman', Georgia, serif; font-size: 14px; font-weight: bold; border-bottom: 2px solid #000; padding-bottom: 3px; margin: 0 0 10px 0; text-transform: uppercase;">Detail Menu Terjual</h4>
        <table style="width: 100%; border-collapse: collapse; font-family: 'Times New Roman', Georgia, serif; font-size: 12px;">
            <thead>
                <tr style="font-weight: bold;">
                    <th style="text-align: left; padding: 5px 0; width: 60%; border-bottom: 1px solid #000; text-decoration: underline;">Nama Menu</th>
                    <th style="text-align: center; padding: 5px 0; width: 20%; border-bottom: 1px solid #000; text-decoration: underline;">Qty Terjual</th>
                    <th style="text-align: right; padding: 5px 0; width: 20%; border-bottom: 1px solid #000; text-decoration: underline;">Total Penjualan</th>
                </tr>
            </thead>
            <tbody id="printReportItemsBody">
                <!-- Disalin dari tabel halaman utama via JS -->
            </tbody>
        </table>
    </div>

    <!-- Ringkasan Keuangan -->
    <div style="margin-bottom: 40px; margin-top: 20px; font-family: 'Times New Roman', Georgia, serif; font-size: 13px;">
        <div style="float: right; width: 45%; border-top: 1px solid #000; padding-top: 8px;">
            <table style="width: 100%;">
                <tr>
                    <td style="text-align: left; padding: 3px 0;">Subtotal Penjualan:</td>
                    <td style="text-align: right; padding: 3px 0;" id="printReportSubtotal">Rp 0</td>
                </tr>
                <tr style="font-weight: bold; font-size: 14px; border-top: 1px dashed #000; border-bottom: 1px dashed #000;">
                    <td style="padding: 6px 0; text-align: left;">TOTAL PENDAPATAN:</td>
                    <td style="padding: 6px 0; text-align: right;" id="printReportTotalRevenue">Rp 0</td>
                </tr>
            </table>
        </div>
        <div style="clear: both;"></div>
    </div>

    <!-- Tanda Tangan Laporan -->
    <div style="margin-top: 50px; font-family: 'Times New Roman', Georgia, serif; font-size: 13px;">
        <table style="width: 100%;">
            <tr>
                <td style="width: 50%; text-align: center;">
                    <p style="margin: 0 0 60px 0;">Dipersiapkan Oleh (Kasir),</p>
                    <p style="font-weight: bold; margin: 0;">( ____________________ )</p>
                </td>
                <td style="width: 50%; text-align: center;">
                    <p style="margin: 0 0 60px 0;">Disetujui Oleh (Owner),</p>
                    <p style="font-weight: bold; margin: 0;">( ____________________ )</p>
                </td>
            </tr>
        </table>
    </div>

    <!-- Footer Struk Laporan -->
    <div style="margin-top: 60px; text-align: center; font-family: 'Times New Roman', Georgia, serif; font-size: 11px; font-style: italic; color: #333; border-top: 1px dashed #000; padding-top: 10px;">
        <p style="margin: 0;" id="printReportTimestamp">Dicetak pada: -</p>
    </div>
</div>

<!-- Modal Konfirmasi Tutup Kasir -->
<div class="modal fade" id="confirmTutupModal" tabindex="-1" aria-labelledby="confirmTutupModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title fw-bold" id="confirmTutupModalLabel"><i class="fas fa-lock me-2"></i>Tutup Kasir</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4 text-center">
                <i class="fas fa-exclamation-triangle text-danger fs-1 mb-3"></i>
                <h5 class="fw-bold text-dark">Apakah Anda yakin ingin menutup kasir?</h5>
                <p class="text-muted small mb-0">Semua transaksi hari ini akan difinalisasi dan Anda tidak dapat menambahkan transaksi baru hingga kasir dibuka kembali.</p>
            </div>
            <div class="modal-footer border-0 justify-content-center">
                <button type="button" class="btn btn-light border fw-bold px-4" data-bs-dismiss="modal">Batal</button>
                <button type="button" class="btn btn-danger fw-bold px-4" onclick="executeTutupKasir()">Ya, Tutup Kasir</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal Konfirmasi Buka Kasir -->
<div class="modal fade" id="confirmBukaModal" tabindex="-1" aria-labelledby="confirmBukaModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <div class="modal-header bg-emerald text-white">
                <h5 class="modal-title fw-bold" id="confirmBukaModalLabel"><i class="fas fa-key me-2"></i>Buka Kasir</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4 text-center">
                <i class="fas fa-door-open text-emerald fs-1 mb-3"></i>
                <h5 class="fw-bold text-dark">Apakah Anda yakin ingin membuka kasir?</h5>
                <p class="text-muted small mb-0">Kasir akan dibuka kembali untuk menerima pencatatan transaksi baru hari ini.</p>
            </div>
            <div class="modal-footer border-0 justify-content-center">
                <button type="button" class="btn btn-light border fw-bold px-4" data-bs-dismiss="modal">Batal</button>
                <button type="button" class="btn btn-emerald fw-bold px-4" onclick="executeBukaKasir()">Ya, Buka Kasir</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    let shouldLogoutAfterPrint = false;

    function executeTutupKasir() {
        let modalEl = document.getElementById('confirmTutupModal');
        let modal = bootstrap.Modal.getInstance(modalEl);
        if (modal) {
            modal.hide();
        } else {
            let myModal = bootstrap.Modal.getOrCreateInstance(modalEl);
            myModal.hide();
        }

        document.getElementById('statusKasir').innerText = "Status: Kasir Ditutup";
        document.getElementById('statusKasir').className = "text-danger mt-3 text-center small fw-bold";
        document.getElementById('btnTutupKasir').disabled = true;
        document.getElementById('btnBukaKasir').disabled = false;
        
        // Set flag to logout after print
        shouldLogoutAfterPrint = true;

        // Langsung cetak laporan harian
        prepareAndPrintReport();
    }
    
    function executeBukaKasir() {
        let modalEl = document.getElementById('confirmBukaModal');
        let modal = bootstrap.Modal.getInstance(modalEl);
        if (modal) {
            modal.hide();
        } else {
            let myModal = bootstrap.Modal.getOrCreateInstance(modalEl);
            myModal.hide();
        }

        document.getElementById('statusKasir').innerText = "Status: Kasir Dibuka";
        document.getElementById('statusKasir').className = "text-cyber mt-3 text-center small fw-bold";
        document.getElementById('btnTutupKasir').disabled = false;
        document.getElementById('btnBukaKasir').disabled = true;
        alert("Kasir berhasil dibuka.");
    }

    function prepareAndPrintReport() {
        // 1. Ambil data dari halaman utama
        let tgl = document.getElementById('settlementDateText').innerText;
        let totalTx = document.getElementById('settlementTotalTx').innerText;
        let statusText = document.getElementById('statusKasir').innerText;
        
        // Ambil subtotal dan total pendapatan
        let subtotal = document.getElementById('subtotalPenjualanText').innerText;
        let totalRevenue = document.getElementById('totalPendapatanText').innerText;

        // Set ke print area
        document.getElementById('printReportDate').innerText = tgl;
        document.getElementById('printReportStatus').innerText = statusText.replace("Status: ", "");
        
        // Ubah warna status di print area
        if (statusText.indexOf("Ditutup") !== -1) {
            document.getElementById('printReportStatus').style.color = "red";
        } else {
            document.getElementById('printReportStatus').style.color = "green";
        }
        
        document.getElementById('printReportTotalTx').innerText = totalTx;
        document.getElementById('printReportSubtotal').innerText = subtotal;
        document.getElementById('printReportTotalRevenue').innerText = totalRevenue;

        // Salin tabel menu terjual
        let originalRows = document.querySelectorAll('#menuTerjualTableBody tr');
        let printBody = document.getElementById('printReportItemsBody');
        printBody.innerHTML = '';
        
        originalRows.forEach(function(row) {
            let cols = row.querySelectorAll('td');
            if (cols.length >= 3) {
                let menuName = cols[0].innerText;
                let qty = cols[1].innerText;
                let total = cols[2].innerText;
                
                let newRow = document.createElement('tr');
                newRow.innerHTML = "<td>" + menuName + "</td>" +
                                   "<td class='text-center'>" + qty + "</td>" +
                                   "<td class='text-right'>" + total + "</td>";
                printBody.appendChild(newRow);
            }
        });

        // Waktu Cetak
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
        hours = hours ? hours : 12;
        let formattedTime2 = hours + ":" + minutes.toString().padStart(2, '0') + ":" + seconds.toString().padStart(2, '0') + " " + ampm;
        
        document.getElementById('printReportDateStr').innerText = formattedDate;
        document.getElementById('printReportTimeStr').innerText = formattedTime2;

        let dayStr = day.toString().padStart(2, '0');
        let monthStr = (now.getMonth() + 1).toString().padStart(2, '0');
        let timeStr = now.getHours().toString().padStart(2, '0') + ":" + 
                      now.getMinutes().toString().padStart(2, '0') + ":" + 
                      now.getSeconds().toString().padStart(2, '0');
        document.getElementById('printReportTimestamp').innerText = "Dicetak pada: " + dayStr + "-" + monthStr + "-" + year + " " + timeStr + " WIB";

        // Register event listener for logout after print if cashier closed
        if (shouldLogoutAfterPrint) {
            window.addEventListener('afterprint', function() {
                window.location.href = "logout";
            }, { once: true });
            
            // Safety fallback timeout in case afterprint does not fire on some older or custom browsers
            setTimeout(function() {
                window.location.href = "logout";
            }, 5000);
        }

        // Trigger print
        window.print();
    }
</script>
</body>
</html>
