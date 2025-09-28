package com.example.bookQuotes.services;

import com.example.bookQuotes.entity.Quotes;

import java.util.List;

public interface QuotesService {
    Quotes addQuotes (Quotes quotes);
    Quotes getQuotesById(Long id);
    List<Quotes> getAllQuotes ();
    Quotes updateQuotes(Long id,Quotes newQuoteDetails);
    void deleteQuotes(Long id);
}
