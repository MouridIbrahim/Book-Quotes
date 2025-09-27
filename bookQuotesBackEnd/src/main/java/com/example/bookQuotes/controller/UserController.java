package com.example.bookQuotes.controller;

import com.example.bookQuotes.dto.AuthRequestDto;
import com.example.bookQuotes.dto.AuthResponseDto;
import com.example.bookQuotes.dto.SignUpDto;
import com.example.bookQuotes.entity.User;
import com.example.bookQuotes.services.UserService;
import com.example.bookQuotes.services.UserServiceImp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("api/users")
public class UserController {
    @Autowired
    private UserServiceImp userService;


    @PostMapping("/signup")
    ResponseEntity<SignUpDto> addUser(@RequestBody AuthRequestDto requestDto){
        User user = new User(requestDto.getUsername(),requestDto.getEmail(),requestDto.getPassword());
        User savedUser= userService.addUser(user);
        SignUpDto responseDto = new SignUpDto(
            savedUser.getUsername(),
            savedUser.getEmail()
        );
        return new ResponseEntity<>(responseDto, HttpStatus.CREATED);
    }

    @GetMapping("/{id}")
    public ResponseEntity<AuthResponseDto> findUser(@PathVariable Long id){
        User getUser= userService.getUserById(id);
        AuthResponseDto response = new AuthResponseDto(getUser.getUsername(),getUser.getEmail());
        return ResponseEntity.ok(response);
    }

    @GetMapping("/all")
    public ResponseEntity<List<AuthResponseDto>> getAllUsers(){
        List<User> getUsers = userService.getAllUsers();
        List<AuthResponseDto> response = getUsers.stream()
                .map(user -> new AuthResponseDto(user.getUsername(), user.getEmail()))
                .collect(Collectors.toList());
        return  ResponseEntity.ok(response);
    }

    @PutMapping("/{id}")
    public ResponseEntity<AuthResponseDto> updateUser(
            @PathVariable Long id,
            @RequestBody AuthRequestDto newDataDto
    ) {

        User userToUpdate = new User();
        userToUpdate.setUsername(newDataDto.getUsername());
        userToUpdate.setEmail(newDataDto.getEmail());


        User updatedUser = userService.updateUser(id, userToUpdate);
        AuthResponseDto response = new AuthResponseDto(
                updatedUser.getUsername(),
                updatedUser.getEmail()
        );
        return ResponseEntity.ok(response);
    }

}
