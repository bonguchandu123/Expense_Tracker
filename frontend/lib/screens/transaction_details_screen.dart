import 'package:flutter/material.dart';
import '../core/theme.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final bool isIncome;
  
  const TransactionDetailsScreen({super.key, required this.isIncome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Transaction Details", style: TextStyle(color: Colors.white)),
        actions: const [Icon(Icons.more_horiz, color: Colors.white), SizedBox(width: 20)],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: AppTheme.background,
                    child: Icon(isIncome ? Icons.monetization_on : Icons.person, color: isIncome ? AppTheme.income : AppTheme.expense, size: 40),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: isIncome ? AppTheme.income.withOpacity(0.1) : AppTheme.expense.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isIncome ? "Income" : "Expense",
                      style: TextStyle(color: isIncome ? AppTheme.income : AppTheme.expense, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isIncome ? "\$ 850.00" : "\$ 85.00",
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Transaction details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Icon(Icons.keyboard_arrow_up, color: Colors.grey.shade400),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildDetailRow("Status", isIncome ? "Income" : "Expense", valueColor: isIncome ? AppTheme.income : AppTheme.expense),
                  _buildDetailRow(isIncome ? "From" : "To", isIncome ? "Upwork Escrow" : "Claire Jovalski"),
                  _buildDetailRow("Time", "10:00 AM"),
                  _buildDetailRow("Date", "Feb 30, 2022"),
                  const Divider(height: 40, thickness: 1),
                  _buildDetailRow(isIncome ? "Earnings" : "Spending", isIncome ? "\$ 870.00" : "\$ 85.00"),
                  _buildDetailRow("Fee", isIncome ? "- \$ 20.00" : "- \$ 0.99"),
                  const Divider(height: 40, thickness: 1),
                  _buildDetailRow("Total", isIncome ? "\$ 850.00" : "\$ 84.00", isBold: true),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        side: const BorderSide(color: AppTheme.primary),
                      ),
                      onPressed: () {},
                      child: const Text("Download Receipt", style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppTheme.textGrey, fontSize: 14)),
          Text(
            value,
            style: TextStyle(
              color: valueColor ?? AppTheme.textDark,
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
