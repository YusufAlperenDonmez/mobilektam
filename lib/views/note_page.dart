import 'package:flutter/material.dart';

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

    final primaryColor = const Color.fromARGB(255, 67, 78, 177);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ürünler', style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white, size: 28),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            TextField(
              controller: contextController,
              decoration: const InputDecoration(
                labelText: 'Konu',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: noteController,
              maxLines: 10,
              decoration: const InputDecoration(
                labelText: 'Not',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle save action
                final contextText = contextController.text;
                final noteText = noteController.text;
                // Save logic here
                print('Context: $contextText, Note: $noteText');
              },
              child: const Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }
}
