// File: UserService.java
package com.example.bookQuotes.services;

import com.example.bookQuotes.entity.User;
import java.util.List;

public interface UserService {
    User addUser (User user);
    User getUserById(Long id);
    List<User> getAllUsers();
    User updateUser(Long id, User detailsUser);
    void deleteUser(Long id);
}