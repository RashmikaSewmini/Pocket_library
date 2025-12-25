import 'package:flutter/material.dart';
import 'package:frontend/constants/color.dart';
import 'package:frontend/utils/logged_user.dart';
import 'package:frontend/widgets/common_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:frontend/constants/style.dart';
import 'package:frontend/screens/home_page.dart';
import 'package:frontend/widgets/primary_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() async {
    final String username = usernameController.text.trim();
    final String password = passwordController.text.trim();

    LoggedUser.username = username;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter username and password")),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/api/auth/login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"username": username, "password": password}),
      );

      if (response.statusCode == 200) {
        //  STORE USER GLOBALLY
        LoggedUser.username = username;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomePage()),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(response.body)));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Server not reachable")));
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
                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: bgBlack,
                  ),
                ),
                const SizedBox(height: 50),

                TextFormField(
                  controller: usernameController,
                  style: const TextStyle(color: letterwhite),
                  decoration: textInputDecoration.copyWith(
                    hintText: "Username",
                  ),
                ),
                const SizedBox(height: 10),

                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  style: const TextStyle(color: letterwhite),
                  decoration: textInputDecoration.copyWith(
                    hintText: "Password",
                  ),
                ),
                const SizedBox(height: 20),

                PrimaryButton(text: "Login", onPressed: login),

                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text(
                    "If you don't have an account? Sign up.",
                    style: TextStyle(color: bgBlack),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
