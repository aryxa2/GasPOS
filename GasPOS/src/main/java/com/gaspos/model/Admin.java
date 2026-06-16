package com.gaspos.model;

/**
 *
 * @author Arya Satriawansyah
 */
public class Admin extends User {

    public Admin(String username, String nama, String passwordHash) {
        super(username, nama, passwordHash);
    }

    @Override
    public boolean login(String inputUser, String inputPass) {
        return this.username.equals(inputUser) && this.passwordHash.equals(inputPass);
    }

    @Override
    public String getRole() {
        return "Admin";
    }
}
