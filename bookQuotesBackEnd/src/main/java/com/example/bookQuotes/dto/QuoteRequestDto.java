package com.example.bookQuotes.dto;

public class QuoteRequestDto {
    private String text;
    private String author;
    private String book_name;
    private Long userId;

    public QuoteRequestDto() {
    }

    public QuoteRequestDto(String text, String author, String book_name, Long userId) {
        this.text = text;
        this.author = author;
        this.book_name = book_name;
        this.userId = userId;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getBook_name() {
        return book_name;
    }

    public void setBook_name(String book_name) {
        this.book_name = book_name;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }
}
