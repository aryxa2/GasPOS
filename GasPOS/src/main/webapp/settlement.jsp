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

        /* Area Cetak Laporan Settlement (Disembunyikan pada web) */
        #settlementPrintArea {
            display: none;
        }

        @media print {
            html, body {
                width: 100% !important;
                height: auto !important;
                margin: 0 !important;
                padding: 0 !important;
                background-color: #fff !important;
            }

            /* Sembunyikan semua elemen web biasa */
            .container-fluid,
            .modal,
            .modal-backdrop,
            button {
                display: none !important;
            }

            /* Tampilkan dan posisikan area cetak laporan */
            #settlementPrintArea {
                display: block !important;
                width: 85% !important;
                max-width: 650px !important;
                margin: 40px auto !important;
                padding: 30px !important;
                font-family: 'Courier New', Courier, monospace;
                font-size: 14px;
                line-height: 1.6;
                color: #000;
                background-color: #fff !important;
                border: 1px solid #000 !important;
                border-radius: 6px !important;
                box-sizing: border-box !important;
            }

            #settlementPrintArea .report-header {
                text-align: center;
                margin-bottom: 20px;
            }

            #settlementPrintArea .logo {
                font-size: 28px;
                font-weight: bold;
                letter-spacing: 4px;
                margin: 0 0 8px 0;
                text-transform: uppercase;
                border-bottom: 2px solid #000;
                display: inline-block;
                padding-bottom: 4px;
            }

            #settlementPrintArea .store-details {
                font-size: 13px;
                line-height: 1.4;
            }

            #settlementPrintArea .store-details p {
                margin: 2px 0;
            }

            #settlementPrintArea .report-title {
                font-size: 18px;
                font-weight: bold;
                margin: 15px 0;
                letter-spacing: 2px;
            }

            #settlementPrintArea .separator {
                margin: 15px 0 !important;
                height: 0;
                border-top: none !important;
                border-left: none !important;
                border-right: none !important;
            }

            #settlementPrintArea .separator-double {
                border-bottom: 3px double #000 !important;
            }

            #settlementPrintArea .separator-dashed {
                border-bottom: 1px dashed #000 !important;
            }

            #settlementPrintArea table {
                width: 100%;
                border-collapse: collapse;
            }

            #settlementPrintArea th {
                font-weight: bold;
                border-bottom: 1px dashed #000;
                padding-bottom: 6px;
                text-align: left;
                font-size: 13px;
            }

            #settlementPrintArea td {
                padding: 6px 0;
                vertical-align: top;
                font-size: 13px;
            }

            #settlementPrintArea .text-right {
                text-align: right !important;
            }

            #settlementPrintArea .text-center {
                text-align: center !important;
            }

            #settlementPrintArea .fw-bold {
                font-weight: bold;
            }

            #settlementPrintArea .section-title {
                font-size: 14px;
                font-weight: bold;
                margin: 15px 0 8px 0;
                letter-spacing: 1px;
            }

            #settlementPrintArea .report-signatures {
                margin-top: 50px;
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
        <div class="col-md-2 sidebar fixed-top" style="width: 16.66%;">
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
                <li class="nav-item"><a href="logout" class="nav-link text-secondary fw-bold"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
            </ul>
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
                                                <td class="text-end fw-bold text-emerald">Rp <%= nf.format(m.getTotal()).replace(",", ".") %></td>
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
                            <span class="fw-bold" id="subtotalPenjualanText">Rp <%= nf.format(subtotalVal).replace(",", ".") %></span>
                        </div>
                        <div class="d-flex justify-content-between mt-3">
                            <span class="text-cyber fw-bold fs-5">TOTAL PENDAPATAN</span>
                            <span class="text-cyber fw-bold fs-5" id="totalPendapatanText">Rp <%= nf.format(revenueVal).replace(",", ".") %></span>
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
    <div class="report-header text-center">
        <h1 class="logo">GasPOS</h1>
        <div class="store-details">
            <p>BOJONGSOANG 187</p>
            <p>081294658263</p>
            <p>LENGKONG, BOJONGSOANG</p>
            <p>JL. RAYA BOJONGSOANG NO. 187 RT. 001 RW. 002</p>
        </div>
        <div class="separator separator-double"></div>
        <h3 class="report-title">LAPORAN SETTLEMENT KASIR</h3>
        <div class="separator separator-dashed"></div>
    </div>

    <div class="report-info">
        <table>
            <tr>
                <td>Tanggal Laporan :</td>
                <td class="text-right fw-bold" id="printReportDate">04/06/2026</td>
            </tr>
            <tr>
                <td>Status Kasir :</td>
                <td class="text-right fw-bold text-success" id="printReportStatus">Kasir Dibuka</td>
            </tr>
            <tr>
                <td>Total Transaksi Lunas :</td>
                <td class="text-right fw-bold" id="printReportTotalTx">1</td>
            </tr>
        </table>
        <div class="separator separator-dashed"></div>
    </div>

    <div class="report-items">
        <h5 class="section-title">DETAIL MENU TERJUAL</h5>
        <table>
            <thead>
                <tr>
                    <th style="width: 50%;">Nama Menu</th>
                    <th class="text-center" style="width: 15%;">Qty</th>
                    <th class="text-right" style="width: 35%;">Total</th>
                </tr>
            </thead>
            <tbody id="printReportItemsBody">
                <!-- Disalin dari tabel halaman utama via JS -->
            </tbody>
        </table>
        <div class="separator separator-dashed"></div>
    </div>

    <div class="report-totals">
        <table>
            <tr>
                <td>Subtotal Penjualan</td>
                <td class="text-right" id="printReportSubtotal">Rp 35.000</td>
            </tr>
            <tr style="font-weight: bold; border-top: 1px dashed #000; border-bottom: 1px dashed #000;">
                <td style="padding: 8px 0;">TOTAL PENDAPATAN</td>
                <td class="text-right" style="padding: 8px 0;" id="printReportTotalRevenue">Rp 35.000</td>
            </tr>
        </table>
    </div>

    <div class="report-signatures">
        <table style="width: 100%; margin-top: 50px;">
            <tr>
                <td style="width: 50%; text-align: center;">
                    <p>Kasir,</p>
                    <br><br><br>
                    <p class="fw-bold">( ____________________ )</p>
                </td>
                <td style="width: 50%; text-align: center;">
                    <p>Supervisor / Owner,</p>
                    <br><br><br>
                    <p class="fw-bold">( ____________________ )</p>
                </td>
            </tr>
        </table>
    </div>

    <div class="report-footer text-center" style="margin-top: 40px;">
        <div class="separator separator-double"></div>
        <p class="small text-muted" id="printReportTimestamp">Dicetak pada: -</p>
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
            document.getElementById('printReportStatus').className = "text-right fw-bold text-danger";
        } else {
            document.getElementById('printReportStatus').className = "text-right fw-bold text-success";
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
        let formattedTime = now.getDate().toString().padStart(2, '0') + "-" + 
                            (now.getMonth() + 1).toString().padStart(2, '0') + "-" + 
                            now.getFullYear() + " " + 
                            now.getHours().toString().padStart(2, '0') + ":" + 
                            now.getMinutes().toString().padStart(2, '0') + ":" + 
                            now.getSeconds().toString().padStart(2, '0');
        document.getElementById('printReportTimestamp').innerText = "Dicetak pada: " + formattedTime;

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
