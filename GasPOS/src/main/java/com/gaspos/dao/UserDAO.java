package com.gaspos.dao;

import com.gaspos.model.User;
import com.gaspos.model.Pengguna;
import java.util.List;

/**
 *
 * @author Arya Satriawansyah
 */
public interface UserDAO {
    User authenticate(String username, String password);
    List<Pengguna> getAllPengguna();
    boolean addPengguna(Pengguna pengguna);
    boolean changeStatus(String username);
}
