<%-- Document : pos Created on : 4 Jun 2026, 22.55.07 Author : Arya Satriawansyah --%>
  <%@page import="java.util.List" %>
    <%@page import="com.gaspos.model.Produk" %>
      <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html>

        <head>
          <title>Menu Kasir - GasPOS</title>
          <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
          <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
          <style>
            body {
              background-color: #f8f9fa;
            }

            .sidebar {
              background-color: white;
              height: 100vh;
              border-right: 1px solid #eee;
              padding: 20px;
            }

            .nav-item .active {
              border-left: 4px solid #4f46e5;
              background-color: #f5f3ff;
              color: #4f46e5 !important;
              border-radius: 4px;
            }

            .product-card {
              border-radius: 12px;
              border: none;
              box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
              text-align: center;
              transition: transform 0.3s cubic-bezier(0.25, 0.8, 0.25, 1), box-shadow 0.3s ease;
              width: 100%;
              overflow: hidden;
              display: flex;
              flex-direction: column;
              height: 100%;
              background: white;
            }

            .product-card:hover {
              transform: translateY(-8px);
              box-shadow: 0 12px 20px rgba(0, 0, 0, 0.08), 0 0 15px rgba(0, 219, 222, 0.12);
            }

            .product-img {
              width: 100%;
              aspect-ratio: 1 / 1;
              object-fit: cover;
              transition: transform 0.5s cubic-bezier(0.25, 0.8, 0.25, 1);
            }

            .product-card:hover .product-img {
              transform: scale(1.06);
            }

            .product-body {
              padding: 15px 12px;
              display: flex;
              flex-direction: column;
              flex-grow: 1;
              justify-content: space-between;
              align-items: center;
              z-index: 2;
            }

            .product-info-wrap {
              width: 100%;
              margin-bottom: 12px;
            }

            .product-title {
              font-weight: bold;
              color: #212529;
              font-size: 0.95rem;
              line-height: 1.3;
              margin-bottom: 4px;
              display: -webkit-box;
              -webkit-line-clamp: 2;
              -webkit-box-orient: vertical;
              overflow: hidden;
              text-overflow: ellipsis;
            }

            .product-price {
              color: #4f46e5;
              font-weight: 700;
              font-size: 0.95rem;
            }

            .btn-cyber {
              background: #4f46e5;
              color: white;
              border: none;
              border-radius: 20px;
              font-weight: bold;
              max-width: 150px;
              width: 100%;
              margin: 0 auto;
              display: block;
              transition: transform 0.2s ease, background-color 0.2s ease, box-shadow 0.2s ease;
            }

            .btn-cyber:hover {
              transform: scale(1.05);
              background: #4338ca;
              box-shadow: 0 4px 12px rgba(79, 70, 229, 0.25);
              color: white;
            }

            .btn-cyber:active {
              transform: scale(0.95);
            }

            .btn-checkout {
              background: #4f46e5;
              color: white;
              border: none;
              transition: background-color 0.2s ease, transform 0.1s ease, box-shadow 0.2s ease;
            }

            .btn-checkout:hover {
              background: #4338ca;
              box-shadow: 0 4px 12px rgba(79, 70, 229, 0.25);
              color: white;
            }

            .btn-checkout:active {
              transform: scale(0.98);
            }

            .btn-emerald {
              background: #10b981;
              color: white;
              border: none;
              transition: background-color 0.2s ease, transform 0.1s ease, box-shadow 0.2s ease;
            }

            .btn-emerald:hover {
              background: #059669;
              box-shadow: 0 4px 12px rgba(16, 185, 129, 0.25);
              color: white;
            }

            .btn-emerald:active {
              transform: scale(0.98);
            }

            .cart-card {
              border: 1px solid #eee;
              border-radius: 8px;
              padding: 15px;
              margin-bottom: 10px;
              background: #fff;
            }

            .qty-btn {
              width: 30px;
              height: 30px;
              padding: 0;
              display: inline-flex;
              justify-content: center;
              align-items: center;
              border-radius: 4px;
            }

            /* CSS untuk Print Struk Kasir */
            #receiptPrintArea {
              display: none;
            }

            @media print {

              html,
              body {
                width: 100% !important;
                height: auto !important;
                margin: 0 !important;
                padding: 0 !important;
                background-color: #fff !important;
              }

              /* Sembunyikan seluruh dashboard utama dan modal */
              .container-fluid,
              .modal,
              .modal-backdrop {
                display: none !important;
              }

              /* Tampilkan dan posisikan area cetak struk (ditengah halaman print A4) */
              #receiptPrintArea {
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

              #receiptPrintArea .receipt-header {
                text-align: center;
                margin-bottom: 15px;
              }

              #receiptPrintArea .logo {
                font-size: 26px;
                font-weight: bold;
                letter-spacing: 4px;
                margin: 0 0 8px 0;
                text-transform: uppercase;
                border-bottom: 2px solid #000;
                display: inline-block;
                padding-bottom: 4px;
              }

              #receiptPrintArea .receipt-store-details {
                font-size: 13px;
                line-height: 1.4;
              }

              #receiptPrintArea .receipt-store-details p {
                margin: 2px 0;
              }

              #receiptPrintArea .separator {
                margin: 15px 0 !important;
                height: 0;
                border-top: none !important;
                border-left: none !important;
                border-right: none !important;
              }

              #receiptPrintArea .separator-double {
                border-bottom: 3px double #000 !important;
              }

              #receiptPrintArea .separator-dashed {
                border-bottom: 1px dashed #000 !important;
              }

              #receiptPrintArea table {
                width: 100%;
                border-collapse: collapse;
              }

              #receiptPrintArea th {
                font-weight: bold;
                border-bottom: 1px dashed #000;
                padding-bottom: 6px;
                text-align: left;
                font-size: 13px;
              }

              #receiptPrintArea td {
                padding: 6px 0;
                vertical-align: top;
                font-size: 13px;
              }

              #receiptPrintArea .text-right {
                text-align: right !important;
              }

              #receiptPrintArea .text-center {
                text-align: center !important;
              }

              #receiptPrintArea .fw-bold {
                font-weight: bold;
              }

              #receiptPrintArea .small-note {
                font-size: 11px;
                margin: 10px 0;
                font-style: italic;
              }

              #receiptPrintArea .receipt-status-lunas {
                margin: 20px 0 15px 0;
                text-align: center;
              }

              #receiptPrintArea .receipt-status-lunas h3 {
                border: 2px solid #000;
                display: inline-block;
                padding: 6px 24px;
                font-weight: bold;
                letter-spacing: 6px;
                margin: 0;
                font-size: 18px;
                text-transform: uppercase;
              }

              #receiptPrintArea .receipt-footer {
                text-align: center;
                font-size: 13px;
              }

              #receiptPrintArea .receipt-footer p {
                margin: 4px 0;
              }
            }
          </style>
        </head>

        <body>
          <%
            String userRole = (String) session.getAttribute("userRole");
            boolean isKasir = "Kasir".equals(userRole);
          %>
          <div class="container-fluid">
            <div class="row">
              <div class="col-md-2 sidebar fixed-top d-flex flex-column justify-content-between" style="width: 16.66%; height: 100vh;">
                <div>
                  <h4 class="fw-bold mb-4 mt-2">GasPOS</h4>
                  <div class="text-muted small fw-bold mb-3">MENU</div>
                  <ul class="nav flex-column gap-2">
                    <li class="nav-item"><a href="pos" class="nav-link text-dark fw-bold active">Daftar Menu</a></li>
                    <% if (!isKasir) { %>
                    <li class="nav-item"><a href="produk" class="nav-link text-dark fw-bold">Daftar Produk</a></li>
                    <li class="nav-item"><a href="bills" class="nav-link text-dark fw-bold">Bills</a></li>
                    <% } %>
                    <li class="nav-item"><a href="settlement" class="nav-link text-dark fw-bold">Settlement</a></li>
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

              <div class="col-md-7 p-4 offset-md-2">
                <h3 class="fw-bold">Peralatan PKKMB & Kuliah</h3>
                <p class="text-muted">Pilih perlengkapan mahasiswa baru untuk ditambahkan ke order</p>
                <div class="row g-2 mt-2">
                  <% List<Produk> list = (List<Produk>) request.getAttribute("daftarProduk");
                      if(list != null) {
                      for(Produk p : list) {
                          if (isKasir && p.getStok() <= 0) {
                              continue;
                          }
                          String img = p.getGambar() != null && !p.getGambar().isEmpty() ? p.getGambar() :
                          "https://via.placeholder.com/150";
                          %>
                          <div class="col-md-3">
                            <div class="product-card bg-white h-100">
                              <img src="<%= img %>" class="product-img" alt="Produk">
                              <div class="product-body">
                                <div class="product-info-wrap">
                                  <div class="product-title">
                                    <%= p.getNamaProduk() %>
                                  </div>
                                  <div class="product-price">Rp <%= java.text.NumberFormat.getNumberInstance(java.util.Locale.US).format((int) p.getHargaJual()) %>
                                  </div>
                                </div>
                                <button class="btn btn-cyber"
                                  onclick="addToCart('<%= p.getIdProduk() %>', '<%= p.getNamaProduk() %>', <%= (int) p.getHargaJual() %>)">+
                                  ADD</button>
                              </div>
                            </div>
                          </div>
                      <% } } %>
                </div>
              </div>

              <div class="col-md-3 bg-white p-4 d-flex flex-column fixed-top offset-md-9"
                style="height: 100vh; border-left: 1px solid #eee; width: 25%;">
                <h5 class="fw-bold d-flex justify-content-between align-items-center">
                  <span><i class="fas fa-shopping-cart me-2"></i> Order List</span>
                  <span class="fs-6 text-muted fw-normal" id="item-count">0 item</span>
                </h5>
                <hr>
                <div id="cart-items" class="mt-2 flex-grow-1 overflow-auto">
                  <div class="text-center text-muted mt-5">Order masih kosong</div>
                </div>
                <div class="mt-auto border-top pt-3">
                  <div class="d-flex justify-content-between mb-2 text-muted">
                    <span>Subtotal</span><span id="subtotal-price">Rp 0</span>
                  </div>
                  <div class="d-flex justify-content-between mb-3 text-muted">
                    <span>Pajak (0%)</span><span>Rp 0</span>
                  </div>
                  <div class="d-flex justify-content-between fs-4 fw-bold mb-4">
                    <span>Total</span><span id="total-price" style="color: #4f46e5;">Rp 0</span>
                  </div>
                  <button class="btn btn-checkout w-100 p-3 fw-bold rounded-3" onclick="buatTagihan()"><i
                      class="fas fa-credit-card me-2"></i> Buat Tagihan</button>
                </div>
              </div>
            </div>
          </div>

          <script>
            let orderList = [];

            function addToCart(id, nama, harga) {
              let item = orderList.find(i => i.id === id);
              if (item) { item.qty++; } else { orderList.push({ id: id, nama: nama, harga: harga, qty: 1 }); }
              renderCart();
            }

            function updateQty(id, change) {
              let item = orderList.find(i => i.id === id);
              if (item) {
                item.qty += change;
                if (item.qty <= 0) { orderList = orderList.filter(i => i.id !== id); }
                renderCart();
              }
            }

            let pendingRemoveId = null;

            function removeItem(id) {
              let item = orderList.find(i => i.id === id);
              if (item) {
                pendingRemoveId = id;
                document.getElementById('removeProductName').innerText = item.nama;
                var myModal = new bootstrap.Modal(document.getElementById('confirmRemoveModal'));
                myModal.show();
              }
            }

            function renderCart() {
              let cartContainer = document.getElementById("cart-items");
              let total = 0; let count = 0;

              if (orderList.length === 0) {
                cartContainer.innerHTML = "<div class='text-center text-muted mt-5'>Order masih kosong</div>";
              } else {
                cartContainer.innerHTML = "";
                orderList.forEach(item => {
                  total += (item.qty * item.harga);
                  count += item.qty;
                  cartContainer.innerHTML +=
                    "<div class='cart-card d-flex justify-content-between align-items-center'>" +
                    "<div>" +
                    "<div class='fw-bold text-dark'>" + item.nama + "</div>" +
                    " <div class='text-success small'>Rp " + Number(item.harga).toLocaleString('en-US') + "</div>" +
                    "</div>" +
                    "<div class='d-flex align-items-center gap-2'>" +
                    "<button class='btn btn-light border qty-btn' onclick=\"updateQty('" + item.id + "', -1)\">-</button>" +
                    "<span class='fw-bold mx-1'>" + item.qty + "</span>" +
                    "<button class='btn btn-light border qty-btn' onclick=\"updateQty('" + item.id + "', 1)\">+</button>" +
                    "<button class='btn btn-danger text-white qty-btn ms-2' onclick=\"removeItem('" + item.id + "')\"><i class='fas fa-trash'></i></button>" +
                    "</div>" +
                    "</div>";
                });
              }
              document.getElementById("item-count").innerText = count + " item";
              document.getElementById("subtotal-price").innerText = "Rp " + total.toLocaleString('en-US');
              document.getElementById("total-price").innerText = "Rp " + total.toLocaleString('en-US');
            }

            let currentTotal = 0;

            function buatTagihan() {
              if (orderList.length === 0) {
                alert("Keranjang belanja masih kosong!");
                return;
              }
              currentTotal = 0;
              orderList.forEach(item => currentTotal += (item.qty * item.harga));

              // Reset modal steps
              document.getElementById('paymentStepSelect').classList.remove('d-none');
              document.getElementById('paymentStepSuccess').classList.add('d-none');
              document.getElementById('btnConfirmPayment').disabled = false;

              // Reset inputs
              document.getElementById('inputCashReceived').value = '';
              document.getElementById('textCashChange').innerText = 'Rp 0';
              document.getElementById('textCashChange').className = 'fw-bold text-success mb-0';
              document.getElementById('inputWalletPhone').value = '';

              // Set total amount
              document.getElementById('paymentTotalAmount').innerText = "Rp " + currentTotal.toLocaleString('en-US');

              // Select Cash by default
              document.getElementById('payTunai').checked = true;
              selectPayMethod('Tunai');

              var myModal = new bootstrap.Modal(document.getElementById('paymentModal'));
              myModal.show();
            }

            function selectPayMethod(method) {
              document.querySelectorAll('.pay-method-detail').forEach(el => el.classList.add('d-none'));
              if (method === 'Tunai') {
                document.getElementById('methodDetailTunai').classList.remove('d-none');
              } else if (method === 'QRIS') {
                document.getElementById('methodDetailQRIS').classList.remove('d-none');
              } else if (method === 'E-Wallet') {
                document.getElementById('methodDetailEWallet').classList.remove('d-none');
              }
            }

            function calculateChange() {
              let cashReceived = parseFloat(document.getElementById('inputCashReceived').value) || 0;
              let change = cashReceived - currentTotal;
              if (change < 0) {
                document.getElementById('textCashChange').innerText = "Kurang Rp " + Math.abs(change).toLocaleString('en-US');
                document.getElementById('textCashChange').className = "fw-bold text-danger mb-0";
              } else {
                document.getElementById('textCashChange').innerText = "Rp " + change.toLocaleString('en-US');
                document.getElementById('textCashChange').className = "fw-bold text-success mb-0";
              }
            }

            function prosesPembayaran() {
              let confirmBtn = document.getElementById('btnConfirmPayment');
              if (confirmBtn.disabled) return;
              confirmBtn.disabled = true;

              let selectedMethod = document.querySelector('input[name="paymentMethod"]:checked').value;

              // Generate kode invoice kasir berdasarkan waktu
              let now = new Date();
              let timestamp = now.getFullYear().toString() +
                (now.getMonth() + 1).toString().padStart(2, '0') +
                now.getDate().toString().padStart(2, '0') +
                now.getHours().toString().padStart(2, '0') +
                now.getMinutes().toString().padStart(2, '0') +
                now.getSeconds().toString().padStart(2, '0');
              // Format seperti ref Alfamart S-YYMMDD-XXXXXXXX
              let shortYear = now.getFullYear().toString().substring(2);
              let shortMonth = (now.getMonth() + 1).toString().padStart(2, '0');
              let shortDay = now.getDate().toString().padStart(2, '0');
              let invoiceId = "S-" + shortYear + shortMonth + shortDay + "-GASPOS" + timestamp.substring(10);

              // Isi info umum cetak struk
              document.getElementById('printReceiptId').innerText = invoiceId;

              // Format Tanggal: DD-MM-YYYY HH:MM:SS
              let formattedDate = shortDay + "-" + shortMonth + "-" + now.getFullYear() + " " +
                now.getHours().toString().padStart(2, '0') + ":" +
                now.getMinutes().toString().padStart(2, '0') + ":" +
                now.getSeconds().toString().padStart(2, '0');
              document.getElementById('printReceiptDate').innerText = "Tgl. " + formattedDate;
              document.getElementById('printReceiptMethod').innerText = selectedMethod;

              // Ambil nama pelanggan dari input modal
              let custName = document.getElementById('inputCustomerName').value.trim() || "Pelanggan Umum";
              document.getElementById('printReceiptCustomer').innerText = custName;

              // Tampilkan nama kasir dari session jika ada
              let cashierName = '<%= session.getAttribute("namaUser") != null ? session.getAttribute("namaUser") : "Kasir Utama" %>';
              document.getElementById('printReceiptCashier').innerText = cashierName;

              // Render item belanja di area cetak struk
              let itemsBody = document.getElementById('printReceiptItemsBody');
              itemsBody.innerHTML = '';
              let totalQty = 0;
              orderList.forEach(item => {
                totalQty += item.qty;
                itemsBody.innerHTML +=
                  "<tr>" +
                  "<td>" + item.nama + "</td>" +
                  "<td class=\"text-center\">" + item.qty + "</td>" +
                  "<td class=\"text-right\">" + item.harga.toLocaleString('en-US') + "</td>" +
                  "<td class=\"text-right\">" + (item.qty * item.harga).toLocaleString('en-US') + "</td>" +
                  "</tr>";
              });

              document.getElementById('printReceiptQtyCount').innerText = totalQty;
              document.getElementById('printReceiptSubtotal').innerText = currentTotal.toLocaleString('en-US');
              document.getElementById('printReceiptTotal').innerText = currentTotal.toLocaleString('en-US');

              if (selectedMethod === 'Tunai') {
                let cashReceived = parseFloat(document.getElementById('inputCashReceived').value) || 0;
                if (cashReceived < currentTotal) {
                  alert("Jumlah uang tunai yang diterima kurang dari total tagihan!");
                  confirmBtn.disabled = false;
                  return;
                }
                let change = cashReceived - currentTotal;
                document.getElementById('receiptCashRow').classList.remove('d-none');
                document.getElementById('receiptCashPaid').innerText = "Rp " + cashReceived.toLocaleString('en-US');
                document.getElementById('receiptChange').innerText = "Rp " + change.toLocaleString('en-US');

                // Tampilkan rincian kembalian di area cetak struk
                document.getElementById('printReceiptCashRow').style.display = 'table-row';
                document.getElementById('printReceiptChangeRow').style.display = 'table-row';
                document.getElementById('printReceiptCashPaid').innerText = cashReceived.toLocaleString('en-US');
                document.getElementById('printReceiptChange').innerText = change.toLocaleString('en-US');
              } else {
                // Sembunyikan rincian kembalian di area cetak struk
                document.getElementById('printReceiptCashRow').style.display = 'none';
                document.getElementById('printReceiptChangeRow').style.display = 'none';
              }

              // Tampilkan info di modal sukses
              document.getElementById('receiptMethod').innerText = selectedMethod;
              document.getElementById('receiptTotal').innerText = "Rp " + currentTotal.toLocaleString('en-US');

              // Kirim data transaksi ke server
              let params = new URLSearchParams();
              params.append("invoiceId", invoiceId);
              params.append("customerName", custName);
              params.append("paymentMethod", selectedMethod);
              params.append("cashierName", cashierName);
              params.append("subtotal", currentTotal);
              
              let totalBayarVal = currentTotal;
              let changeVal = 0;
              if (selectedMethod === 'Tunai') {
                  let cashReceived = parseFloat(document.getElementById('inputCashReceived').value) || 0;
                  totalBayarVal = cashReceived;
                  changeVal = cashReceived - currentTotal;
              }
              params.append("totalBayar", totalBayarVal);
              params.append("kembalian", changeVal);
              
              orderList.forEach(function(item) {
                  params.append("idProduk", item.id);
                  params.append("namaProduk", item.nama);
                  params.append("qty", item.qty);
                  params.append("harga", item.harga);
              });
              
              fetch("save-transaction", {
                  method: "POST",
                  body: params
              })
              .then(function(res) {
                  if (res.ok) {
                      console.log("Transaction saved successfully.");
                  } else {
                      console.error("Failed to save transaction.");
                      alert("Gagal menyimpan transaksi!");
                      confirmBtn.disabled = false;
                  }
              })
              .catch(function(err) {
                  console.error("Error saving transaction:", err);
                  alert("Error koneksi saat menyimpan transaksi!");
                  confirmBtn.disabled = false;
              });

              // Tampilkan langkah struk sukses
              document.getElementById('paymentStepSelect').classList.add('d-none');
              document.getElementById('paymentStepSuccess').classList.remove('d-none');

              // Bersihkan order list
              orderList = [];
              renderCart();
            }

            document.addEventListener('DOMContentLoaded', function () {
              document.getElementById('btnConfirmRemove').addEventListener('click', function () {
                if (pendingRemoveId) {
                  orderList = orderList.filter(i => i.id !== pendingRemoveId);
                  renderCart();
                  pendingRemoveId = null;
                  bootstrap.Modal.getInstance(document.getElementById('confirmRemoveModal')).hide();
                }
              });
            });
          </script>

          <!-- Modal Konfirmasi Hapus Produk dari Order -->
          <div class="modal fade" id="confirmRemoveModal" tabindex="-1" aria-labelledby="confirmRemoveModalLabel"
            aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title fw-bold" id="confirmRemoveModalLabel">Hapus Item Order</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                  Apakah Anda yakin ingin menghapus <span id="removeProductName" class="fw-bold"></span> dari daftar
                  belanja?
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-light border fw-bold" data-bs-dismiss="modal">Batal</button>
                  <button type="button" class="btn btn-danger fw-bold" id="btnConfirmRemove">Hapus</button>
                </div>
              </div>
            </div>
          </div>

          <!-- Modal Pembayaran & Tagihan Berhasil -->
          <div class="modal fade" id="paymentModal" tabindex="-1" aria-labelledby="paymentModalLabel"
            aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
              <div class="modal-content border-0 shadow">
                <!-- Step 1: Pilih Metode & Input Bayar -->
                <div id="paymentStepSelect">
                  <div class="modal-header">
                    <h5 class="modal-title fw-bold" id="paymentModalLabel"><i class="fas fa-wallet me-2"></i>Pembayaran
                      Pesanan</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body p-4">
                    <div class="mb-3">
                      <label class="form-label fw-bold">Nama Pelanggan (Opsional)</label>
                      <input type="text" class="form-control p-2" id="inputCustomerName"
                        placeholder="Contoh: Rizky Febriyanto" value="Pelanggan Umum">
                    </div>
                    <div class="text-center mb-4">
                      <span class="text-muted small fw-bold">TOTAL TAGIHAN</span>
                      <h2 class="fw-bold text-success mt-1" id="paymentTotalAmount">Rp 0</h2>
                    </div>

                    <label class="form-label fw-bold mb-2">Pilih Metode Pembayaran</label>
                    <div class="row g-2 mb-4">
                      <div class="col-4">
                        <input type="radio" class="btn-check" name="paymentMethod" id="payTunai" value="Tunai" checked
                          onclick="selectPayMethod('Tunai')">
                        <label
                          class="btn btn-outline-dark w-100 py-3 d-flex flex-column align-items-center justify-content-center border-2"
                          for="payTunai">
                          <i class="fas fa-money-bill-wave fs-4 mb-2"></i>
                          <span class="small fw-bold">Tunai</span>
                        </label>
                      </div>
                      <div class="col-4">
                        <input type="radio" class="btn-check" name="paymentMethod" id="payQRIS" value="QRIS"
                          onclick="selectPayMethod('QRIS')">
                        <label
                          class="btn btn-outline-dark w-100 py-3 d-flex flex-column align-items-center justify-content-center border-2"
                          for="payQRIS">
                          <i class="fas fa-qrcode fs-4 mb-2"></i>
                          <span class="small fw-bold">QRIS</span>
                        </label>
                      </div>
                      <div class="col-4">
                        <input type="radio" class="btn-check" name="paymentMethod" id="payEWallet" value="E-Wallet"
                          onclick="selectPayMethod('E-Wallet')">
                        <label
                          class="btn btn-outline-dark w-100 py-3 d-flex flex-column align-items-center justify-content-center border-2"
                          for="payEWallet">
                          <i class="fas fa-mobile-alt fs-4 mb-2"></i>
                          <span class="small fw-bold">E-Wallet</span>
                        </label>
                      </div>
                    </div>

                    <!-- Detail Metode -->
                    <!-- 1. Tunai -->
                    <div id="methodDetailTunai" class="pay-method-detail">
                      <div class="mb-3">
                        <label class="form-label fw-bold">Jumlah Uang Tunai Diterima</label>
                        <div class="input-group">
                          <span class="input-group-text fw-bold">Rp</span>
                          <input type="number" class="form-control p-2" id="inputCashReceived"
                            placeholder="Contoh: 50000" oninput="calculateChange()">
                        </div>
                      </div>
                      <div class="p-3 bg-light rounded-3 d-flex justify-content-between align-items-center">
                        <span class="text-muted fw-bold">Kembalian</span>
                        <h5 class="fw-bold text-emerald mb-0" id="textCashChange">Rp 0</h5>
                      </div>
                    </div>

                    <!-- 2. QRIS -->
                    <div id="methodDetailQRIS" class="pay-method-detail d-none text-center">
                      <div class="p-3 border rounded-4 bg-light mb-3" style="display: inline-block;">
                        <img src="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=GasPOS-Payment"
                          alt="QRIS Code" class="img-fluid" style="width: 150px; height: 150px;">
                      </div>
                      <p class="text-muted small mb-0">Silakan scan kode QRIS di atas untuk melakukan pembayaran.</p>
                    </div>

                    <!-- 3. E-Wallet -->
                    <div id="methodDetailEWallet" class="pay-method-detail d-none">
                      <div class="mb-3">
                        <label class="form-label fw-bold">Nomor HP E-Wallet (OVO/DANA/Gopay)</label>
                        <input type="text" class="form-control p-2" id="inputWalletPhone"
                          placeholder="Contoh: 08123456789">
                      </div>
                      <p class="text-muted small mb-0">Permintaan pembayaran akan dikirim langsung ke aplikasi e-wallet
                        pelanggan.</p>
                    </div>

                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-light border fw-bold px-4"
                      data-bs-dismiss="modal">Batal</button>
                    <button type="button" id="btnConfirmPayment" class="btn btn-emerald fw-bold px-4" onclick="prosesPembayaran()"><i
                        class="fas fa-check me-2"></i>Konfirmasi Bayar</button>
                  </div>
                </div>

                <!-- Step 2: Invoice / Sukses (Struk Belanja) -->
                <div id="paymentStepSuccess" class="d-none">
                  <div class="modal-header bg-emerald text-white">
                    <h5 class="modal-title fw-bold"><i class="fas fa-check-circle me-2"></i>Tagihan Berhasil Dibayar
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                      aria-label="Close"></button>
                  </div>
                  <div class="modal-body p-4 text-center">
                    <div class="text-emerald mb-3">
                      <i class="fas fa-check-circle fs-1"></i>
                    </div>
                    <h4 class="fw-bold mb-1">Pembayaran Sukses!</h4>
                    <p class="text-muted small mb-4">Transaksi telah selesai dicatat dalam sistem.</p>

                    <div class="card border-0 bg-light p-3 text-start mb-3 rounded-3">
                      <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted">Metode Pembayaran</span>
                        <span class="fw-bold text-dark" id="receiptMethod">-</span>
                      </div>
                      <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted">Total Pembayaran</span>
                        <span class="fw-bold text-emerald" id="receiptTotal">-</span>
                      </div>
                      <div id="receiptCashRow" class="d-none">
                        <div class="d-flex justify-content-between mb-2">
                          <span class="text-muted">Uang Tunai</span>
                          <span class="fw-bold text-dark" id="receiptCashPaid">-</span>
                        </div>
                        <div class="d-flex justify-content-between">
                          <span class="text-muted">Kembalian</span>
                          <span class="fw-bold text-dark" id="receiptChange">-</span>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-light border fw-bold px-4"
                      data-bs-dismiss="modal">Tutup</button>
                    <button type="button" class="btn btn-emerald fw-bold px-4" onclick="window.print()"><i
                        class="fas fa-print me-2"></i>Cetak Struk</button>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Area Cetak Struk (Hanya Muncul saat Diprint) -->
          <div id="receiptPrintArea">
            <div class="receipt-header text-center">
              <h1 class="logo">GasPOS</h1>
              <div class="receipt-store-details">
                <p>BOJONGSOANG 187</p>
                <p>081294658263</p>
                <p>LENGKONG, BOJONGSOANG</p>
                <p>JL. RAYA BOJONGSOANG NO. 187 RT. 001 RW. 002</p>
              </div>
              <div class="separator separator-double"></div>
            </div>

            <div class="receipt-info">
              <table>
                <tr>
                  <td>Delivered at :</td>
                  <td class="text-right fw-bold" id="printReceiptCustomer">-</td>
                </tr>
                <tr>
                  <td></td>
                  <td class="text-right small text-muted">Asrama Telkom University, Bandung</td>
                </tr>
                <tr>
                  <td>Status Order :</td>
                  <td class="text-right fw-bold text-success">Pesanan Lunas</td>
                </tr>
                <tr>
                  <td>Ref :</td>
                  <td class="text-right" id="printReceiptId">-</td>
                </tr>
                <tr>
                  <td>Kasir :</td>
                  <td class="text-right" id="printReceiptCashier">-</td>
                </tr>
              </table>
              <div class="separator separator-dashed"></div>
            </div>

            <div class="receipt-items">
              <table>
                <thead>
                  <tr>
                    <th style="width: 45%;">Nama Item</th>
                    <th class="text-center" style="width: 10%;">Qty</th>
                    <th class="text-right" style="width: 22%;">Harga</th>
                    <th class="text-right" style="width: 23%;">Total</th>
                  </tr>
                </thead>
                <tbody id="printReceiptItemsBody">
                  <!-- Dinamis via JS -->
                </tbody>
              </table>
              <div class="separator separator-dashed"></div>
            </div>

            <div class="receipt-totals">
              <table>
                <tr>
                  <td>Subtotal</td>
                  <td class="text-center" id="printReceiptQtyCount">0</td>
                  <td class="text-right" id="printReceiptSubtotal">0</td>
                </tr>
                <tr>
                  <td>Total Diskon</td>
                  <td class="text-center"></td>
                  <td class="text-right">0</td>
                </tr>
                <tr>
                  <td>Biaya Pengiriman</td>
                  <td class="text-center"></td>
                  <td class="text-right">0</td>
                </tr>
                <tr style="font-weight: bold; border-top: 1px dashed #000; border-bottom: 1px dashed #000;">
                  <td>Total</td>
                  <td class="text-center"></td>
                  <td class="text-right" id="printReceiptTotal">0</td>
                </tr>
                <tr id="printReceiptMethodRow" style="font-size: 10px;">
                  <td>Pembayaran</td>
                  <td class="text-center"></td>
                  <td class="text-right" id="printReceiptMethod">-</td>
                </tr>
                <tr id="printReceiptCashRow">
                  <td>Bayar Tunai</td>
                  <td class="text-center"></td>
                  <td class="text-right" id="printReceiptCashPaid">0</td>
                </tr>
                <tr id="printReceiptChangeRow">
                  <td>Kembalian</td>
                  <td class="text-center"></td>
                  <td class="text-right" id="printReceiptChange">0</td>
                </tr>
              </table>
              <p class="small-note">*Harga yang tertera sudah termasuk PPN</p>
            </div>

            <div class="receipt-status-lunas">
              <h3>L U N A S</h3>
            </div>

            <div class="receipt-footer">
              <p id="printReceiptDate">-</p>
              <div class="separator separator-dashed"></div>
              <p class="thankyou">Kritik & Saran : 1500959, SMS : 0817111234</p>
              <div class="separator separator-double"></div>
            </div>
          </div>

          <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>