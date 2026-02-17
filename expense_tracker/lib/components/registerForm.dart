import 'package:expense_tracker/components/button.dart';
import 'package:expense_tracker/screens/home.dart';
import 'package:expense_tracker/screens/login.dart';
import 'package:expense_tracker/services/authService.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  final authService = AuthService();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void register() async{
    final result = await authService.register(
      nameController.text, emailController.text, passController.text);

    if (result.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration Successful"))
      );
      Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: "Your name",
              labelText: "Enter your name",
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.person),
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
                return "Name field required";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
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
              prefixIcon: Icon(Icons.password),
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
            title: 'Register',
            disable: false,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                register();
              }
            },
          )
        ],
      ),
    );
  }
}