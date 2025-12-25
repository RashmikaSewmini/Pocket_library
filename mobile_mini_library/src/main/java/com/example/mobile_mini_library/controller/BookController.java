package com.example.mobile_mini_library.controller;

import com.example.mobile_mini_library.dto.BorrowRequest;
import com.example.mobile_mini_library.model.Book;
import com.example.mobile_mini_library.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

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

    // SEARCH BOOKS
    @GetMapping("/search")
    public List<Book> searchBooks(
            @RequestParam String query,
            @RequestParam String userId
    ) {
        return bookRepository
                .findByUserIdAndNameContainingIgnoreCaseOrUserIdAndAuthorContainingIgnoreCase(
                        userId, query,
                        userId, query
                );
    }

    @PostMapping("/borrow")
    public ResponseEntity<?> borrowBook(@RequestBody BorrowRequest request) {

        Optional<Book> optionalBook = bookRepository.findById(request.getBookId());

        if (optionalBook.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body("Book not found");
        }

        Book book = optionalBook.get();

        // Already borrowed
        if (!book.isAvailability()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body("Book is not available");
        }

        // Borrow book
        book.setAvailability(false);
        book.setBorrowedBy(request.getBorrowedBy());
        book.setBorrowedDate(LocalDate.now());

        bookRepository.save(book);

        return ResponseEntity.ok("Book borrowed successfully");
    }
}
