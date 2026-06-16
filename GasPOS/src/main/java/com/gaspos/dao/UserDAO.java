package com.gaspos.dao;

import com.gaspos.model.User;
import com.gaspos.model.Pengguna;
import java.util.List;

/**
 *
 * @author Arya Satriawansyah
 */
public interface UserDAO {
    User authenticate(String username, String password) throws Exception;
    List<Pengguna> getAllPengguna() throws Exception;
    boolean addPengguna(Pengguna pengguna) throws Exception;
    boolean changeStatus(String username) throws Exception;
    boolean deletePengguna(String username) throws Exception;
    boolean isUsernameExists(String username) throws Exception;
}
