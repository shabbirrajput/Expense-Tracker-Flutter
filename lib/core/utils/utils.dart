import 'package:expense_tracker/core/app_color.dart';
import 'package:expense_tracker/core/app_dimens.dart';
import 'package:expense_tracker/db/navigator_key.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  void toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.colorRed,
        textColor: AppColors.colorWhite,
        fontSize: Dimens.margin16);
  }

  alertDialog(String msg) {
    //Toast.show(msg, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    //Toast.show(msg, duration: Toast.lengthShort, gravity: Toast.bottom);
    showAlertDialog(NavigatorKey.navigatorKey.currentContext!, msg);
  }

  showAlertDialog(BuildContext context, String msg) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("ALERT!"),
      content: Text(msg),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
