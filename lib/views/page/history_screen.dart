//import 'package:simple_app/services/pelanggan.services.dart';
//import 'package:simple_app/utils/global_var.dart';
import 'package:flutter/material.dart';
import 'package:simple_app/model/history.model.dart';
import 'package:simple_app/services/history.services.dart';

class history_screen extends StatefulWidget {
  const history_screen({super.key});

  @override
  State<history_screen> createState() => _HistoryScreenState();
}

final txtAds = TextEditingController();

class _HistoryScreenState extends State<history_screen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: FutureBuilder<List<HistoryData>>(
        future: HistoryService.getListHistoryData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            final list = snapshot.data!;
            return buildOrderList(list);
          } else {
            return const Text("No data!");
          }
        },
      ),
    );
  }

  Widget buildOrderList(List<HistoryData> lists) => ListView.builder(
      itemCount: lists.length,
      shrinkWrap: true,
      // scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        final data = lists[index];
        return showOrderData(data);
      });

  Card showOrderData(HistoryData hisData) {
    String valueDetail = "Tanggal: " +
        hisData.bulan +
        " | " +
        "Jumlah: " +
        hisData.total_pemasukan +
        " | " +
        "Total: " +
        hisData.total_pemasukan;
    return Card(
      elevation: 2,
      child: ListTile(
        title: Column(
          children: <Widget>[
            Text(hisData.total_pemasukan.toString()),
          ],
        ),
        subtitle: Column(
          children: <Widget>[
            Text("Jumlah Order : " + hisData.total_pemasukan),
            Text("Tanggal : " + hisData.created_at),
          ],
        ),
        subtitleTextStyle: TextStyle(color: Colors.black, fontSize: 10),
        leading: Container(
          height: 46,
          width: 46,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.backpack_rounded,
            color: Colors.white,
          ),
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
