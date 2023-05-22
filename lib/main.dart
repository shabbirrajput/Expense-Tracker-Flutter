import 'package:expense_tracker/core/app_color.dart';
import 'package:expense_tracker/db/navigator_key.dart';
import 'package:expense_tracker/screens/auth/screen_login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

/*  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        MonthYearPickerLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.colorPrimary),
        useMaterial3: true,
      ),
      home: const ScreenLogin(),
      /*FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const ScreenLogin();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),*/
      navigatorKey: NavigatorKey.navigatorKey,
    );
  }
}
