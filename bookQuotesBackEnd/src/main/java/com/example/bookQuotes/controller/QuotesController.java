// File: QuotesController.java
package com.example.bookQuotes.controller;

import com.example.bookQuotes.dto.QuoteRequestDto;
import com.example.bookQuotes.dto.QuoteResponseDto;
import com.example.bookQuotes.entity.Quotes;
import com.example.bookQuotes.entity.User;
import com.example.bookQuotes.services.QuotesServiceImp;
import com.example.bookQuotes.services.UserServiceImp;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/quotes")
public class QuotesController {

    private final QuotesServiceImp quotesService;
    private final UserServiceImp userService;

    public QuotesController(QuotesServiceImp quotesService, UserServiceImp userService) {
        this.quotesService = quotesService;
        this.userService = userService;
    }

    @PostMapping("/create")
    public ResponseEntity<?> createQuote(@RequestBody QuoteRequestDto quoteRequestDto) {
        try {
            // Get current authenticated user
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            String username = authentication.getName();

            // Find user by username
            User user = userService.getUserByUsername(username);

            Quotes quote = new Quotes(
                    quoteRequestDto.getText(),
                    quoteRequestDto.getAuthor(),
                    quoteRequestDto.getBook_name(),
                    user
            );

            Quotes savedQuote = quotesService.addQuotes(quote);

            QuoteResponseDto responseDto = new QuoteResponseDto(
                    savedQuote.getText(),
                    savedQuote.getAuthor(),
                    savedQuote.getBook_title()
            );

            return new ResponseEntity<>(responseDto, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("/all")
    public ResponseEntity<List<QuoteResponseDto>> getAllQuotes(){
        List<Quotes> quotes= quotesService.getAllQuotes();
        List<QuoteResponseDto> response = quotes.stream()
                .map(quote->new QuoteResponseDto(quote.getText(),quote.getAuthor(),quote.getBook_title()))
                .collect(Collectors.toList());
        return ResponseEntity.ok(response);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<?> deleteQuote(@PathVariable  Long id){
        quotesService.deleteQuotes(id);
        return ResponseEntity.ok(HttpStatus.ACCEPTED);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getQuoteById(@PathVariable Long id) {
        try {
            Quotes quote = quotesService.getQuotesById(id);
            QuoteResponseDto responseDto = new QuoteResponseDto(
                    quote.getText(),
                    quote.getAuthor(),
                    quote.getBook_title()
            );
            return ResponseEntity.ok(responseDto);
        } catch (Exception e) {
            return new ResponseEntity<String>("Quote not found with id: " + id, HttpStatus.NOT_FOUND);
        }
    }
}