import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalFunc {
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static Color hexToColor(String code) {
    return new Color(int.parse(code, radix: 16) + 0xFF000000);
  }

  static Future setUserLogined(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userLogin', email);
  }

  static Future<bool> checkLoginUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userExist = prefs.getString('userLogin');

    return (userExist != null && userExist != "");
  }

  static void showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7),
              child: Text("Sedang memproses data...")),
        ],
      ),
    );
  }

  static void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  static void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
