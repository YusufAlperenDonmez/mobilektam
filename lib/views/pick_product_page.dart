import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PickProductPage extends StatefulWidget {
  const PickProductPage({super.key});

  @override
  State<PickProductPage> createState() => _PickProductPageState();
}

class _PickProductPageState extends State<PickProductPage> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  final Set<int> _selectedIndexes = {};

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        if (_isSearching) {
          setState(() {
            _isSearching = false;
            _searchController.clear();
          });
          return;
        }
        Navigator.of(context).pop(result);
      },
      child: Scaffold(
        appBar: AppBar(
          title: _isSearching
              ? TextField(
                  controller: _searchController,
                  autofocus: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Ara...',
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                )
              : const Text('Ürünler', style: TextStyle(color: Colors.white)),
          leading: _isSearching
              ? IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      _isSearching = false;
                      _searchController.clear();
                    });
                  },
                )
              : null,
          actions: [
            _isSearching
                ? IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                      });
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.search, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        _isSearching = true;
                      });
                    },
                  ),
            if (!_isSearching)
              IconButton(
                icon: const Icon(
                  Icons.done_all,
                  color: Colors.white,
                ), // double check
                onPressed: () {
                  // TODO: handle double check action (e.g., confirm selection)
                  Navigator.of(context).pushNamed('/confirmProductSelection');
                },
              ),
            if (!_isSearching)
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onSelected: (value) {
                  // TODO: handle menu selection
                },
                itemBuilder: (BuildContext context) {
                  return const [
                    PopupMenuItem(
                      value: 'option1',
                      child: Text('Hepsini Göster'),
                    ),
                    PopupMenuItem(
                      value: 'option2',
                      child: Text('İsme Göre Filtrele'),
                    ),
                    PopupMenuItem(
                      value: 'option3',
                      child: Text('Gruba Göre Filtrele'),
                    ),
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
                childAspectRatio: 2.0,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 7.0,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_selectedIndexes.contains(index)) {
                        _selectedIndexes.remove(index);
                      } else {
                        _selectedIndexes.add(index);
                      }
                    });
                  },
                  child: _ProductCard(
                    description: '7 UP 1LT. (x12)',
                    product: '7 UP 1 LT',
                    code: '152 EKD-7UPET1X12',
                    price: 309.048,
                    physicalQuantity: 150,
                    actualQuantity: 250,
                    isSelected: _selectedIndexes.contains(index),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final String description;
  final String? product;
  final String? code;
  final double? price;
  final int? physicalQuantity;
  final int? actualQuantity;
  final bool isSelected;

  const _ProductCard({
    required this.description,
    this.product,
    this.code,
    this.price,
    this.physicalQuantity,
    this.actualQuantity,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      shadowColor: Colors.black.withValues(alpha: 0.2),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? Colors.greenAccent : const Color(0xFFD9D9D9),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              product ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(CupertinoIcons.barcode_viewfinder, size: 40),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(code ?? '', style: const TextStyle(fontSize: 13)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Fiyat:'),
                    Text(
                      price != null
                          ? '${price!.toStringAsFixed(6).replaceAll('.', ',')}/TL'
                          : '-',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('Fiili: '),
                    Text(
                      '${physicalQuantity ?? '-'}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('Gerçek: '),
                    Text(
                      '${actualQuantity ?? '-'}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
