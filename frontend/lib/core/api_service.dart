import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/dashboard_dto.dart';
import '../models/transaction.dart';

class ApiService {
  // Use 10.0.2.2 to access host machine's localhost from Android Emulator
  static const String baseUrl = 'http://10.0.2.2:8080/api';

  Future<DashboardDTO> getDashboard(int userId, int month, int year) async {
    final response = await http.get(Uri.parse('$baseUrl/dashboard/$userId?month=$month&year=$year'));

    if (response.statusCode == 200) {
      return DashboardDTO.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load dashboard data');
    }
  }

  Future<List<Transaction>> getTransactions(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/transactions/$userId'));

    if (response.statusCode == 200) {
      Iterable l = jsonDecode(response.body);
      return List<Transaction>.from(l.map((model) => Transaction.fromJson(model)));
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  Future<Transaction> addTransaction(Transaction transaction) async {
    final response = await http.post(
      Uri.parse('$baseUrl/transactions/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(transaction.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Transaction.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add transaction');
    }
  }
}
