// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:simple_app/model/karyawan.model.dart';
import 'package:simple_app/utils/global_func.dart';
import 'package:simple_app/utils/global_var.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class KaryawanService {
  // final Uri url;
  const KaryawanService();

  static Future<KaryawanData> checkLoginPelanggan(
      BuildContext context, String email, String password) async {
    var data;
    Uri url = Uri.parse("${GlobalVar.URL_API}karyawan/login");
    // http.Response response = await http.post(url);
    Map mapValue = {'email': email, 'password': password};
    String bodyValue = json.encode(mapValue);

    http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json', // Set Content-Type to JSON
      },
      body: bodyValue,
    );

    if (response.statusCode == 200) {
      // final body = jsonDecode(response.body);
      data = KaryawanData.fromJson(jsonDecode(response.body));
    } else {
      // ignore: use_build_context_synchronously
      GlobalFunc.showError(context, "Username atau passworda anda salah!");
    }
    return data;
  }
}
