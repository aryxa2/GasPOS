<%-- 
    Document   : pos
    Created on : 4 Jun 2026, 22.55.07
    Author     : Arya Satriawansyah
--%>
<%@page import="java.util.List"%>
<%@page import="com.gaspos.model.Produk"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Menu Kasir - GasPOS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background-color: #f4f7f6; }
        .sidebar { background-color: white; height: 100vh; border-right: 1px solid #eee; padding: 20px;}
        .nav-item .active { border-left: 4px solid #dc3545; background-color: #fff5f5; color: #dc3545 !important; border-radius: 4px; }
        .product-card { border-radius: 12px; border: none; box-shadow: 0 4px 6px rgba(0,0,0,0.05); text-align: center; padding: 20px; transition: transform 0.2s;}
        .product-card:hover { transform: translateY(-5px); }
        .product-img { width: 100%; height: 120px; object-fit: contain; margin-bottom: 15px; }
        .btn-cyber { background: linear-gradient(135deg, #00dbde 0%, #fc00ff 100%); color: white; border: none; border-radius: 20px; font-weight: bold;}
        .btn-cyber:hover { opacity: 0.9; color: white; }
        .cart-card { border: 1px solid #eee; border-radius: 8px; padding: 15px; margin-bottom: 10px; background: #fff;}
        .qty-btn { width: 30px; height: 30px; padding: 0; display: inline-flex; justify-content: center; align-items: center; border-radius: 4px;}
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-2 sidebar fixed-top" style="width: 16.66%;">
            <h4 class="fw-bold mb-4 mt-2">GasPOS</h4>
            <div class="text-muted small fw-bold mb-3">MENU</div>
            <ul class="nav flex-column gap-2">
                <li class="nav-item"><a href="pos" class="nav-link text-dark fw-bold active">Daftar Menu</a></li>
                <li class="nav-item"><a href="produk" class="nav-link text-dark fw-bold">Daftar Produk</a></li>
                <li class="nav-item"><a href="bills.jsp" class="nav-link text-dark fw-bold">Bills</a></li>
                <li class="nav-item"><a href="settlement.jsp" class="nav-link text-dark fw-bold">Settlement</a></li>
                <li class="nav-item"><a href="report.jsp" class="nav-link text-dark fw-bold">Report</a></li>
                <li class="nav-item mt-2"><a href="setting.jsp" class="nav-link text-danger fw-bold">Setting</a></li>
            </ul>
        </div>
        
        <div class="col-md-7 p-4 offset-md-2">
            <h3 class="fw-bold">Peralatan PKKMB & Kuliah</h3>
            <p class="text-muted">Pilih perlengkapan mahasiswa baru untuk ditambahkan ke order</p>
            <div class="row g-4 mt-2">
                <% 
                    List<Produk> list = (List<Produk>) request.getAttribute("daftarProduk");
                    if(list != null) {
                        for(Produk p : list) {
                            String img = p.getGambar() != null && !p.getGambar().isEmpty() ? p.getGambar() : "https://via.placeholder.com/150";
                %>
                <div class="col-md-4">
                    <div class="product-card bg-white">
                        <img src="<%= img %>" class="product-img" alt="Produk">
                        <div class="fw-bold text-dark"><%= p.getNamaProduk() %></div>
                        <div class="text-success mb-3 fw-bold">Rp <%= p.getHargaJual() %></div>
                        <button class="btn btn-cyber w-100" onclick="addToCart('<%= p.getIdProduk() %>', '<%= p.getNamaProduk() %>', <%= p.getHargaJual() %>)">+ ADD</button>
                    </div>
                </div>
                <% } } %>
            </div>
        </div>

        <div class="col-md-3 bg-white p-4 d-flex flex-column fixed-top offset-md-9" style="height: 100vh; border-left: 1px solid #eee; width: 25%;">
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
                    <span>Total</span><span id="total-price" class="text-success">Rp 0</span>
                </div>
                <button class="btn btn-outline-dark w-100 p-3 fw-bold rounded-3"><i class="fas fa-credit-card me-2"></i> Buat Tagihan</button>
            </div>
        </div>
    </div>
</div>

<script>
    let orderList = [];

    function addToCart(id, nama, harga) {
        let item = orderList.find(i => i.id === id);
        if(item) { item.qty++; } else { orderList.push({id: id, nama: nama, harga: harga, qty: 1}); }
        renderCart();
    }

    function updateQty(id, change) {
        let item = orderList.find(i => i.id === id);
        if(item) {
            item.qty += change;
            if(item.qty <= 0) { orderList = orderList.filter(i => i.id !== id); }
            renderCart();
        }
    }

    function removeItem(id) {
        orderList = orderList.filter(i => i.id !== id);
        renderCart();
    }

    function renderCart() {
        let cartContainer = document.getElementById("cart-items");
        let total = 0; let count = 0;
        
        if(orderList.length === 0) {
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
                            "<div class='text-success small'>Rp " + item.harga + "</div>" +
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
        document.getElementById("subtotal-price").innerText = "Rp " + total;
        document.getElementById("total-price").innerText = "Rp " + total;
    }
</script>
</body>
</html>