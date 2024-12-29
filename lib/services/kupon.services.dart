import 'dart:convert';

import 'package:simple_app/model/kupon.model.dart';
import 'package:simple_app/utils/global_var.dart';
import 'package:http/http.dart' as http;

class KuponService {
  // final Uri url;
  const KuponService();

  static Future<List<KuponData>> getListKupon() async {
    List<KuponData> listData = List.empty();
    Uri url = Uri.parse(GlobalVar.URL_API +
        "kupon/list_by_desa.php?desa=" +
        GlobalVar.currentPelanggan!.asal_desa);
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      listData = body.map<KuponData>(KuponData.fromJson).toList();
    }
    return listData;
  }

  static Future<List<KuponData>> getListDesa() async {
    List<KuponData> listData = List.empty();
    Uri url = Uri.parse(GlobalVar.URL_API + "kupon/list.php");
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      listData = body.map<KuponData>(KuponData.fromJson).toList();
    }
    return listData;
  }
}
