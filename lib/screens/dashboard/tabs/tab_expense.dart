import 'package:flutter/material.dart';

class TabExpense extends StatefulWidget {
  const TabExpense({Key? key}) : super(key: key);

  @override
  State<TabExpense> createState() => _TabExpenseState();
}

class _TabExpenseState extends State<TabExpense> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Text('dataEXPENSE')],
      ),
    );
  }
}
