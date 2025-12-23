package com.example.mobile_mini_library.controller;

import com.example.mobile_mini_library.model.User;
import com.example.mobile_mini_library.repository.UserRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.crypto.password.PasswordEncoder;
import java.util.Optional;

@RestController
@RequestMapping("/api/auth")
@CrossOrigin(origins = "*")



public class AuthController {

    private final UserRepository userRepository;

    public AuthController(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Autowired
    private PasswordEncoder passwordEncoder;
    // SIGN UP
    @PostMapping("/signup")
    public ResponseEntity<String> signup(@RequestBody User user) {

        if (user.getUsername() == null ||
            user.getPassword() == null ||
            user.getEmail() == null) {

            return ResponseEntity.badRequest().body("Missing required fields");
        }

        if (userRepository.existsByUsername(user.getUsername())) {
            return ResponseEntity.badRequest().body("Username already exists");
        }

        // Hash password
        String hashedPassword = passwordEncoder.encode(user.getPassword());
        user.setPassword(hashedPassword);

        userRepository.save(user);
        return ResponseEntity.ok("Signup successful");
    }



    // LOGIN
    @PostMapping("/login")
    public ResponseEntity<String> login(@RequestBody User user) {
        Optional<User> dbUserOptional = userRepository.findByUsername(user.getUsername());
        
        if (dbUserOptional.isEmpty()) {
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("User not found");
    }

    User dbUser = dbUserOptional.get();

    if (passwordEncoder.matches(user.getPassword(), dbUser.getPassword())) {
        return ResponseEntity.ok("Login successful");
    } else {
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid password");
    }
        
        
    }

}

