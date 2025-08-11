import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewOrderPage extends StatefulWidget {
  const NewOrderPage({super.key});

  @override
  State<NewOrderPage> createState() => _NewOrderPageState();
}

class _NewOrderPageState extends State<NewOrderPage> {
  bool _expanded = false;

  // When building your dummy data, add a unique id:
  final List<Map<String, dynamic>> orderItems = List.generate(
    6,
    (i) => {
      'id': i, // unique id
      'name': '7 UP 1LT. (x12)',
      'code': '152.EKD-7UPET1X12',
      'detail': '(1.0 KOLİ X 454,49 TL ) = 454,49 TL',
      'price': '$i',
      'unit': '(454,49/KOLİ)',
    },
  );

  double get subtotal => orderItems.fold(
    0.0,
    (sum, item) =>
        sum +
        (double.tryParse(
              item['price']
                  .toString()
                  .replaceAll('.', '')
                  .replaceAll(',', '.')
                  .replaceAll(' TL', ''),
            ) ??
            0.0),
  );

  double get kdv => subtotal * 0.10;
  double get net => subtotal + kdv;
  int get satirSayisi => orderItems.length;
  double get sku => 2.0;
  double get miktar => 2.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Yeni Sipariş',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 67, 78, 177),
        actions: [
          IconButton(
            icon: const Icon(Icons.save, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            child: InkWell(
              onTap: () {
                // TODO: Add your action here (e.g., open product selection)
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Center(
                  child: Text(
                    'ÜRÜN SEÇ',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Divider(height: 1, thickness: 1),
          Expanded(
            child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: orderItems.length,
                itemBuilder: (context, index) {
                  final item = orderItems[index];
                  return Dismissible(
                    key: ValueKey(item['id']),
                    direction: DismissDirection.horizontal,
                    onDismissed: (direction) {
                      // Save removed item and index for undo
                      final removedItem = item;
                      final removedIndex = index;
                      setState(() {
                        orderItems.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Ürün listeden çıkarıldı!'),
                          action: SnackBarAction(
                            label: 'GERİ AL',
                            onPressed: () {
                              setState(() {
                                orderItems.insert(
                                  removedIndex > orderItems.length
                                      ? orderItems.length
                                      : removedIndex,
                                  removedItem,
                                );
                              });
                            },
                          ),
                          duration: const Duration(seconds: 3),
                        ),
                      );
                    },
                    // No background or secondaryBackground for a clean swipe
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
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
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        leading: const Icon(Icons.receipt_long, size: 36),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item['code'],
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['detail'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item['price'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['unit'],
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        clipBehavior: Clip.hardEdge,
        child: Material(
          color: const Color.fromARGB(255, 255, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _expanded
                            ? CupertinoIcons.arrow_down_circle
                            : CupertinoIcons.arrow_up_circle,
                        color: Colors.white,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'TOPLAM :',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        subtotal.toStringAsFixed(2).replaceAll('.', ','),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (_expanded)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _bottomRow('İNDİRİM :', '0,00'),
                      _bottomRow(
                        'KDV :',
                        kdv.toStringAsFixed(2).replaceAll('.', ','),
                      ),
                      _bottomRow(
                        'NET :',
                        net.toStringAsFixed(2).replaceAll('.', ','),
                      ),
                      _bottomRow('SATIR SAYISI :', satirSayisi.toString()),
                      _bottomRow('SKU :', sku.toStringAsFixed(1)),
                      _bottomRow('MİKTAR :', miktar.toStringAsFixed(1)),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
