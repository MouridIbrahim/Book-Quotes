// File: LoginResponseDto.java
package com.example.bookQuotes.dto;

public class LoginResponseDto {
    private String token;
    private String username;
    private String message;

    public LoginResponseDto() {
    }

    public LoginResponseDto(String token, String username, String message) {
        this.token = token;
        this.username = username;
        this.message = message;
    }

    // Getters and setters
    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}