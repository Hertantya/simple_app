import 'package:simple_app/model/transaction_order.model.dart';
import 'package:simple_app/services/transaction_order.services.dart';
import 'package:simple_app/utils/global_var.dart';
import 'package:simple_app/views/page/view_order.dart';
import 'package:flutter/material.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: FutureBuilder<List<TransactionOrderData>>(
        future: TransactionOrderService.getListTransactionOrder(
            GlobalVar.currentPelanggan!.id_pelanggan),
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

  Widget buildOrderList(List<TransactionOrderData> lists) => ListView.builder(
      itemCount: lists.length,
      shrinkWrap: true,
      // scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        final data = lists[index];
        return showOrderData(data);
      });

  Card showOrderData(TransactionOrderData orderData) {
    String valueDetail = "Tanggal: " +
        orderData.tanggal_order +
        " | " +
        "Jumlah: " +
        orderData.jumlah_order +
        " | " +
        "Total: " +
        orderData.total_order +
        "\n"
            "Status: " +
        orderData.status_order;
    return Card(
      elevation: 2,
      child: ListTile(
        title: Column(
          children: <Widget>[
            Text(orderData.jenis_kupon),
          ],
        ),
        subtitle: Column(
          children: <Widget>[
            Text("Jumlah Order : " + orderData.jumlah_order),
            Text("Status : " + orderData.status_order),
            Text("Tanggal : " + orderData.tanggal_order),
            ElevatedButton(
              child: Text(
                "Lihat Order",
                style: TextStyle(fontSize: 10),
              ),
              onPressed: () {
                setState(() {
                  TransactionOrderData data = orderData!;
                  GlobalVar.currentOrder = data;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewOrderScreen(),
                      ));
                });
              },
            ),
          ],
        ),
        subtitleTextStyle: TextStyle(color: Colors.black, fontSize: 10),
        leading: Container(
          height: 46,
          width: 46,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: orderData.status_order == "Confirm"
                ? Colors.green
                : Colors.blue,
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
