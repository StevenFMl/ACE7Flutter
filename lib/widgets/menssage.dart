import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Messages {
  static void showToast(String msg, {Color backgroundColor = Colors.black, Color textColor = Colors.white}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0,
    );
  }

  static void showSnackBar(BuildContext context, String msg, {Color backgroundColor = Colors.redAccent}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}