/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.gaspos.model;

/**
 *
 * @author Arya Satriawansyah
 */
public abstract class User {
    protected String username;
    protected String nama;
    protected String passwordHash;

    public User(String username, String nama, String passwordHash) {
        this.username = username;
        this.nama = nama;
        this.passwordHash = passwordHash;
    }

    public String getUsername() {
        return username;
    }

    public String getNama() {
        return nama;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public abstract String getRole();

    public abstract boolean login(String inputUser, String inputPass);
}
