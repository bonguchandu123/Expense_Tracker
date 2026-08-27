import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../core/theme.dart';
import '../core/app_state.dart';
import 'transaction_details_screen.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Consumer<AppState>(
        builder: (context, state, child) {
          final balance = state.dashboard?.balance ?? 0.0;
          final transactions = state.transactions;

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 250,
                      decoration: const BoxDecoration(
                        color: AppTheme.primary,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Column(
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.arrow_back_ios, color: Colors.white),
                                  Text("Wallet", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                                  Icon(Icons.notifications_outlined, color: Colors.white),
                                ],
                              ),
                              const SizedBox(height: 30),
                              const Text("Total Balance", style: TextStyle(color: Colors.white70, fontSize: 14)),
                              const SizedBox(height: 8),
                              Text("\$ ${balance.toStringAsFixed(2)}", style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                Positioned(
                  top: 180,
                  left: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(color: AppTheme.cardShadow, blurRadius: 10, offset: Offset(0, 5))
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildActionBtn(Icons.add, "Add"),
                        _buildActionBtn(Icons.qr_code_scanner, "Pay"),
                        _buildActionBtn(Icons.send, "Send"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(child: Text("Transactions", style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const Center(child: Text("Upcoming Bills", style: TextStyle(color: AppTheme.textGrey))),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (transactions.isEmpty)
            SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Text("No transactions yet.", style: TextStyle(color: AppTheme.textGrey)),
                ),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final tx = transactions[index];
                  final isIncome = tx.type.toLowerCase() == 'income';
                  final dateFormat = DateFormat('MMM dd, yyyy');

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => TransactionDetailsScreen(isIncome: isIncome)));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [BoxShadow(color: AppTheme.cardShadow, blurRadius: 10, offset: Offset(0, 5))],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(color: AppTheme.background, borderRadius: BorderRadius.circular(15)),
                            child: Icon(isIncome ? Icons.monetization_on : Icons.coffee, color: isIncome ? AppTheme.income : AppTheme.expense),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(tx.description.isNotEmpty ? tx.description : "Transaction", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                Text(dateFormat.format(tx.date), style: const TextStyle(color: AppTheme.textGrey, fontSize: 12)),
                              ],
                            ),
                          ),
                          Text(
                            "${isIncome ? '+' : '-'}\$ ${tx.amount.toStringAsFixed(2)}",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isIncome ? AppTheme.income : AppTheme.expense),
                          )
                        ],
                      ),
                    ),
                  );
                },
                childCount: transactions.length,
              ),
            ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
        ],
      );
    },
  ),
    );
  }

  Widget _buildActionBtn(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Icon(icon, color: AppTheme.primary),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: AppTheme.textGrey)),
      ],
    );
  }
}
