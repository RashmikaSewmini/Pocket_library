package com.example.mobile_mini_library.controller;

import com.example.mobile_mini_library.model.Book;
import com.example.mobile_mini_library.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/books")
public class BookController {

    @Autowired
    private BookRepository bookRepository;

    // Add a book
    @PostMapping("/add")
    public ResponseEntity<String> addBook(@RequestBody Book book) {
        bookRepository.save(book);
        return ResponseEntity.ok("Book added successfully");
    }

    //GET BOOKS OF LOGGED USER ONLY
    @GetMapping("/my")
    public List<Book> getMyBooks(@RequestParam String userId) {
        return bookRepository.findByUserId(userId);
    }
}
