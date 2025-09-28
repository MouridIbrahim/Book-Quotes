package com.example.bookQuotes.services;

import com.example.bookQuotes.entity.Quotes;
import com.example.bookQuotes.exceptionHandler.UserNotFoundException;
import com.example.bookQuotes.repository.QuotesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class QuotesServiceImp implements QuotesService{

    @Autowired
    QuotesRepository quotesRepository;

    @Override
    public Quotes addQuotes(Quotes quotes) {

        return quotesRepository.save(quotes);
    }

    @Override
    public Quotes getQuotesById(Long id) {
        return quotesRepository.findById(id).orElseThrow(()->new UserNotFoundException("Quote with id:" + id + "not found"));
    }

    @Override
    public List<Quotes> getAllQuotes() {
        return quotesRepository.findAll();
    }

    @Override
    @Transactional
    public Quotes updateQuotes(Long id, Quotes newQuoteDetails) {
        return quotesRepository.save(newQuoteDetails);
    }

    @Override
    public void deleteQuotes(Long id) {
        quotesRepository.deleteById(id);
    }
}
