import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController contextController = TextEditingController();
    final TextEditingController noteController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Not Al', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFD9D9D9),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 8),
                  ),
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'[\n\r]')),
                ],
                controller: contextController,
                decoration: const InputDecoration(
                  hintText: 'Konu',
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(16.0),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFD9D9D9),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 8),
                  ),
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: noteController,
                maxLines: 5,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'[\n\r]')),
                ],
                decoration: const InputDecoration(
                  hintText: 'Not',
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(16.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 67, 78, 177),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  // Handle save action
                  //final contextText = contextController.text;
                  //final noteText = noteController.text;
                  // Save logic here
                  //print('Context: $contextText, Note: $noteText');
                },
                child: const Text(
                  'Kaydet',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
