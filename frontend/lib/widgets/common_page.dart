import 'package:flutter/material.dart';
import 'package:frontend/constants/color.dart';

class CommonPage extends StatelessWidget {
  final Widget body;
  final String? title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  const CommonPage({
    super.key,
    required this.body,
    this.title,
    this.actions,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeYellow,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: themeYellow,
        title: title != null ? Text(title!) : null,
        actions: actions,
      ),

      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/library_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: body,
      ),

      floatingActionButton: floatingActionButton,
    );
  }
}
