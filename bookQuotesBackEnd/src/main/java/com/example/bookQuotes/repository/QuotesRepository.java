package com.example.bookQuotes.repository;

import com.example.bookQuotes.entity.Quotes;
import com.example.bookQuotes.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QuotesRepository extends JpaRepository<Quotes,Long> {
    List<Quotes> findByUserOrderByCreatedAtDesc(User user);
    List<Quotes> findByUserAndTextContainingIgnoreCase(User user, String keyword);
}
