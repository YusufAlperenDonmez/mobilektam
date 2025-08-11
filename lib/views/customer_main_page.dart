import 'package:flutter/material.dart';

class CustomerMainPage extends StatefulWidget {
  const CustomerMainPage({super.key});

  @override
  State<CustomerMainPage> createState() => _CustomerMainPageState();
}

class _CustomerMainPageState extends State<CustomerMainPage> {
  final List<Map<String, String>> genelList = [
    {'label': 'ÖZEL KOD 1', 'value': 'HORECA'},
    {'label': 'ÖZEL KOD 2', 'value': 'GİRNE'},
    {'label': 'ÖZEL KOD 3', 'value': 'CF'},
    {'label': 'ÖZEL KOD 4', 'value': 'Kıbrıs'},
    {'label': 'ÖZEL KOD 5', 'value': 'Kıbrıs'},
    {'label': 'ÖZEL KOD 6', 'value': 'Kıbrıs'},
    {'label': 'ÖZEL KOD 7', 'value': 'Kıbrıs'},
    {'label': 'ÖZEL KOD 8', 'value': 'Kıbrıs'},
    {'label': 'ÖZEL KOD 9', 'value': 'Kıbrıs'},
    {'label': 'ÖZEL KOD 10', 'value': 'Kıbrıs'},
  ];

  final List<Map<String, dynamic>> operationsList = [
    {
      'icon': Icons.shopping_cart,
      'label': 'SATIŞ SİPARİŞİ',
      'onTap': (BuildContext context) {
        Navigator.of(context).pushNamed('/saleOrders');
      },
    },
    // Add more operations as needed
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Northern Cyprus'),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text('GENEL', style: TextStyle(color: Colors.white)),
              ),
              Tab(
                child: Text('İŞLEMLER', style: TextStyle(color: Colors.white)),
              ),
              Tab(
                child: Text('ÖZET', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // GENEL TAB
            ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: Container(
                color: const Color(0xFFE2DDDD),
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: genelList.length,
                  itemBuilder: (context, index) {
                    final item = genelList[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F1F1),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item['label']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              item['value']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // İŞLEMLER TAB
            ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: Container(
                color: const Color(0xFFE2DDDD),
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: operationsList.length,
                  itemBuilder: (context, index) {
                    final item = operationsList[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F1F1),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: Icon(item['icon'], size: 28),
                        title: Text(
                          item['label'],
                          style: const TextStyle(fontSize: 16),
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => item['onTap'](context),
                      ),
                    );
                  },
                ),
              ),
            ),

            // ÖZET TAB
            Center(child: Text('ÖZET')),
          ],
        ),
      ),
    );
  }
}
