package com.example.bookQuotes.dto;

public class AuthResponseDto {
    private String username;
    private String email;

    public AuthResponseDto(String username,String email) {
        this.username=username;
        this.email= email;
    }

    public String getUsername() {
        return username;
    }

    public void setUserName(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
