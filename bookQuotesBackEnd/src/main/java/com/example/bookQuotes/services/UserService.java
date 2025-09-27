package com.example.bookQuotes.services;

import com.example.bookQuotes.dto.SignUpDto;
import com.example.bookQuotes.entity.User;
import com.example.bookQuotes.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


public interface UserService {
    User addUser (User user);
    User getUserById(Long id);
    List<User> getAllUsers();
    User updateUser(Long id, User detailsUser);
    void deleteUser(Long id);
}
