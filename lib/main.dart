import 'package:expense_tracker/core/app_color.dart';
import 'package:expense_tracker/db/navigator_key.dart';
import 'package:expense_tracker/screens/dashboard/screen_dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.colorPrimary),
        useMaterial3: true,
      ),
      home: const ScreenDashboard(),
      navigatorKey: NavigatorKey.navigatorKey,
    );
  }
}
