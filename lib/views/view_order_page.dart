import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewOrderPage extends StatefulWidget {
  const ViewOrderPage({super.key});

  @override
  State<ViewOrderPage> createState() => _ViewOrderPageState();
}

class _ViewOrderPageState extends State<ViewOrderPage> {
  bool _expanded = false;

  final List<Map<String, dynamic>> orderItems = [
    {
      'name': '7 UP 33 CL SLEEK (x24)',
      'code': '152.EKD-7U33SX24',
      'detail': '(1.0 KOLİ X 454,49 TL ) = 454,49 TL',
      'price': '454,49 TL',
      'unit': '(454,49/KOLİ)',
    },
    {
      'name': '7 UP 25 CL (x6)',
      'code': '152.EKD-7UP25SX6',
      'detail': '(1.0 KOLİ X 95,46 TL ) = 95,46 TL',
      'price': '95,46 TL',
      'unit': '(95,46/KOLİ)',
    },
    {
      'name': '7 UP 45 CL PET (x12)',
      'code': '152.EKD-7UPET45X12',
      'detail': '(2.0 KOLİ X 227,24 TL ) = 454,48 TL',
      'price': '454,48 TL',
      'unit': '(227,24/KOLİ)',
    },
    {
      'name': '7 UP 45 CL PET (x12)',
      'code': '152.EKD-7UPET45X12',
      'detail': '(2.0 KOLİ X 227,24 TL ) = 454,48 TL',
      'price': '454,48 TL',
      'unit': '(227,24/KOLİ)',
    },
    {
      'name': '7 UP 45 CL PET (x12)',
      'code': '152.EKD-7UPET45X12',
      'detail': '(2.0 KOLİ X 227,24 TL ) = 454,48 TL',
      'price': '454,48 TL',
      'unit': '(227,24/KOLİ)',
    },
  ];

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
  double get sku => 3.0;
  double get miktar => 4.0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'İNCELE SİPARİŞ',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: TabBarView(
          children: [
            // BAŞLIK
            Center(child: Text('BAŞLIK')),
            // İÇERİK
            ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: orderItems.length,
                itemBuilder: (context, index) {
                  final item = orderItems[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F1F1),
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
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          // Only minHeight, no maxHeight
          constraints: const BoxConstraints(minHeight: 44),
          child: Material(
            color: Colors.red,
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
