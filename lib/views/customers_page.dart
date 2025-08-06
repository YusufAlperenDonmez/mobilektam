import 'package:flutter/material.dart';

class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key});

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Müşteriler', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // TODO: implement search action
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              // TODO: handle menu selection
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(value: 'option1', child: Text('Seçenek 1')),
                const PopupMenuItem(value: 'option2', child: Text('Seçenek 2')),
              ];
            },
          ),
        ],
      ),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(8),
          child: GridView.builder(
            physics: const ClampingScrollPhysics(),
            itemCount: 10,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 3.0,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 7.0,
            ),
            itemBuilder: (context, index) {
              return _CustomerCard(
                name: 'Müşteri ${index + 1}',
                details: 'Detay ${index + 1}',
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CustomerCard extends StatelessWidget {
  final String name;
  final String? details;

  const _CustomerCard({required this.name, this.details});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      shadowColor: Colors.black.withValues(alpha: 0.15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFFD9D9D9),
        ),
        child: Row(
          children: [
            const Icon(Icons.person, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontSize: 18)),
                  if (details != null)
                    Text(details!, style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
