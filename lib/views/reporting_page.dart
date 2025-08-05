import 'package:flutter/material.dart';

class ReportingPage extends StatefulWidget {
  const ReportingPage({super.key});

  @override
  State<ReportingPage> createState() => _ReportingPageState();
}

class _ReportingPageState extends State<ReportingPage> {
  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color.fromARGB(255, 67, 78, 177);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Raporlama', style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white, size: 28),
      ),
    );
  }
}
