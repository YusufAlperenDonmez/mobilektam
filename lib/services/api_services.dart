import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobilektam/models/sale_rep.dart';

class ServerStatus {
  final bool serverUp;
  final bool dbConnected;

  ServerStatus({required this.serverUp, required this.dbConnected});
}

class ApiService {
  final String baseUrl = "http://10.0.2.2:2000/";

  // Check if backend server and DB are reachable
  Future<ServerStatus> checkServerConnection() async {
    try {
      final uri = Uri.parse('$baseUrl/health');
      final response = await http.get(uri);

      if (response.statusCode == 200 || response.statusCode == 503) {
        final data = jsonDecode(response.body);

        bool dbConnected = data['db'] == 'connected';
        bool serverUp =
            response.statusCode == 200 || response.statusCode == 503;

        return ServerStatus(serverUp: serverUp, dbConnected: dbConnected);
      } else {
        return ServerStatus(serverUp: false, dbConnected: false);
      }
    } catch (e) {
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
}
