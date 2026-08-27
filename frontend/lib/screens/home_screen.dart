import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../core/theme.dart';
import '../core/app_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Consumer<AppState>(
        builder: (context, state, child) {
          if (state.isLoading && state.dashboard == null) {
            return const Center(child: CircularProgressIndicator());
          }
          
          final dashboard = state.dashboard;
          final transactions = state.transactions;

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _buildHeader(context, dashboard),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Transactions History",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                      ),
                      Text(
                        "See all",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.textGrey,
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
                      
                      return _buildTransactionItem(
                        context,
                        title: tx.description.isNotEmpty ? tx.description : "Transaction",
                        subtitle: dateFormat.format(tx.date),
                        amount: "${isIncome ? '+' : '-'}\$ ${tx.amount.toStringAsFixed(2)}",
                        isIncome: isIncome,
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

  Widget _buildHeader(BuildContext context, dynamic dashboard) {
    final balance = dashboard?.balance ?? 0.0;
    final income = dashboard?.totalIncome ?? 0.0;
    final expenses = dashboard?.totalExpenses ?? 0.0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 280,
          decoration: const BoxDecoration(
            color: AppTheme.primary,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good afternoon,",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white70,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Enjelin Morgeana",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.notifications_outlined, color: Colors.white),
                  )
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 140,
          left: 20,
          right: 20,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.primaryDark,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: AppTheme.cardShadow,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Balance",
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    Icon(Icons.more_horiz, color: Colors.white),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "\$ ${balance.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildIncomeExpenseBlock(
                      icon: Icons.arrow_downward,
                      label: "Income",
                      amount: "\$ ${income.toStringAsFixed(2)}",
                    ),
                    _buildIncomeExpenseBlock(
                      icon: Icons.arrow_upward,
                      label: "Expenses",
                      amount: "\$ ${expenses.toStringAsFixed(2)}",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIncomeExpenseBlock({required IconData icon, required String label, required String amount}) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 16),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
            Text(amount, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _buildTransactionItem(BuildContext context, {required String title, required String subtitle, required String amount, required bool isIncome}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: AppTheme.cardShadow,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppTheme.background,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              isIncome ? Icons.monetization_on : Icons.coffee,
              color: isIncome ? AppTheme.income : AppTheme.expense,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isIncome ? AppTheme.income : AppTheme.expense,
            ),
          ),
        ],
      ),
    );
  }
}
