<%-- 
    Document   : produk
    Created on : 4 Jun 2026, 23.06.54
    Author     : Arya Satriawansyah
--%>
<%@page import="java.util.List"%>
<%@page import="com.gaspos.model.Produk"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Daftar Produk - GasPOS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; }
        .sidebar { background-color: white; height: 100vh; border-right: 1px solid #eee; padding: 20px;}
        .nav-item .active { border-left: 4px solid #dc3545; background-color: #fff5f5; color: #dc3545 !important; border-radius: 4px; }
        .btn-cyber { background: linear-gradient(135deg, #00dbde 0%, #fc00ff 100%); color: white; border: none; font-weight: bold;}
        .btn-cyber:hover { opacity: 0.9; color: white; }
        .table th { background-color: #f8f9fa; color: #6c757d; font-weight: 600; font-size: 12px; }
        .table td { vertical-align: middle; font-weight: 500; }
        .badge-aktif { background-color: #e6f4ea; color: #1e8e3e; padding: 5px 10px; border-radius: 20px; font-size: 12px; }
        .action-btn { width: 32px; height: 32px; padding: 0; border-radius: 50%; display: inline-flex; align-items: center; justify-content: center; border: 1px solid #ddd; background: white; margin: 0 2px; cursor: pointer;}
        .action-btn.edit:hover { background: #f8f9fa; color: #000; }
        .action-btn.delete { color: #dc3545; background: #fff5f5; border-color: #ffcdd2;}
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
                <li class="nav-item"><a href="produk" class="nav-link text-dark fw-bold active">Daftar Produk</a></li>
                <li class="nav-item"><a href="bills" class="nav-link text-dark fw-bold">Bills</a></li>
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
            <div id="viewList">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h3 class="fw-bold mb-0">Daftar Produk</h3>
                        <p class="text-muted mb-0">Manajemen data produk, stok, dan harga</p>
                    </div>
                    <button class="btn btn-light border fw-bold" onclick="showForm()"><i class="fas fa-plus me-2"></i> Tambah Produk</button>
                </div>
                
                <div class="card border-0 shadow-sm rounded-3 p-0 overflow-hidden">
                    <table class="table table-hover mb-0">
                        <thead>
                            <tr>
                                <th class="ps-4">ID PRODUK</th>
                                <th>NAMA PRODUK</th>
                                <th>KATEGORI</th>
                                <th>HARGA MODAL</th>
                                <th>HARGA JUAL</th>
                                <th>STOK</th>
                                <th>STATUS</th>
                                <th>AKSI</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                List<Produk> list = (List<Produk>) request.getAttribute("daftarProduk");
                                if(list != null) {
                                    for(Produk p : list) { 
                                        String img = p.getGambar() != null ? p.getGambar() : "";
                            %>
                            <tr>
                                <td class="ps-4 text-muted"><%= p.getIdProduk() %></td>
                                <td class="fw-bold"><%= p.getNamaProduk() %></td>
                                <td class="text-muted"><%= p.getKategori() %></td>
                                <td>Rp <%= p.getHargaModal() %></td>
                                <td class="text-success">Rp <%= p.getHargaJual() %></td>
                                <td><%= p.getStok() %></td>
                                <td><span class="badge-aktif">Aktif</span></td>
                                <td>
                                    <button type="button" class="action-btn edit" onclick="editProduk('<%= p.getIdProduk() %>', '<%= p.getNamaProduk() %>', '<%= p.getKategori() %>', '<%= img %>', <%= p.getStok() %>, <%= p.getHargaModal() %>, <%= p.getHargaJual() %>)"><i class="fas fa-pen text-muted"></i></button>
                                    <button type="button" class="action-btn delete" onclick="confirmDelete('<%= p.getIdProduk() %>', '<%= p.getNamaProduk() %>')"><i class="fas fa-trash"></i></button>
                                </td>
                            </tr>
                            <% } } %>
                        </tbody>
                    </table>
                </div>
            </div>

            <div id="viewForm" style="display: none;">
                <div class="d-flex align-items-center mb-4">
                    <button class="btn btn-link text-dark text-decoration-none fs-5 me-3 p-0" onclick="hideForm()"><i class="fas fa-arrow-left"></i></button>
                    <div>
                        <h3 class="fw-bold mb-0" id="formTitle">Tambah Produk Baru</h3>
                        <p class="text-muted mb-0">Masukkan detail produk untuk ditambahkan ke sistem</p>
                    </div>
                </div>

                <div class="card border-0 shadow-sm rounded-4 p-4 mt-4">
                    <form action="produk" method="POST" id="formProduk">
                        <input type="hidden" name="aksi" id="aksiForm" value="tambah">
                        
                        <div class="row g-4 mb-4">
                            <div class="col-md-6">
                                <label class="form-label fw-bold">ID Produk</label>
                                <input type="text" class="form-control p-2" name="id_produk" id="inputId" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Nama Produk</label>
                                <input type="text" class="form-control p-2" name="nama_produk" id="inputNama" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Kategori</label>
                                <input type="text" class="form-control p-2" name="kategori" id="inputKategori" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">URL Gambar</label>
                                <input type="text" class="form-control p-2" name="gambar" id="inputGambar" value="https://via.placeholder.com/150">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Stok Awal</label>
                                <input type="number" class="form-control p-2" name="stok" id="inputStok" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Harga Modal (HPP)</label>
                                <input type="number" class="form-control p-2" name="harga_modal" id="inputModal" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Harga Jual</label>
                                <input type="number" class="form-control p-2" name="harga_jual" id="inputJual" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">No. WA Penjual (Opsional)</label>
                                <input type="text" class="form-control p-2" placeholder="Contoh: 62812345678">
                            </div>
                        </div>

                        <div class="form-check mb-5 mt-2">
                            <input class="form-check-input" type="checkbox" checked id="statusCheck">
                            <label class="form-check-label fw-bold" for="statusCheck">Status Produk Aktif</label>
                        </div>

                        <div class="text-end border-top pt-4">
                            <button type="button" class="btn btn-light border px-4 py-2 me-2 fw-bold" onclick="hideForm()">Batal</button>
                            <button type="submit" class="btn btn-danger px-4 py-2 fw-bold" id="btnSimpan"><i class="fas fa-save me-2"></i> Simpan Produk</button>
                        </div>
                    </form>
                </div>
            </div>

        </div>
    </div>
</div>

<script>
    function showForm() {
        document.getElementById('viewList').style.display = 'none';
        document.getElementById('viewForm').style.display = 'block';
        document.getElementById('aksiForm').value = 'tambah';
        document.getElementById('formTitle').innerText = 'Tambah Produk Baru';
        document.getElementById('btnSimpan').innerHTML = '<i class="fas fa-save me-2"></i> Simpan Produk';
        document.getElementById('formProduk').reset();
        document.getElementById('inputId').readOnly = false;
        document.getElementById('inputGambar').value = 'https://via.placeholder.com/150';
    }

    function hideForm() {
        document.getElementById('viewList').style.display = 'block';
        document.getElementById('viewForm').style.display = 'none';
    }

    function editProduk(id, nama, kategori, gambar, stok, modal, jual) {
        showForm();
        document.getElementById('formTitle').innerText = 'Edit Produk';
        document.getElementById('aksiForm').value = 'edit';
        document.getElementById('inputId').value = id;
        document.getElementById('inputId').readOnly = true;
        document.getElementById('inputNama').value = nama;
        document.getElementById('inputKategori').value = kategori;
        document.getElementById('inputGambar').value = gambar;
        document.getElementById('inputStok').value = stok;
        document.getElementById('inputModal').value = modal;
        document.getElementById('inputJual').value = jual;
        document.getElementById('btnSimpan').innerHTML = '<i class="fas fa-save me-2"></i> Update Produk';
    }

    function confirmDelete(id, nama) {
        document.getElementById('deleteProductId').value = id;
        document.getElementById('deleteProductName').innerText = nama;
        var myModal = new bootstrap.Modal(document.getElementById('confirmDeleteModal'));
        myModal.show();
    }
</script>

<!-- Modal Konfirmasi Hapus Produk -->
<div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-labelledby="confirmDeleteModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title fw-bold" id="confirmDeleteModalLabel">Konfirmasi Hapus Produk</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        Apakah Anda yakin ingin menghapus produk <span id="deleteProductName" class="fw-bold"></span> dari sistem?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-light border fw-bold" data-bs-dismiss="modal">Batal</button>
        <form action="produk" method="POST" style="display:inline;">
            <input type="hidden" name="aksi" value="hapus">
            <input type="hidden" name="id_produk" id="deleteProductId">
            <button type="submit" class="btn btn-danger fw-bold">Hapus</button>
        </form>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>