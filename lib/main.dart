import 'package:flutter/material.dart';
import 'package:mobilektam/views/login_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(), // Change this line to use LoginPage
    );
  }
}
