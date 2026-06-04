/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.gaspos.model;

/**
 *
 * @author Arya Satriawansyah
 */
public class Produk {
    private String idProduk;
    private String namaProduk;
    private int stok;
    private double hargaJual;
    private String gambar;
    private String kategori;
    private double hargaModal;

    public Produk(String idProduk, String namaProduk, int stok, double hargaJual, String gambar, String kategori, double hargaModal) {
        this.idProduk = idProduk;
        this.namaProduk = namaProduk;
        this.stok = stok;
        this.hargaJual = hargaJual;
        this.gambar = gambar;
        this.kategori = kategori;
        this.hargaModal = hargaModal;
    }

    public String getIdProduk() { return idProduk; }
    public String getNamaProduk() { return namaProduk; }
    public int getStok() { return stok; }
    public double getHargaJual() { return hargaJual; }
    public String getGambar() { return gambar; }
    public String getKategori() { return kategori; }
    public double getHargaModal() { return hargaModal; }
}
