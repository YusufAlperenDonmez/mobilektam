import 'package:flutter/material.dart';

class ConfirmProductSelectionPage extends StatefulWidget {
  const ConfirmProductSelectionPage({super.key});

  @override
  State<ConfirmProductSelectionPage> createState() =>
      _ConfirmProductSelectionPageState();
}

class _ConfirmProductSelectionPageState
    extends State<ConfirmProductSelectionPage> {
  final List<_ProductItem> items = [
    _ProductItem(name: '7 UP 1LT. (x12)', price: 309.04, quantity: 1.0),
    _ProductItem(name: 'Pepsi 1LT. (x12)', price: 299.99, quantity: 2.0),
    _ProductItem(name: 'Fruko 1LT. (x12)', price: 279.50, quantity: 0.0),
    _ProductItem(name: 'Fruko 1LT. (x12)', price: 279.50, quantity: 0.0),
    _ProductItem(name: 'Fruko 1LT. (x12)', price: 279.50, quantity: 0.0),
    _ProductItem(name: 'Fruko 1LT. (x12)', price: 279.50, quantity: 0.0),
  ];

  void _updateQuantity(int index, double newQuantity) {
    setState(() {
      items[index] = items[index].copyWith(quantity: newQuantity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ürünler'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all, color: Colors.white),
            onPressed: () {
              // TODO: Confirm selection action
            },
          ),
        ],
      ),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _ProductCard(
                name: item.name,
                price: item.price,
                quantity: item.quantity,
                onQuantityChanged: (newQuantity) =>
                    _updateQuantity(index, newQuantity),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ProductItem {
  final String name;
  final double price;
  final double quantity;

  _ProductItem({
    required this.name,
    required this.price,
    required this.quantity,
  });

  _ProductItem copyWith({String? name, double? price, double? quantity}) {
    return _ProductItem(
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}

class _ProductCard extends StatelessWidget {
  final String name;
  final double price;
  final double quantity;
  final ValueChanged<double> onQuantityChanged;

  const _ProductCard({
    required this.name,
    required this.price,
    required this.quantity,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('M :', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: () {
                  if (quantity > 0.0) {
                    onQuantityChanged(quantity - 1.0);
                  }
                },
              ),
              Container(
                width: 40,
                alignment: Alignment.center,
                child: Text(
                  quantity.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: () {
                  onQuantityChanged(quantity + 1.0);
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text('T.Fiyat: ', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 4),
              Text(
                '${price.toStringAsFixed(2).replaceAll('.', ',')}TL',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
