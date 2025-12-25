import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend/utils/logged_user.dart';
import 'package:frontend/screens/borrow_book_page.dart';

class AvailableBooksPage extends StatefulWidget {
  const AvailableBooksPage({super.key});

  @override
  _AvailableBooksPageState createState() => _AvailableBooksPageState();
}

class _AvailableBooksPageState extends State<AvailableBooksPage> {
  List books = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  void fetchBooks() async {
    try {
      final response = await http.get(
        Uri.parse(
          'http://10.0.2.2:8080/books/my?userId=${LoggedUser.username}',
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
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
    } catch (e) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Server not reachable")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 234, 162),
      appBar: AppBar(
        title: const Text("My Books"),
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
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : books.isEmpty
            ? const Center(child: Text("No books found"))
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  return Card(
                    child: ListTile(
                      title: Text(book['name'] ?? 'No Name'),
                      subtitle: Text(
                        "Author: ${book['author'] ?? 'Unknown'}\n"
                        "Available: ${book['availability'] ?? 'Unknown'}\n"
                        "Borrowed by: ${book['borrowedBy'] ?? 'N/A'}\n"
                        " Borrowed on: ${book['borrowedDate'] ?? 'N/A'}",
                      ),
                      trailing: (book['availability'] ?? false)
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  224,
                                  234,
                                  146,
                                ),
                              ),
                              onPressed: () {
                                if (book['id'] != null &&
                                    book['name'] != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => BorrowBookPage(
                                        bookId: book['id'],
                                        bookName: book['name'],
                                      ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Invalid book data"),
                                    ),
                                  );
                                }
                              },
                              child: const Text(
                                "Borrow",
                                style: TextStyle(color: Color(0xFF000000)),
                              ),
                            )
                          : const Text(
                              "Not Available",
                              style: TextStyle(color: Colors.red),
                            ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
