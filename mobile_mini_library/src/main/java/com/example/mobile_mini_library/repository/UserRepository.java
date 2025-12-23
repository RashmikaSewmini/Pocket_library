package com.example.mobile_mini_library.repository;

import org.springframework.data.mongodb.repository.MongoRepository;
import com.example.mobile_mini_library.model.User;

import java.util.Optional;

public interface UserRepository extends MongoRepository<User, String> {
    boolean existsByUsername(String username);

    Optional<User> findByUsername(String username);

}
