import 'dart:convert';
import 'package:expense_tracker/components/button.dart';
import 'package:expense_tracker/screens/categories.dart';
import 'package:expense_tracker/services/apiService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryForm extends StatefulWidget {
  const CategoryForm({super.key});

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _iconController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      int userId = preferences.getInt('user_id') ?? 0;
      final data = {
        'name': _nameController.text,
        'icon': _iconController.text,
        'user_id': userId.toString(), // Add user ID to the request
      };

      try {
        final response = await ApiService().createCategory(data);
        if (response.statusCode == 201) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Categories()),
          );
        } else {
          final errorData = jsonDecode(response.body);
          print(errorData['message']);
        }
      } catch (e) {
        print('An error occurred: $e');
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
              hintText: 'Category Name',
              labelText: 'Category Name',
              alignLabelWithHint: true,
              prefixIcon: const Icon(Icons.folder),
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
                return 'Please enter a category name';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _iconController,
            keyboardType: TextInputType.text,
            cursorColor: Colors.blue,
            decoration: InputDecoration(
              hintText: 'Category Icon',
              labelText: 'Category Icon',
              alignLabelWithHint: true,
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a category icon';
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
