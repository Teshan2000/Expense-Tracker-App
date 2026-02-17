import 'package:expense_tracker/components/button.dart';
import 'package:expense_tracker/screens/home.dart';
import 'package:expense_tracker/services/authService.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final authService = AuthService();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void login() async {
    final result = await authService.login(
      emailController.text,
      passController.text,
    );

    if (result.isNotEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login Successful")));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: "Your email",
              labelText: "Enter your email",
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.email),
              prefixIconColor: Colors.blue,
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Email field required";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: passController,
            decoration: InputDecoration(
              hintText: "Your password",
              labelText: "Enter your password",
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.email),
              prefixIconColor: Colors.blue,
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "password field required";
              }
              if (value.length <= 6) {
                return "password length should be at least 6 characters";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          Button(
            width: double.infinity,
            title: 'Login',
            disable: false,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                login();
              }
            },
          ),
        ],
      ),
    );
  }
}
