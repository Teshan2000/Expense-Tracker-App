import 'dart:convert';
import 'package:expense_tracker/components/button.dart';
import 'package:expense_tracker/screens/layout.dart';
import 'package:expense_tracker/services/apiService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ExpenseForm extends StatefulWidget {
  final String categoryIcon;

  const ExpenseForm({super.key, required this.categoryIcon});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  DateTime? selectedDate;
  List categories = [];
  int? selectedCategoryId;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  void _fetchCategories() async {
    try {
      final response = await ApiService().fetchCategories();
      if (response.statusCode == 200) {
        setState(() {
          categories = jsonDecode(response.body)['data'];
        });
      } else {
        print('Failed to load categories');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate() && selectedCategoryId != null) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      int userId = preferences.getInt('user_id') ?? 0;
      final apiService = ApiService();
      final response = await apiService.createExpense({
        'name': _nameController.text,
        'amount': double.parse(_amountController.text).toStringAsFixed(2),
        'date': _dateController.text,
        'category_id': selectedCategoryId.toString(),
        'user_id': userId.toString(), 
      });

      if (response.statusCode == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Layout()
          ),
        );
      } else {
        final errorData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorData['message'])),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _nameController,
            keyboardType: TextInputType.text,
            cursorColor: Colors.blue,
            decoration: InputDecoration(
              hintText: 'Expense Name',
              labelText: 'Expense Name',
              alignLabelWithHint: true,
              prefixIcon: const Icon(Icons.wallet),
              prefixIconColor: Colors.blue,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.blue,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the expense name';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            cursorColor: Colors.blue,
            decoration: InputDecoration(
              hintText: 'Expense Amount',
              labelText: 'Expense Amount',
              alignLabelWithHint: true,
              prefixIcon: const Icon(Icons.money),
              prefixIconColor: Colors.blue,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.blue,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the amount';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _dateController,
            keyboardType: TextInputType.datetime,
            cursorColor: Colors.blue,
            readOnly: true,
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: selectedDate ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (picked != null && picked != selectedDate) {
                setState(() {
                  selectedDate = picked;
                  _dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate!);
                });
              }
            },
            decoration: InputDecoration(
              hintText: 'Expense Date',
              labelText: 'Expense Date',
              alignLabelWithHint: true,
              prefixIcon: const Icon(Icons.calendar_month),
              prefixIconColor: Colors.blue,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.blue,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the expense date';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField<int>(
            value: selectedCategoryId,
            hint: const Text('Select Category'),
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black,),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.category),
              prefixIconColor: Colors.blue,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.blue,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            items: categories.map<DropdownMenuItem<int>>((category) {
              return DropdownMenuItem<int>(
                value: category['id'],
                child: Row(
                  children: [
                    Text(category['icon']),
                    const SizedBox(width: 20),
                    Text(category['name']),
                  ],
                ),
              );
            }).toList(),
            onChanged: (int? newValue) {
              setState(() {
                selectedCategoryId = newValue;
              });
            },
            validator: (value) {
              if (value == null) {
                return 'Please select a category';
              }
              return null;
            },
          ),
          const SizedBox(height: 40),
          Button(
            width: double.infinity,
            title: 'Add',
            disable: false,
            onPressed: _submitForm,
          ),
        ],
      ),
    );
  }
}
