import 'package:flutter/material.dart';
import 'package:frontend/constants/color.dart';
import 'package:frontend/widgets/common_page.dart';
import 'package:frontend/widgets/primary_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BorrowBookPage extends StatefulWidget {
  final String bookId;
  final String bookName;

  const BorrowBookPage({
    super.key,
    required this.bookId,
    required this.bookName,
  });

  @override
  _BorrowBookPageState createState() => _BorrowBookPageState();
}

class _BorrowBookPageState extends State<BorrowBookPage> {
  final TextEditingController borrowerController = TextEditingController();
  bool loading = false;

  void borrowBook() async {
    final borrower = borrowerController.text.trim();
    if (borrower.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Enter your name")));
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/books/borrow'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"bookId": widget.bookId, "borrowedBy": borrower}),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Book borrowed successfully")),
        );
        Navigator.pop(context); // go back to available books page
      } else if (response.statusCode == 400) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Book not available")));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Failed to borrow book")));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Server not reachable")));
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonPage(
      title: "Borrow Books",
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: backgroundGray.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text(
                  widget.bookName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: borrowerController,
                  decoration: const InputDecoration(
                    hintText: "Enter borrower Name",
                  ),
                ),
                const SizedBox(height: 20),
                loading
                    ? const CircularProgressIndicator()
                    : PrimaryButton(text: "Borrow", onPressed: borrowBook),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
