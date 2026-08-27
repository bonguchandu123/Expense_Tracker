class Transaction {
  final int? id;
  final double amount;
  final DateTime date;
  final String type;
  final String description;
  final int? userId;
  final int? categoryId;

  Transaction({
    this.id,
    required this.amount,
    required this.date,
    required this.type,
    required this.description,
    this.userId,
    this.categoryId,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date']),
      type: json['type'],
      description: json['description'] ?? '',
      userId: json['user_id'],
      categoryId: json['category_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'date': "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      'type': type,
      'description': description,
      'user_id': userId,
      'category_id': categoryId,
    };
  }
}
