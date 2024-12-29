import 'package:simple_app/model/kupon.model.dart';
import 'package:simple_app/services/kupon.services.dart';
import 'package:simple_app/utils/global_func.dart';
import 'package:simple_app/utils/global_var.dart';
import 'package:simple_app/views/page/trx_order_screen.dart';
import 'package:flutter/material.dart';

class CouponOrderScreen extends StatefulWidget {
  const CouponOrderScreen({super.key});

  @override
  State<CouponOrderScreen> createState() => _CouponOrderScreenState();
}

class _CouponOrderScreenState extends State<CouponOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Kupon",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        Center(
          child: FutureBuilder<List<KuponData>>(
            future: KuponService.getListKupon(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData) {
                final list = snapshot.data!;
                return buildCoupon(list);
              } else {
                return const Text("No data!");
              }
            },
          ),
        ),
        // orderCoupon(Colors.red, "Red", "1000"),
        // orderCoupon(Colors.blue, "Blue", "2000"),
      ]),
    );
  }

  Widget buildCoupon(List<KuponData> lists) => ListView.builder(
      itemCount: lists.length,
      shrinkWrap: true,
      // scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        final data = lists[index];
        return orderCoupon(data);
      });

  Card orderCoupon(KuponData kupon) {
    return Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 55,
                      height: 55,
                      child: CircleAvatar(
                          backgroundColor:
                              GlobalFunc.hexToColor(kupon.kode_warna),
                          foregroundColor:
                              GlobalFunc.hexToColor(kupon.kode_warna))),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        kupon.jenis_kupon,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        kupon.harga_kupon,
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 80,
                  ),
                  Container(
                      alignment: Alignment.bottomRight,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {
                          GlobalVar.selectedKupon = kupon;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TrxOrderScreen(),
                              ));
                        },
                        child: Text(
                          "Order",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ],
        ));
  }
}
