import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Messages {
  static void showToast(String msg, {Color backgroundColor = const Color.fromARGB(255, 0, 0, 0), Color textColor = const Color.fromARGB(255, 255, 255, 255)}) {
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

  // Método para mostrar un toast de éxito
  static void showSuccessToast(String msg) {
    showToast(
      msg,
      backgroundColor: Colors.green, // Color verde para éxito
      textColor: Colors.white,
    );
  }

  // Método para mostrar un toast de error
  static void showErrorToast(String msg) {
    showToast(
      msg,
      backgroundColor: Colors.red, // Color rojo para error
      textColor: Colors.white,
    );
  }

  // Método para mostrar un snackbar de éxito
  static void showSuccessSnackBar(BuildContext context, String msg) {
    showSnackBar(
      context,
      msg,
      backgroundColor: Colors.green, // Color verde para éxito
    );
  }

  // Método para mostrar un snackbar de error
  static void showErrorSnackBar(BuildContext context, String msg) {
    showSnackBar(
      context,
      msg,
      backgroundColor: Colors.red, // Color rojo para error
    );
  }
  
}