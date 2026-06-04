/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.gaspos.model;

/**
 *
 * @author Arya Satriawansyah
 */
public class Pengguna {
    private String username;
    private String nama;
    private String password;
    private String role;
    private String status;

    public Pengguna(String username, String nama, String password, String role, String status) {
        this.username = username;
        this.nama = nama;
        this.password = password;
        this.role = role;
        this.status = status;
    }

    public String getUsername() { return username; }
    public String getNama() { return nama; }
    public String getPassword() { return password; }
    public String getRole() { return role; }
    public String getStatus() { return status; }
}