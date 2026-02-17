import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatefulWidget {
  final Function() onProfilepressed;
  final Function() onCategoriesPressed;
  final Function() onExpensesPressed;
  final Function() onAboutPressed;
  final Function() onLogoutPressed;

  const AppDrawer({
    super.key,
    required this.onProfilepressed,
    required this.onCategoriesPressed,
    required this.onExpensesPressed,
    required this.onAboutPressed,
    required this.onLogoutPressed, 
  });

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  SharedPreferences? preferences;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializePreferences();
  }

  void _initializePreferences() async {
    setState(() {
      isLoading = true;
    });
    preferences = await SharedPreferences.getInstance();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          preferences?.getString('name') ?? 'Peter',
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(
                          preferences?.getString('email') ?? 'peterparker@gmail.com',
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text(
                    'Profile',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: widget.onProfilepressed,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.category,
                    size: 25,
                  ),
                  title: const Text(
                    'Categories',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: widget.onCategoriesPressed,
                ),
                ListTile(
                  leading: const Icon(Icons.wallet),
                  title: const Text(
                    'Expenses',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: widget.onExpensesPressed,
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text(
                    'About',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: widget.onAboutPressed,
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text(
                    'Logout',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: widget.onLogoutPressed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
