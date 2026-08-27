import 'budget_status_dto.dart';
import 'insight_dto.dart';

class DashboardDTO {
  final double totalIncome;
  final double totalExpenses;
  final double balance;
  final List<BudgetStatusDTO> budgetStatuses;
  final List<InsightDTO> personalizedInsights;

  DashboardDTO({
    required this.totalIncome,
    required this.totalExpenses,
    required this.balance,
    required this.budgetStatuses,
    required this.personalizedInsights,
  });

  factory DashboardDTO.fromJson(Map<String, dynamic> json) {
    return DashboardDTO(
      totalIncome: (json['totalIncome'] as num).toDouble(),
      totalExpenses: (json['totalExpenses'] as num).toDouble(),
      balance: (json['balance'] as num).toDouble(),
      budgetStatuses: (json['budgetStatuses'] as List<dynamic>?)
              ?.map((e) => BudgetStatusDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      personalizedInsights: (json['personalizedInsights'] as List<dynamic>?)
              ?.map((e) => InsightDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalIncome': totalIncome,
      'totalExpenses': totalExpenses,
      'balance': balance,
      'budgetStatuses': budgetStatuses.map((e) => e.toJson()).toList(),
      'personalizedInsights': personalizedInsights.map((e) => e.toJson()).toList(),
    };
  }
}
