import 'package:flutter/material.dart';
import 'package:frontend/constants/color.dart';
import 'package:frontend/constants/style.dart';
import 'package:frontend/utils/logged_user.dart';
import 'package:frontend/widgets/common_page.dart';
import 'package:frontend/widgets/primary_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _nameController = TextEditingController();
  final _authorController = TextEditingController();
  final _descriptionController = TextEditingController();

  void addBook() async {
    var response = await http.post(
      Uri.parse('http://10.0.2.2:8080/books/add'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": _nameController.text,
        "author": _authorController.text,
        "availability": 'true',
        "description": _descriptionController.text,
        "userId": LoggedUser.username, // GLOBAL USER
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Book added successfully")));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to add book")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonPage(
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
                SizedBox(height: 30),
                TextFormField(
                  controller: _nameController,
                  style: TextStyle(color: letterwhite),
                  decoration: textInputDecoration.copyWith(
                    hintText: "Book Name",
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _authorController,
                  style: TextStyle(color: letterwhite),
                  decoration: textInputDecoration.copyWith(hintText: "Author"),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _descriptionController,
                  style: TextStyle(color: letterwhite),
                  decoration: textInputDecoration.copyWith(
                    hintText: "Description",
                  ),
                ),
                SizedBox(height: 20),
                PrimaryButton(text: "Add Book", onPressed: addBook),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
