import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend/utils/logged_user.dart';

class SearchBooksPage extends StatefulWidget {
  const SearchBooksPage({super.key});

  @override
  _SearchBooksPageState createState() => _SearchBooksPageState();
}

class _SearchBooksPageState extends State<SearchBooksPage> {
  final TextEditingController searchController = TextEditingController();
  List books = [];
  bool loading = false;

  void searchBooks() async {
    final query = searchController.text.trim();

    if (query.isEmpty) return;

    setState(() {
      loading = true;
    });

    final response = await http.get(
      Uri.parse(
        'http://10.0.2.2:8080/books/search'
        '?query=$query'
        '&userId=${LoggedUser.username}',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        books = jsonDecode(response.body);
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to load books")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 234, 162),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 244, 239, 201),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/library_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            decoration: BoxDecoration(
              color: const Color.fromARGB(248, 162, 159, 159).withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // SEARCH BAR
                  TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Search by book name or author",
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        color: Colors.blue,
                        onPressed: searchBooks,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // RESULTS
                  Expanded(
                    child: loading
                        ? const Center(child: CircularProgressIndicator())
                        : books.isEmpty
                        ? const Text("No books found")
                        : ListView.builder(
                            itemCount: books.length,
                            itemBuilder: (context, index) {
                              final book = books[index];
                              return Card(
                                child: ListTile(
                                  title: Text(book['name']),
                                  subtitle: Text(
                                    "Author: ${book['author']}\n"
                                    "Available: ${book['availability']}\n"
                                    "Borrowed by: ${book['borrowedBy'] ?? 'N/A'}\n"
                                    " Borrowed on: ${book['borrowedDate'] ?? 'N/A'}",
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
