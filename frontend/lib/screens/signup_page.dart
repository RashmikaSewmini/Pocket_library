import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/constants/color.dart';
import 'package:frontend/constants/style.dart';
import 'package:frontend/screens/home_page.dart';
import 'package:frontend/widgets/common_page.dart';
import 'package:frontend/widgets/primary_button.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  void signup() async {
    if (passwordController.text != confirmController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Passwords do not match")));
      return;
    }

    try {
      var response = await http.post(
        Uri.parse('http://10.0.2.2:8080/api/auth/signup'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": usernameController.text,
          "email": emailController.text,
          "password": passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Signup successful!")));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Signup failed: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Cannot connect to server")));
    }
  }

  Widget build(BuildContext context) {
    return CommonPage(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: backgroundGray.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: bgBlack,
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: usernameController,
                  style: TextStyle(color: letterwhite),
                  decoration: textInputDecoration.copyWith(
                    hintText: "username",
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: emailController,
                  style: TextStyle(color: letterwhite),
                  decoration: textInputDecoration.copyWith(hintText: "email"),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: passwordController,
                  style: TextStyle(color: letterwhite),
                  obscureText: true,
                  decoration: textInputDecoration.copyWith(
                    hintText: "password",
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: confirmController,
                  style: TextStyle(color: letterwhite),
                  obscureText: true,
                  decoration: textInputDecoration.copyWith(
                    hintText: "Confirm Password",
                  ),
                ),
                SizedBox(height: 20),
                PrimaryButton(text: "Sign-up", onPressed: signup),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
