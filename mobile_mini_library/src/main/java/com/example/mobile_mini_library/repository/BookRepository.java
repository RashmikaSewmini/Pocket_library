package com.example.mobile_mini_library.repository;


import org.springframework.data.mongodb.repository.MongoRepository;
import com.example.mobile_mini_library.model.Book;
import java.util.List;

public interface BookRepository extends MongoRepository<Book, String> {
    List<Book> findByUserId(String userId); // get books for a specific user

    List<Book> findByUserIdAndNameContainingIgnoreCaseOrUserIdAndAuthorContainingIgnoreCase(
            String userId1, String name,
            String userId2, String author
    );
}

