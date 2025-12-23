package com.example.mobile_mini_library.model;


import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "books")
public class Book {

    @Id
    private String id;

    private String name;
    private String author;
    private boolean availability;
    private String description;
    private String userId; // username of the owner

    // Constructors
    public Book() {}

    public Book(String name, String author, boolean availability, String description, String userId) {
        this.name = name;
        this.author = author;
        this.availability = availability;
        this.description = description;
        this.userId =userId;
    }

    // Getters and Setters
    public String getId() { return id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }
    public boolean isAvailability() { return availability; }
    public void setAvailability(boolean availability) { this.availability = availability; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
}
