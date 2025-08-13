import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilektam/models/product.dart';
import 'package:mobilektam/services/api_services.dart';
import 'package:mobilektam/views/utility/loading_overlay.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  Future<List<Product>>? futureData;

  @override
  void initState() {
    super.initState();
    futureData = ApiService().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return; // system already handled pop

        if (_isSearching) {
          setState(() {
            _isSearching = false;
            _searchController.clear();
          });
          return; // prevent popping the page
        }

        Navigator.of(context).pop(result); // allow popping the page
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
                        // _isSearching = false;
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
          child: FutureBuilder<List<Product>>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingOverlay(
                  text: 'Ürünler Listeleniyor. Lütfen\nBekleyiniz',
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: {snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No products found.'));
              }

              final products = snapshot.data!;
              return Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8),
                child: GridView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 2.0,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 7.0,
                  ),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return _ProductCard(
                      description: product.description ?? '',
                      product: product.product ?? '',
                      code: product.code ?? '',
                      price: product.price ?? 0.0,
                      physicalQuantity: product.physicalQuantity ?? 0,
                      actualQuantity: product.actualQuantity ?? 0,
                    );
                  },
                ),
              );
            },
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

  const _ProductCard({
    required this.description,
    this.product,
    this.code,
    this.price,
    this.physicalQuantity,
    this.actualQuantity,
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
          color: const Color(0xFFD9D9D9),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top texts
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
            // Code and Price Row
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
                      '${price?.toStringAsFixed(6) ?? '-'} TL',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            // Bottom quantities row
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
