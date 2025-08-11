import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SaleOrdersPage extends StatefulWidget {
  const SaleOrdersPage({super.key});

  @override
  State<SaleOrdersPage> createState() => _SaleOrdersPageState();
}

class _SaleOrdersPageState extends State<SaleOrdersPage> {
  // Example list, replace with your actual data source
  @override
  void initState() {
    super.initState();
    saleOrders.addAll([
      {'title': 'Sipariş #1001', 'desc': 'Müşteri: Ali Veli - 12/06/2024'},
      {'title': 'Sipariş #1002', 'desc': 'Müşteri: Ayşe Yılmaz - 13/06/2024'},
      {'title': 'Sipariş #1003', 'desc': 'Müşteri: Mehmet Demir - 14/06/2024'},
    ]);
  }

  final List<Map<String, dynamic>> saleOrders = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SATIŞ SİPARİŞLERİ',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.add_circled, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pushNamed('/newOrder');
            },
          ),
        ],
      ),
      body: saleOrders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'İçerik bulunamadı',
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  ),
                ],
              ),
            )
          : ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: saleOrders.length,
                itemBuilder: (context, index) {
                  final order = saleOrders[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(
                        context,
                      ).pushNamed('/viewOrder', arguments: order);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFEFEF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 12,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.receipt_long,
                                size: 32,
                                color: Colors.black54,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      order['date'] ?? '07.08.2025',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'Tutar:',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    order['amount'] ?? '309,048000/TL',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
