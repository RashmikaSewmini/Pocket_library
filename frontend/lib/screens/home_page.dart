import 'package:flutter/material.dart';
import 'search_books_page.dart';
import 'package:frontend/screens/AddBookPage.dart';
import 'package:frontend/screens/borrow_book_page.dart';
import 'package:frontend/screens/available_books_page.dart';
import 'package:frontend/utils/logged_user.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                  248,
                  162,
                  159,
                  159,
                ).withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ✅ GLOBAL USERNAME
                  Text(
                    "Welcome ${LoggedUser.username}!",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 40),

                  _menuButton(
                    context,
                    "Search Books",
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SearchBooksPage()),
                    ),
                    const Color.fromARGB(255, 142, 219, 241),
                  ),

                  const SizedBox(height: 15),

                  _menuButton(
                    context,
                    "Add Book Details",
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => AddBookPage()),
                    ),
                    const Color.fromARGB(255, 246, 245, 248),
                  ),

                  const SizedBox(height: 15),

                  _menuButton(
                    context,
                    "Borrow Book Details",
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => BorrowBookPage()),
                    ),
                    const Color.fromARGB(255, 242, 170, 222),
                  ),

                  const SizedBox(height: 15),

                  _menuButton(
                    context,
                    "Available Book Details",
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => AvailableBooksPage()),
                    ),
                    const Color.fromARGB(255, 193, 242, 192),
                  ),

                  const SizedBox(height: 40),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 250, 235, 175),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                    ),
                    onPressed: () {
                      // LOGOUT CLEANUP
                      LoggedUser.username = "";
                      Navigator.pushReplacementNamed(context, '/');
                    },
                    child: const Text(
                      "Logout",
                      style: TextStyle(color: Colors.black),
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

  Widget _menuButton(
    BuildContext context,
    String text,
    VoidCallback onPressed,
    Color color,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: color,
      ),
      child: Text(text, style: const TextStyle(color: Colors.black)),
    );
  }
}
