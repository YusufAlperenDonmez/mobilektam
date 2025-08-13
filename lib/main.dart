import 'package:flutter/material.dart';
import 'package:mobilektam/services/api_services.dart'; // <-- Import your service
import 'package:mobilektam/views/confirm_product_selection_page.dart';
import 'package:mobilektam/views/customer_main_page.dart';
import 'package:mobilektam/views/customers_page.dart';
import 'package:mobilektam/views/data_transfer_page.dart';
import 'package:mobilektam/views/login_page.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mobilektam/views/new_order_page.dart';
import 'package:mobilektam/views/note_page.dart';
import 'package:mobilektam/views/pick_product_page.dart';
import 'package:mobilektam/views/product_page.dart';
import 'package:mobilektam/views/reporting_page.dart';
import 'package:mobilektam/views/sale_orders_page.dart';
import 'package:mobilektam/views/view_order_page.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool? _serverReady;

  @override
  void initState() {
    super.initState();
    _checkServer();
  }

  Future<void> _checkServer() async {
    final status = await ApiService().checkServerConnection();
    setState(() {
      _serverReady = status.serverUp && status.dbConnected;
    });
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    if (_serverReady == null) {
      // Still checking, keep splash
      return const SizedBox.shrink();
    }
    if (_serverReady == false) {
      // Show error if not connected
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.cloud_off, color: Colors.red, size: 64),
                const SizedBox(height: 16),
                const Text(
                  'Sunucuya veya veritabanına bağlanılamadı.',
                  style: TextStyle(fontSize: 18, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _serverReady = null;
                    });
                    _checkServer();
                  },
                  child: const Text('Tekrar Dene'),
                ),
              ],
            ),
          ),
        ),
      );
    }
    // Server is ready, show app
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF434EB1),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF434EB1),
          foregroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.white, size: 28),
        ),
      ),
      builder: (context, child) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return Scaffold(
            body: Center(child: Text(errorDetails.exceptionAsString())),
          );
        };
        return child!;
      },
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/products': (context) => const ProductPage(),
        '/customers': (context) => const CustomersPage(),
        '/data-transfer': (context) => const DataTransferPage(),
        '/reporting': (context) => const ReportingPage(),
        '/notes': (context) => const NotePage(),
        '/customerMain': (context) => const CustomerMainPage(),
        '/saleOrders': (context) => const SaleOrdersPage(),
        '/viewOrder': (context) => const ViewOrderPage(),
        '/newOrder': (context) => const NewOrderPage(),
        '/productSelection': (context) => const PickProductPage(),
        '/confirmProductSelection': (context) =>
            const ConfirmProductSelectionPage(),
      },
    );
  }
}
