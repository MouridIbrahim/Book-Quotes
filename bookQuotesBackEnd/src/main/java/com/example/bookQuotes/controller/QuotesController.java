package com.example.bookQuotes.controller;
import com.example.bookQuotes.dto.QuoteRequestDto;
import com.example.bookQuotes.dto.QuoteResponseDto;
import com.example.bookQuotes.entity.Quotes;
import com.example.bookQuotes.entity.User;
import com.example.bookQuotes.services.QuotesServiceImp;
import com.example.bookQuotes.services.UserServiceImp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/quotes")
public class QuotesController {
    @Autowired
    QuotesServiceImp quotesService;

    @Autowired
    UserServiceImp userService;


    @PostMapping("/create")
    public ResponseEntity<?> createQuote(@RequestBody QuoteRequestDto quoteRequestDto) {

        try {
            // Find the user
            User user = userService.getUserById(quoteRequestDto.getUserId());

            // Create quote entity from DTO
            Quotes quote = new Quotes(
                    quoteRequestDto.getText(),
                    quoteRequestDto.getAuthor(),
                    quoteRequestDto.getBook_name(),
                    user
            );

            // Save the quote
            Quotes savedQuote = quotesService.addQuotes(quote);

            // Convert to response DTO
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
}
