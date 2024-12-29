import 'dart:io';

import 'package:simple_app/utils/global_var.dart';
import 'package:flutter/material.dart';

class ViewOrderScreen extends StatefulWidget {
  const ViewOrderScreen({super.key});

  @override
  State<ViewOrderScreen> createState() => _ViewOrderScreenState();
}

File? selectedImage;
DateTime selected = DateTime.now();
DateTime initial = DateTime(1900);
DateTime last = DateTime(2025);

final txtNamaPelanggan = TextEditingController();
final txtAlamat = TextEditingController();
final txtNoTelp = TextEditingController();
final txtKartuKeluarga = TextEditingController();
final txtTglOrder = TextEditingController();
final txtJumlahOrder = TextEditingController();
final txtTotalHarga = TextEditingController();

class _ViewOrderScreenState extends State<ViewOrderScreen> {
  @override
  void initState() {
    super.initState();
    bindData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton.extended(
      //     elevation: 1.0,
      //     foregroundColor: Colors.white,
      //     backgroundColor: Colors.green,
      //     icon: const Icon(Icons.save),
      //     label: const Text("Submit Data"),
      //     onPressed: () {
      //       showDialog(
      //           context: context,
      //           builder: (context) {
      //             return DialogOrderPayment();
      //           }).then((value) {
      //         if (GlobalVar.succesOrder) {
      //           Navigator.of(context).pop();
      //           ScaffoldMessenger.of(context).clearSnackBars();
      //           ScaffoldMessenger.of(context).showSnackBar(
      //             SnackBar(
      //               content: Text("Berhasil Order !"),
      //               backgroundColor: Colors.green,
      //             ),
      //           );

      //           GlobalVar.succesOrder = false;
      //         }
      //       });
      //     }),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      appBar: AppBar(
        elevation: 10,
        title: const Text('eCoupon - LPG'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Order ID",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            GlobalVar.currentOrder!.id_order,
                            style: TextStyle(fontSize: 20),
                          ),
                        ]),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Tanggal Order",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            GlobalVar.currentOrder!.tanggal_order
                                .substring(0, 10),
                            style: const TextStyle(fontSize: 20),
                          ),
                        ]),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Status",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            GlobalVar.currentOrder!.status_order,
                            style: TextStyle(fontSize: 20),
                          ),
                        ]),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Jumlah",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            GlobalVar.currentOrder!.jumlah_order,
                            style: TextStyle(fontSize: 20),
                          ),
                        ]),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Harga",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            GlobalVar.currentOrder!.harga_kupon,
                            style: TextStyle(fontSize: 20),
                          ),
                        ]),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            GlobalVar.currentOrder!.total_order,
                            style: TextStyle(fontSize: 20),
                          ),
                        ]),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "No KK",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            GlobalVar.currentOrder!.no_kk,
                            style: TextStyle(fontSize: 20),
                          ),
                        ]),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(children: [
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                      child: Image.network(GlobalVar.URL_Image +
                          GlobalVar.currentOrder!.path_gambar_kk)),
                ]),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white),
                  onPressed: () => {Navigator.of(context).pop()},
                  child: const Text("Kembali")),
              SizedBox(
                height: 15,
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> bindData() async {
    // final now = DateTime.now();
    // txtNamaPelanggan.text = GlobalVar.currentPelanggan!.nama_lengkap;
    // txtAlamat.text = GlobalVar.currentPelanggan!.alamat;
    // txtNoTelp.text = GlobalVar.currentPelanggan!.no_telp;
    // txtJumlahOrder.text = "1";
    // txtTglOrder.text = now.toLocal().toString().split(" ")[0];
    // calculateTotalOrder();
  }

  void calculateTotalOrder() {
    // int totalValue = int.parse(GlobalVar.selectedKupon!.harga_kupon) *
    //     int.parse(txtJumlahOrder.text);
    // txtTotalHarga.text = totalValue.toString();
    // GlobalVar.totalPayment = totalValue.toString();
    // GlobalVar.jumlahOrder = txtJumlahOrder.text;
    // GlobalVar.tanggalOrder = txtTglOrder.text;
  }
}
