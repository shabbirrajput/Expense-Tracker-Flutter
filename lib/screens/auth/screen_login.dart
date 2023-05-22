import 'package:expense_tracker/core/app_color.dart';
import 'package:expense_tracker/core/app_dimens.dart';
import 'package:expense_tracker/core/app_string.dart';
import 'package:expense_tracker/screens/auth/screen_registeration.dart';
import 'package:expense_tracker/screens/dashboard/screen_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({Key? key}) : super(key: key);

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print('No user found for that email');
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.colorPrimary,
              size: Dimens.margin30,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.margin30),
          child: Column(
            children: [
              const SizedBox(
                height: Dimens.margin30,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  AppString.textWelcomeBack,
                  style: TextStyle(
                    color: AppColors.colorPrimary,
                    fontSize: Dimens.textSize20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(
                height: Dimens.margin12,
              ),
              const Text(
                AppString.textPleaseFillInYourEmailPasswordToLoginToYourAccount,
                style: TextStyle(
                    color: AppColors.colorGrey,
                    fontSize: Dimens.textSize15,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: Dimens.margin39,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  AppString.textEmail,
                  style: TextStyle(
                      color: AppColors.colorGrey,
                      fontSize: Dimens.textSize15,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(
                height: Dimens.margin7,
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.zero),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: AppString.textEnterEmail,
                  /*fillColor: Colors.white70*/
                ),
              ),
              const SizedBox(
                height: Dimens.margin19,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  AppString.textPassword,
                  style: TextStyle(
                      color: AppColors.colorGrey,
                      fontSize: Dimens.textSize15,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(
                height: Dimens.margin7,
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.zero),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: AppString.textEnterPassword,
                  /*fillColor: Colors.white70*/
                ),
              ),
              const SizedBox(
                height: Dimens.margin23,
              ),
              InkWell(
                onTap: () {},
                child: const Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    AppString.textForgotPassword,
                    style: TextStyle(
                        color: AppColors.colorGrey,
                        fontSize: Dimens.textSize12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(
                height: Dimens.margin105,
              ),
              SizedBox(
                height: Dimens.margin60,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    User? user = await loginUsingEmailPassword(
                        email: emailController.text,
                        password: passwordController.text,
                        context: context);
                    print(user);
                    if (user != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScreenDashboard()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.zero)),
                      backgroundColor: AppColors.colorPrimary),
                  child: const Text(
                    AppString.textLogin,
                    style: TextStyle(
                        color: AppColors.colorWhite,
                        fontSize: Dimens.textSize15,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(
                height: Dimens.margin17,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: AppString.textDontHaveAnAccount,
                      style: TextStyle(
                        fontSize: Dimens.textSize14,
                        decoration: TextDecoration.underline,
                        color: AppColors.colorGrey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ScreenRegisteration(),
                            ),
                          );
                        },
                      text: AppString.textSignUp,
                      style: const TextStyle(
                        color: AppColors.colorPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                style: const TextStyle(
                  color: AppColors.colorGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
