import 'package:flutter/material.dart';
import 'package:frontend/utils/logged_user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AvailableBooksPage extends StatefulWidget {
  const AvailableBooksPage({super.key});

  @override
  State<AvailableBooksPage> createState() => _AvailableBooksPageState();
}

class _AvailableBooksPageState extends State<AvailableBooksPage> {
  List books = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchMyBooks();
  }

  Future<void> fetchMyBooks() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/books/my?userId=${LoggedUser.username}'),
    );

    if (response.statusCode == 200) {
      setState(() {
        books = jsonDecode(response.body);
        loading = false;
      });
    } else {
      setState(() => loading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to load books")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Books"),
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
            ? Center(child: CircularProgressIndicator())
            : books.isEmpty
            ? Center(child: Text("No books added yet"))
            : ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  return Card(
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(book['name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Author: ${book['author']}"),
                          Text(
                            "Available: ${book['availability'] ? 'Yes' : 'No'}",
                          ),
                          Text("Description: ${book['description']}"),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
