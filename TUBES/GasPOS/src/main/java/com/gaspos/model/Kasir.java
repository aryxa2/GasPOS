/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.gaspos.model;

/**
 *
 * @author Arya Satriawansyah
 */
public class Kasir extends User {
    
    public Kasir(String username, String nama, String passwordHash) {
        super(username, nama, passwordHash);
    }

    @Override
    public boolean login(String inputUser, String inputPass) {
        return this.username.equals(inputUser) && this.passwordHash.equals(inputPass);
    }
}