import 'category.dart';

class BudgetStatusDTO {
  final Category? category;
  final double limitAmount;
  final double spentAmount;
  final String status;

  BudgetStatusDTO({
    this.category,
    required this.limitAmount,
    required this.spentAmount,
    required this.status,
  });

  factory BudgetStatusDTO.fromJson(Map<String, dynamic> json) {
    return BudgetStatusDTO(
      category: json['category'] != null ? Category.fromJson(json['category']) : null,
      limitAmount: (json['limitAmount'] as num).toDouble(),
      spentAmount: (json['spentAmount'] as num).toDouble(),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category?.toJson(),
      'limitAmount': limitAmount,
      'spentAmount': spentAmount,
      'status': status,
    };
  }
}
