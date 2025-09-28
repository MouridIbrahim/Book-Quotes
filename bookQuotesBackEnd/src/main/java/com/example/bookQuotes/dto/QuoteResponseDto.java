package com.example.bookQuotes.dto;

public class QuoteResponseDto {
    private String text;
    private String author;
    private String book_name;

    public QuoteResponseDto() {
    }

    public QuoteResponseDto(String text, String author, String book_name) {
        this.text = text;
        this.author = author;
        this.book_name = book_name;
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

}
