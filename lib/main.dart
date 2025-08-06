import 'package:flutter/material.dart';
import 'package:mobilektam/views/customers_page.dart';
import 'package:mobilektam/views/data_transfer_page.dart';
import 'package:mobilektam/views/login_page.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mobilektam/views/note_page.dart';
import 'package:mobilektam/views/product_page.dart';
import 'package:mobilektam/views/reporting_page.dart';

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
  @override
  void initState() {
    super.initState();
    // Remove splash after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // ✅ Set global primary color
        primaryColor: const Color(0xFF434EB1),

        // ✅ Customize app bar theme
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
      },
    );
  }
}
