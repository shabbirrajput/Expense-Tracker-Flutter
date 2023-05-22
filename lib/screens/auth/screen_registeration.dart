import 'package:expense_tracker/core/app_color.dart';
import 'package:expense_tracker/core/app_dimens.dart';
import 'package:expense_tracker/core/app_string.dart';
import 'package:expense_tracker/core/utils/utils.dart';
import 'package:expense_tracker/screens/auth/screen_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ScreenRegisteration extends StatefulWidget {
  const ScreenRegisteration({Key? key}) : super(key: key);

  @override
  State<ScreenRegisteration> createState() => _ScreenRegisterationState();
}

class _ScreenRegisterationState extends State<ScreenRegisteration> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void signUp() {
    setState(() {
      loading = true;
    });
    _auth
        .createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: Dimens.margin30,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    AppString.textCreateYourAccount,
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
                  AppString
                      .textPleaseFillInYourEmailPasswordToCreateYourAccount,
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
                    AppString.textName,
                    style: TextStyle(
                        color: AppColors.colorGrey,
                        fontSize: Dimens.textSize15,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(
                  height: Dimens.margin7,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.zero),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: AppString.textEnterName,
                    /*fillColor: Colors.white70*/
                  ),
                ),
                const SizedBox(
                  height: Dimens.margin17,
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
                TextFormField(
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
                  height: Dimens.margin17,
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
                TextFormField(
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
                  height: Dimens.margin17,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    AppString.textConfirmPassword,
                    style: TextStyle(
                        color: AppColors.colorGrey,
                        fontSize: Dimens.textSize15,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(
                  height: Dimens.margin7,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.zero),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: AppString.textEnterPassword,
                    /*fillColor: Colors.white70*/
                  ),
                  /* validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter password';
                    }
                    return null;
                  },*/
                ),
                const SizedBox(
                  height: Dimens.margin67,
                ),
                SizedBox(
                  height: Dimens.margin60,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        signUp();
                      }
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScreenLogin()),
                      );*/
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.zero)),
                        backgroundColor: AppColors.colorPrimary),
                    child: loading
                        ? const CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Colors.white,
                          )
                        : const Text(
                            AppString.textCreateAnAccount,
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
                        text: AppString.textAlreadyHaveAnAccount,
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
                                builder: (context) => const ScreenLogin(),
                              ),
                            );
                          },
                        text: AppString.textSignIn,
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
                const SizedBox(
                  height: Dimens.margin60,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}