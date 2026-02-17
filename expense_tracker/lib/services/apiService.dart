import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const baseUrl = 'https://10.0.2.2:8080/api';

  Future<String> _getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('token') ?? '';
  }

  Future<int> _getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt('user_id') ?? 0;
  }

  Future<http.Response> fetchExpenses() async {
    final url = Uri.parse('$baseUrl/expense');
    final token = await _getToken();
    final userId = await _getUserId();
    return await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'User-Id': userId.toString(),
    });
  }

  Future<http.Response> createCategory(Map<String, String> data) async {
    final url = Uri.parse('$baseUrl/categories');
    final userId = await _getUserId();
    data['user_id'] = userId.toString();
    final token = await _getToken();
    return await http.post(
      url,
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  Future<http.Response> fetchCategories() async {
    final url = Uri.parse('$baseUrl/categories');
    final token = await _getToken();
    final userId = await _getUserId();
    return await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'User-Id': userId.toString(),
    });
  }

  Future<http.Response> createExpense(Map<String, String> data) async {
    final url = Uri.parse('$baseUrl/expense');
    final userId = await _getUserId();
    data['user_id'] = userId.toString();
    final token = await _getToken();
    return await http.post(
      url,
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  Future<http.Response> fetchExpensesByCategory(int categoryId) async {
    final url = '$baseUrl/expenses/category/$categoryId';
    final token = await _getToken();
    final userId = await _getUserId();
    final response = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'User-Id': userId.toString(),
    });

    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    return response;
  }

  Future<Map<String, dynamic>> getExpensesSummary() async {
    final url = Uri.parse('$baseUrl/expenses/summary');
    final token = await _getToken();
    final userId = await _getUserId();
    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'User-Id': userId.toString(),
    });

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load expenses summary');
    }
  }
}
