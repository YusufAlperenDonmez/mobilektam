import 'package:flutter/material.dart';
import 'package:mobilektam/views/login_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  // Example data; replace with your real items
  final List<String> menuItems = List.generate(
    5,
    (index) => 'Item ${index + 1}',
  );

  void _onLogoutPressed() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Çıkışı Onayla'),
        content: const Text('Çıkış yapmak istediğinize emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Çıkış Yap'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      Navigator.of(context).pop(); // or your actual logout logic
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuDefs = [
      {'label': 'Ürünler', 'icon': Icons.shopping_cart, 'route': '/products'},
      {'label': 'Müşteriler', 'icon': Icons.people, 'route': '/customers'},
      {
        'label': 'Veri Aktarımı',
        'icon': Icons.sync_alt,
        'route': '/data-transfer',
      },
      {'label': 'Raporlama', 'icon': Icons.bar_chart, 'route': '/reporting'},
      {'label': 'Not Al', 'icon': Icons.sticky_note_2, 'route': '/notes'},
    ];

    final primaryColor = const Color.fromARGB(255, 67, 78, 177);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EKTAM LTD. 2025',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            iconSize: 28,
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
            tooltip: 'Logout',
            onPressed: _onLogoutPressed,
          ),
        ],
      ),
      body: Column(
        children: [
          // Top half: white background with grid
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                itemCount: menuItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 3 items per row
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final def = menuDefs[index];
                  return _MenuCard(
                    label: def['label'] as String,
                    icon: def['icon'] as IconData,
                    onTap: () =>
                        Navigator.pushNamed(context, def['route'] as String),
                  );
                },
              ),
            ),
          ),
          // Bottom half: grey area
          Expanded(
            child: Container(
              width: double.infinity,
              color: const Color(0xFFD9D9D9),
              // You can add content here later
              child: const Center(
                child: Text('Bottom Section', style: TextStyle(fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  const _MenuCard({required this.label, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 32),
              const SizedBox(height: 6),
              Text(
                label,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
