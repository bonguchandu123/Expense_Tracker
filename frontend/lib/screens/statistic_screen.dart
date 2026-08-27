import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../core/theme.dart';
import '../core/app_state.dart';

class StatisticScreen extends StatelessWidget {
  const StatisticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text("Statistics"),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {},
          )
        ],
      ),
      body: Consumer<AppState>(
        builder: (context, state, child) {
          final transactions = state.transactions.where((t) => t.type.toLowerCase() != 'income').toList();
          
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
            // Time Filter
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTimeFilter("Day", false),
                  _buildTimeFilter("Week", true), // Selected
                  _buildTimeFilter("Month", false),
                  _buildTimeFilter("Year", false),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Expense Dropdown
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Expense", style: TextStyle(fontWeight: FontWeight.bold)),
                      Icon(Icons.keyboard_arrow_down, size: 20),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Chart Area
            Container(
              height: 200,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: FlTitlesData(
                    show: true,
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const style = TextStyle(color: AppTheme.textGrey, fontSize: 12);
                          String text;
                          switch (value.toInt()) {
                            case 0: text = 'Mar'; break;
                            case 1: text = 'Apr'; break;
                            case 2: text = 'May'; break;
                            case 3: text = 'Jun'; break;
                            case 4: text = 'Jul'; break;
                            case 5: text = 'Aug'; break;
                            case 6: text = 'Sep'; break;
                            default: return Container();
                          }
                          return Padding(padding: const EdgeInsets.only(top: 10), child: Text(text, style: style));
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: 6,
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 3),
                        FlSpot(1, 2),
                        FlSpot(2, 5),
                        FlSpot(3, 3.5),
                        FlSpot(4, 4),
                        FlSpot(5, 2.5),
                        FlSpot(6, 4),
                      ],
                      isCurved: true,
                      color: AppTheme.primary,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: true,
                        checkToShowDot: (spot, barData) => spot.x == 2,
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: AppTheme.primary.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Top Spending
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Top Spending",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                  ),
                  const Icon(Icons.swap_vert, color: AppTheme.textGrey),
                ],
              ),
            ),
            const SizedBox(height: 10),
            if (transactions.isEmpty)
              const Padding(
                padding: EdgeInsets.all(40.0),
                child: Text("No expenses yet.", style: TextStyle(color: AppTheme.textGrey)),
              )
            else
              ...transactions.take(5).map((tx) {
                final dateFormat = DateFormat('MMM dd, yyyy');
                return _buildSpendingItem(
                  context, 
                  tx.description.isNotEmpty ? tx.description : "Expense", 
                  dateFormat.format(tx.date), 
                  "-\$ ${tx.amount.toStringAsFixed(2)}"
                );
              }).toList(),
            const SizedBox(height: 80),
          ],
        ),
      );
      },
    ),
    );
  }

  Widget _buildTimeFilter(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppTheme.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : AppTheme.textGrey,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildSpendingItem(BuildContext context, String title, String subtitle, String amount) {
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
            child: const Icon(Icons.fastfood, color: AppTheme.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.expense,
            ),
          ),
        ],
      ),
    );
  }
}
