import 'package:expense_tracker/core/app_color.dart';
import 'package:expense_tracker/core/app_string.dart';
import 'package:expense_tracker/screens/dashboard/tabs/tab_expense.dart';
import 'package:expense_tracker/screens/dashboard/tabs/tab_income.dart';
import 'package:flutter/material.dart';

class ScreenDashboard extends StatelessWidget {
  const ScreenDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                AppString.textDashboard,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              backgroundColor: AppColors.colorPrimary,
              automaticallyImplyLeading: false,
              bottom: const TabBar(
                tabs: [
                  Tab(text: AppString.textIncome),
                  Tab(text: AppString.textExpense)
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                TabIncome(),
                TabExpense(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Scaffold(
//           appBar: AppBar(
//             title: const Text(
//               AppString.textDashboard,
//               style: TextStyle(fontWeight: FontWeight.w500),
//             ),
//             backgroundColor: AppColors.colorPrimary,
//             automaticallyImplyLeading: false,
//           ),
//           body: SingleChildScrollView(
//             child: Column(
//               children: [Text('data')],
//             ),
//           )),
