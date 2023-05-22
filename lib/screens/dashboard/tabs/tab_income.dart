import 'package:flutter/material.dart';

class TabIncome extends StatefulWidget {
  const TabIncome({Key? key}) : super(key: key);

  @override
  State<TabIncome> createState() => _TabIncomeState();
}

class _TabIncomeState extends State<TabIncome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Text('dataINCOME')],
      ),
    );
  }
}
