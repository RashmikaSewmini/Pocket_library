import 'package:flutter/material.dart';
import 'package:frontend/constants/color.dart';
import 'package:frontend/widgets/common_page.dart';
import 'package:frontend/widgets/primary_button.dart';
import 'search_books_page.dart';
import 'package:frontend/screens/AddBookPage.dart';
import 'package:frontend/screens/borrow_book_page.dart';
import 'package:frontend/screens/available_books_page.dart';
import 'package:frontend/utils/logged_user.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // GLOBAL USERNAME
                Text(
                  "Welcome ${LoggedUser.username}!",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: bgBlack,
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
                    MaterialPageRoute(
                      builder: (_) => BorrowBookPage(bookId: "", bookName: ""),
                    ),
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

                PrimaryButton(
                  text: "Logout",
                  onPressed: () {
                    // LOGOUT CLEANUP
                    LoggedUser.username = "";
                    Navigator.pushReplacementNamed(context, '/');
                  },
                ),
              ],
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
