import 'dart:convert';
import 'dart:io';

import 'package:simple_app/model/transaction_order.model.dart';
import 'package:simple_app/utils/global_var.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TransactionOrderService {
  // final Uri url;
  const TransactionOrderService();

  static Future<List<TransactionOrderData>> getListTransactionOrder(
      String id_pelanggan) async {
    List<TransactionOrderData> listData = List.empty();
    Uri url = Uri.parse(
        GlobalVar.URL_API + "order/list.php?id_pelanggan=" + id_pelanggan);
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      listData = body
          .map<TransactionOrderData>(TransactionOrderData.fromJson)
          .toList();
    }
    return listData;
  }

  static Future<String> createTransactionOrder(
      BuildContext context, TransactionOrderData objData) async {
    String data = "";
    Uri url = Uri.parse(GlobalVar.URL_API + "order/create.php");
    // http.Response response = await http.post(url);
    var mapValue = objData.toJson();
    String bodyValue = json.encode(mapValue);

    http.Response response = await http.post(url, body: bodyValue);

    if (response.statusCode == 200) {
      data = response.body;
    }
    // else if (response.statusCode == 300) {
    //   GlobalVar.orderMessage = "No KK ini sudah pernah melakukan pengajuan!";
    //   return data;  }
    else {
      GlobalVar.orderMessage = "Terjadi kesalahan harap cek lagi!";
    }
    // final body = jsonDecode(data);
    // var request = http.MultipartRequest(
    //     "POST", Uri.parse(GlobalVar.URL_API + "order/upload_kk.php"));
    // request.fields["id_order"] = body["data"]["id_order"];
    // var pic =
    //     await http.MultipartFile.fromPath("file_gambar_kk", imageFile.path);
    // request.files.add(pic);
    // var responseImage = await request.send();

    // //Get the response from the server
    // var responseData = await responseImage.stream.toBytes();
    // var responseString = String.fromCharCodes(responseData);

    // data = responseString;
    return data;
  }

  // static Future<String> createUpload_KK(File imageFile, BuildContext context,
  //     TransactionOrderData objData) async {
  //   return "";
  // }
}
