package com.gaspos.model;

import java.sql.Timestamp;

public class Transaksi {
    private String noInvoice;
    private Timestamp tanggal;
    private String pelanggan;
    private String metodePembayaran;
    private String kasir;
    private double subtotal;
    private double totalBayar;
    private double kembalian;
    private String itemsSold;

    public Transaksi(String noInvoice, Timestamp tanggal, String pelanggan, String metodePembayaran, String kasir, double subtotal, double totalBayar, double kembalian, String itemsSold) {
        this.noInvoice = noInvoice;
        this.tanggal = tanggal;
        this.pelanggan = pelanggan;
        this.metodePembayaran = metodePembayaran;
        this.kasir = kasir;
        this.subtotal = subtotal;
        this.totalBayar = totalBayar;
        this.kembalian = kembalian;
        this.itemsSold = itemsSold;
    }

    public String getNoInvoice() {
        return noInvoice;
    }

    public void setNoInvoice(String noInvoice) {
        this.noInvoice = noInvoice;
    }

    public Timestamp getTanggal() {
        return tanggal;
    }

    public void setTanggal(Timestamp tanggal) {
        this.tanggal = tanggal;
    }

    public String getPelanggan() {
        return pelanggan;
    }

    public void setPelanggan(String pelanggan) {
        this.pelanggan = pelanggan;
    }

    public String getMetodePembayaran() {
        return metodePembayaran;
    }

    public void setMetodePembayaran(String metodePembayaran) {
        this.metodePembayaran = metodePembayaran;
    }

    public String getKasir() {
        return kasir;
    }

    public void setKasir(String kasir) {
        this.kasir = kasir;
    }

    public double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }

    public double getTotalBayar() {
        return totalBayar;
    }

    public void setTotalBayar(double totalBayar) {
        this.totalBayar = totalBayar;
    }

    public double getKembalian() {
        return kembalian;
    }

    public void setKembalian(double kembalian) {
        this.kembalian = kembalian;
    }

    public String getItemsSold() {
        return itemsSold;
    }

    public void setItemsSold(String itemsSold) {
        this.itemsSold = itemsSold;
    }
}
