import 'dart:convert';
import 'dart:io';

import 'package:simple_app/model/pelanggan.model.dart';
import 'package:simple_app/utils/global_func.dart';
import 'package:simple_app/utils/global_var.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PelangganService {
  // final Uri url;
  const PelangganService();

  static Future<PelangganData> getDetailPelanggan(String id_pelanggan) async {
    PelangganData? data = null;
    Uri url = Uri.parse(
        GlobalVar.URL_API + "pelanggan/detail.php?id=" + id_pelanggan);
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      data = body.map<PelangganData>(PelangganData.fromJson);
    }
    return data!;
  }

  static Future<PelangganData> checkLoginPelanggan(
      BuildContext context, String email, String password) async {
    var data;
    Uri url = Uri.parse(GlobalVar.URL_API + "login.php");
    // http.Response response = await http.post(url);
    Map mapValue = {'email': email, 'password': password};
    String bodyValue = json.encode(mapValue);

    http.Response response = await http.post(url, body: bodyValue);

    if (response.statusCode == 200) {
      // final body = jsonDecode(response.body);
      data = PelangganData.fromJson(jsonDecode(response.body));
    } else {
      GlobalFunc.showError(context, "Username atau passworda anda salah!");
    }
    return data;
  }

  static Future<String> createPelanggan(
      BuildContext context, PelangganData objData, File imageFile) async {
    String data = "";
    Uri url = Uri.parse(GlobalVar.URL_API + "pelanggan/create.php");
    // http.Response response = await http.post(url);
    var mapValue = objData.toJson();
    String bodyValue = json.encode(mapValue);

    http.Response response = await http.post(url, body: bodyValue);

    if (response.statusCode == 200) {
      data = response.body;
    } else {
      GlobalFunc.showError(context, "Terjadi kesalahan harap cek lagi!");
    }

    final body = jsonDecode(data);
    var request = http.MultipartRequest(
        "POST", Uri.parse(GlobalVar.URL_API + "pelanggan/upload_kk.php"));
    request.fields["id_pelanggan"] = body["data"]["id_pelanggan"];
    var pic =
        await http.MultipartFile.fromPath("file_gambar_kk", imageFile.path);
    request.files.add(pic);
    var responseImage = await request.send();

    //Get the response from the server
    var responseData = await responseImage.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);

    data = responseString;
    return data;
  }

  static Future<String> updatePelanggan(
      BuildContext context, PelangganData objData) async {
    String data = "";
    Uri url = Uri.parse(GlobalVar.URL_API +
        "pelanggan/update.php?id_pelanggan=" +
        objData.id_pelanggan);
    // http.Response response = await http.post(url);
    var mapValue = objData.toJson();
    String bodyValue = json.encode(mapValue);

    http.Response response = await http.post(url, body: bodyValue);

    if (response.statusCode == 200) {
      data = response.body;
    } else {
      GlobalFunc.showError(context, "Terjadi kesalahan harap cek lagi!");
    }
    return data;
  }
}
