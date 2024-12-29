import 'dart:convert';

import 'package:simple_app/model/history.model.dart';
import 'package:simple_app/utils/global_var.dart';
import 'package:http/http.dart' as http;

class HistoryService {
  // final Uri url;
  const HistoryService();

  static Future<List<HistoryData>> getListHistoryData() async {
    List<HistoryData> listData = List.empty();
    Uri url = Uri.parse("${GlobalVar.URL_API}laporan-bulanan");
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      listData = body.map<HistoryData>(HistoryData.fromJson).toList();
    }
    return listData;
  }
}
