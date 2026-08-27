import 'package:flutter/foundation.dart';
import '../models/dashboard_dto.dart';
import '../models/transaction.dart' as app_models;
import 'api_service.dart';

class AppState extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  // Hardcode user ID 1 for now (until auth is built)
  final int currentUserId = 1;

  DashboardDTO? dashboard;
  List<app_models.Transaction> transactions = [];
  
  bool isLoading = false;
  String? error;

  AppState() {
    loadData();
  }

  Future<void> loadData() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final now = DateTime.now();
      
      // Fetch data in parallel
      final results = await Future.wait([
        _apiService.getDashboard(currentUserId, now.month, now.year),
        _apiService.getTransactions(currentUserId),
      ]);

      dashboard = results[0] as DashboardDTO;
      transactions = results[1] as List<app_models.Transaction>;
      
      // Sort transactions by date descending
      transactions.sort((a, b) => b.date.compareTo(a.date));
      
    } catch (e) {
      error = e.toString();
      print("Error loading data: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addExpense(double amount, String description, DateTime date, String type) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final newTransaction = app_models.Transaction(
        amount: amount,
        date: date,
        type: type,
        description: description,
        userId: currentUserId,
        categoryId: 1, // Default category ID for now
      );

      await _apiService.addTransaction(newTransaction);
      
      // Reload data to reflect new balance and transaction list
      await loadData();
    } catch (e) {
      error = e.toString();
      print("Error adding expense: $e");
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
}
