import 'package:flutter/material.dart';
import 'search_books_page.dart';
import 'add_book_page.dart';
import 'borrow_book_page.dart';
import 'available_books_page.dart';

class HomePage extends StatelessWidget {
  final String username;
  HomePage({required this.username});
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
            image: AssetImage("assets/library_bg.png"), // your background image
            fit: BoxFit.cover, // makes the image fill the screen
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              margin: EdgeInsets.symmetric(horizontal: 20),
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
                  Text(
                    "Welcome $username !",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 40),
                  _menuButton(
                    context,
                    "Search Books",
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SearchBooksPage()),
                    ),
                    Color.fromARGB(255, 142, 219, 241),
                  ),

                  SizedBox(height: 15),

                  _menuButton(
                    context,
                    "Add Book Details",
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => AddBookPage()),
                    ),
                    Color.fromARGB(255, 246, 245, 248),
                  ),

                  SizedBox(height: 15),

                  _menuButton(
                    context,
                    "Borrow Book Details",
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => BorrowBookPage()),
                    ),
                    Color.fromARGB(255, 242, 170, 222),
                  ),

                  SizedBox(height: 15),

                  _menuButton(
                    context,
                    "Available Book Details",
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => AvailableBooksPage()),
                    ),
                    Color.fromARGB(255, 193, 242, 192),
                  ),

                  SizedBox(height: 40),

                  // BACK / LOGOUT BUTTON
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 250, 235, 175),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/');
                    },
                    child: Text(
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
    Color? color,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        backgroundColor: color,
      ),
      child: Text(text, style: TextStyle(color: Colors.black)),
    );
  }
}
