import 'dart:convert';
import 'package:expense_tracker/components/appDrawer.dart';
import 'package:expense_tracker/components/button.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/screens/login.dart';
import 'package:expense_tracker/services/apiService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final apiService = ApiService();
  bool isLoading = false;
  bool _isDisposed = false;
  late Future<List<Expense>> _futureExpenses;
  List<Expense> _filteredExpenses = [];
  double totalCost = 0.0;


   @override
  void initState() {
    super.initState();
    // _futureExpenses = fetchExpenses();
  }

  Future<List<Expense>> fetchExpenses() async {
    final response = await apiService.fetchExpenses();

    // if (response.statusCode == 200) {
    //   List jsonResponse = json.decode(response.body)['data'];
    //   if (!_isDisposed) {
    //     List<Expense> expenses = jsonResponse
    //         .map((expense) => Expense.fromJson(expense))
    //         .toList();
    //     _filterExpenses(expenses);
    //     return expenses;
    //   }
    // } else if (response.statusCode == 404) {
    //   return [];
    // } else {
    //   throw Exception('Failed to load expenses');
    // }
    return [];
  }

  void _calculateTotalCost(List<Expense> expenses) {
    double total = 0.0;
    for (var expense in expenses) {
      total += double.parse(expense.amount);
    }
    if (!_isDisposed) {
      setState(() {
        totalCost = total;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 65, top: 10),
          child: Center(child: Text('Welcome User')),
        ),
        actions: const [EndDrawerButton()],
      ),
      endDrawer: AppDrawer(
        onProfilepressed: () {}, 
        onCategoriesPressed: () {}, 
        onExpensesPressed: () {}, 
        onAboutPressed: () {}, 
        onLogoutPressed: () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.clear();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }),
      body: SingleChildScrollView(
        child: SafeArea(
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            'Welcome to the Expense Tracker App. Track Your Expenses.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Button(
                            width: double.infinity,
                            title: "Add New Expense",
                            disable: false,
                            onPressed: () {},
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.filter_list),
                            onPressed: () {},
                          ),
                          const Text(
                            "Recent Expenses",
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(width: 60),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "View All",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      // FutureBuilder<List<Expense>>(
                      //   future: _futureExpenses,
                      //   builder: (context, snapshot) {
                      //     if (snapshot.connectionState ==
                      //         ConnectionState.waiting) {
                      //       return const Center(
                      //           child: CircularProgressIndicator());
                      //     } else if (snapshot.hasError) {
                      //       return Center(child: Text("${snapshot.error}"));
                      //     } else if (!snapshot.hasData ||
                      //         snapshot.data!.isEmpty) {
                      //       return const Center(
                      //           child: Text("No expenses found."));
                      //     } else {
                      //       return Container(
                      //         padding: EdgeInsets.zero,
                      //         child: DataTable(
                      //           dataTextStyle: const TextStyle(
                      //               fontSize: 16, color: Colors.black),
                      //           headingTextStyle: const TextStyle(
                      //               fontSize: 16,
                      //               fontWeight: FontWeight.bold,
                      //               color: Colors.black),
                      //           columnSpacing: 25,
                      //           showBottomBorder: true,
                      //           columns: const [
                      //             DataColumn(label: Text('')),
                      //             DataColumn(label: Text('Name  ')),
                      //             DataColumn(label: Text('Amount  ')),
                      //             DataColumn(label: Text('Date')),
                      //           ],
                      //           rows: _filteredExpenses.map((expense) {
                      //             return DataRow(cells: [
                      //               DataCell(Text(expense.category,
                      //                 style: const TextStyle(fontSize: 20))),
                      //               DataCell(Text(expense.title)),
                      //               DataCell(Text("Rs.${expense.amount}")),
                      //               DataCell(Text(expense.date)),
                      //             ]);
                      //           }).toList(),
                      //         ),
                      //       );
                      //     }
                      //   },
                      // ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
