import 'package:flutter/material.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
                                elevation: 5,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Row(children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 15),
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(width: 20),
                                          Text(
                                            '🍎',
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.black),
                                          ),
                                          SizedBox(width: 20),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'name',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  'date',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black),
                                                )
                                              ]),
                                          SizedBox(width: 40),
                                          Row(children: <Widget>[
                                            Text(
                                              'Rs.price',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black),
                                            ),
                                          ])
                                        ]),
                                  ),
                                ]),
                              );
  }
}