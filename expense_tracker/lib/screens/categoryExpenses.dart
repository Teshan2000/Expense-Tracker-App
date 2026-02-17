import 'dart:convert';
import 'package:expense_tracker/services/apiService.dart';
import 'package:flutter/material.dart';

class CategoryExpenses extends StatefulWidget {
  final int categoryId;
  final String categoryName;
  final String categoryIcon;

  const CategoryExpenses({
    Key? key,
    required this.categoryId,
    required this.categoryName,
    required this.categoryIcon,
  }) : super(key: key);

  @override
  State<CategoryExpenses> createState() => _CategoryExpensesState();
}

class _CategoryExpensesState extends State<CategoryExpenses> {
  late Future<List<ExpenseItem>> _futureExpenses;
  double totalCost = 0.0;

  @override
  void initState() {
    super.initState();
    _futureExpenses = fetchExpensesByCategory();
  }

  Future<List<ExpenseItem>> fetchExpensesByCategory() async {
    final apiService = ApiService();
    final response = await apiService.fetchExpensesByCategory(widget.categoryId);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      List<ExpenseItem> expenses =
          jsonResponse.map((expense) => ExpenseItem.fromJson(expense)).toList();
      _calculateTotalCost(expenses);
      return expenses;
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception('Failed to load expenses');
    }
  }

  void _calculateTotalCost(List<ExpenseItem> expenses) {
    double total = 0.0;
    for (var expense in expenses) {
      total += double.parse(expense.amount);
    }
    setState(() {
      totalCost = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.categoryName)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<ExpenseItem>>(
                future: _futureExpenses,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No expenses found."));
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 15),
                          DataTable(
                            dataTextStyle:
                                const TextStyle(fontSize: 16, color: Colors.black),
                            headingTextStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            columnSpacing: 25,
                            showBottomBorder: true,
                            columns: const [
                              DataColumn(label: Text('')),
                              DataColumn(label: Text('Name')),
                              DataColumn(label: Text('Amount')),
                              DataColumn(label: Text('Date')),
                            ],
                            rows: snapshot.data!.map((expense) {
                              return DataRow(cells: [                                
                                DataCell(Text(widget.categoryIcon, style: const TextStyle(fontSize: 20))),
                                DataCell(Text(expense.name)),
                                DataCell(Text("Rs.${expense.amount}")),
                                DataCell(Text(expense.date)),
                              ]);
                            }).toList(),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Total Expense: Rs.${totalCost.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpenseItem {
  final int id;
  final String name;
  final String amount;
  final String date;

  ExpenseItem({required this.id, required this.name, required this.amount, required this.date});

  factory ExpenseItem.fromJson(Map<String, dynamic> json) {
    return ExpenseItem(
      id: json['id'],
      name: json['name'],
      amount: json['amount'],
      date: json['date'],
    );
  }
}