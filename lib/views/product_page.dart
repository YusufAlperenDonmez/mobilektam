import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color.fromARGB(255, 67, 78, 177);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ürünler', style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white, size: 28),
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
              return _ProductCard(
                title: 'Ürün ${index + 1}',
                subtitle: 'Açıklama ${index + 1}',
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final String title;
  final String? subtitle;

  const _ProductCard({required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      shadowColor: Colors.black.withOpacity(0.15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFFD9D9D9),
        ),
        child: Row(
          children: [
            const Icon(Icons.barcode_reader, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // optional static indicator
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
