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
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

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

            User user = userService.getUserById(quoteRequestDto.getUserId());


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
}
