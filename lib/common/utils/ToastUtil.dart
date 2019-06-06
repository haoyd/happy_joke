import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  static void show(String msg) {
    if (msg == null) {
      return;
    }

    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 2,
        backgroundColor: Color.fromARGB(120, 0, 0, 0),
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}