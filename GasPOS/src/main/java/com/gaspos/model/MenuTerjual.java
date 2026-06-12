package com.gaspos.model;

public class MenuTerjual {
    private String namaMenu;
    private int qty;
    private double total;

    public MenuTerjual(String namaMenu, int qty, double total) {
        this.namaMenu = namaMenu;
        this.qty = qty;
        this.total = total;
    }

    public String getNamaMenu() {
        return namaMenu;
    }

    public void setNamaMenu(String namaMenu) {
        this.namaMenu = namaMenu;
    }

    public int getQty() {
        return qty;
    }

    public void setQty(int qty) {
        this.qty = qty;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }
}
