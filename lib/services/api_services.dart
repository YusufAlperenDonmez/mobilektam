import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobilektam/models/sale_rep.dart';
import 'package:mobilektam/models/product.dart';

class ServerStatus {
  final bool serverUp;
  final bool dbConnected;

  ServerStatus({required this.serverUp, required this.dbConnected});
}

class ApiService {
  final String baseUrl = "http://192.168.2.43:2000";

  // Check if backend server and DB are reachable
  Future<ServerStatus> checkServerConnection() async {
    try {
      print('Attempting to check server connection...');
      final uri = Uri.parse('$baseUrl/health');
      print('Request URI: $uri');
      final response = await http.get(uri);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 503) {
        final data = jsonDecode(response.body);
        print('Decoded response: $data');

        bool dbConnected = data['db'] == 'connected';
        bool serverUp =
            response.statusCode == 200 || response.statusCode == 503;

        print('dbConnected: $dbConnected, serverUp: $serverUp');
        return ServerStatus(serverUp: serverUp, dbConnected: dbConnected);
      } else {
        print('Unexpected status code, treating as not connected.');
        return ServerStatus(serverUp: false, dbConnected: false);
      }
    } catch (e) {
      print('Exception during server check: $e');
      return ServerStatus(serverUp: false, dbConnected: false);
    }
  }

  // Check sales rep by username and password
  Future<SaleRep?> checkUser(String username, String password) async {
    final uri = Uri.parse(
      '$baseUrl/sales-representatives/check-user',
    ).replace(queryParameters: {'username': username, 'password': password});

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return SaleRep.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      return null; // Not found
    } else {
      throw Exception('Error checking sales representative');
    }
  }

  // Fetch products from the server
  Future<List<Product>> fetchProducts() async {
    final uri = Uri.parse('$baseUrl/products');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch products');
    }
  }
}
