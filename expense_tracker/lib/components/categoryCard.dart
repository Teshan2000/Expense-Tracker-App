import 'package:expense_tracker/components/categoryForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoryCard extends StatefulWidget {
  const CategoryCard({super.key});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 85),
            child: Card(
              elevation: 5,
              color: Colors.blue,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Container(
                      width: 50,
                      height: 60,
                      decoration: ShapeDecoration(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          '+',
                          style: TextStyle(fontSize: 35, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    'Add New Category',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(height: 10, width: 25),
                ],
              ),
            ),
          ),
        ]),
        onTap: () {
          showDialog(
              context: context,
              builder: (_) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: AlertDialog(
                      title: const Center(child: Text('Add New Category')),
                      content: const SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 10),
                            CategoryForm()
                          ],
                        ),
                      ),
                      actions: [
                        TextButton.icon(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.close),
                            label: const Text('Close'))
                      ],
                    ),
                  ));
        });
  }
}
