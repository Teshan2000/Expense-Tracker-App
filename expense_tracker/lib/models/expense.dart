class Expense {
  final int id;
  final String userId;
  final String title;
  final String category;
  final String amount;
  final String date;
  final String createdAt;

  Expense({
    required this.id,
    required this.userId,
    required this.title,
    required this.category,
    required this.amount,
    required this.date,
    required this.createdAt,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      category: json['category'],
      amount: json['amount'],
      date: json['date'],
      createdAt: json['createdAt'],
    );
  }
}