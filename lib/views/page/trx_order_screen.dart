import 'package:simple_app/utils/global_func.dart';
import 'package:simple_app/utils/global_var.dart';
import 'package:simple_app/views/widget/dialog_order_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class TrxOrderScreen extends StatefulWidget {
  const TrxOrderScreen({super.key});

  @override
  State<TrxOrderScreen> createState() => _TrxOrderScreenState();
}

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

class _TrxOrderScreenState extends State<TrxOrderScreen> {
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
        elevation: 20,
        title: const Text('eCoupon - LPG'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Order Kupon",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(children: [
                  TextFormField(
                    controller: txtNamaPelanggan,
                    decoration: InputDecoration(
                      labelText: "Nama",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    enabled: false,
                  ),
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(children: [
                  TextFormField(
                    controller: txtAlamat,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: "Alamat",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_pin),
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(children: [
                  TextFormField(
                    controller: TextEditingController(
                      text: GlobalVar.selectedKupon!.jenis_kupon,
                    ),
                    decoration: InputDecoration(
                      labelText: "Kupon ",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.book_sharp),
                    ),
                    enabled: false,
                  ),
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(children: [
                  TextFormField(
                    controller: TextEditingController(
                      text: GlobalVar.selectedKupon!.harga_kupon,
                    ),
                    decoration: InputDecoration(
                      labelText: "Harga ",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.attach_money_rounded),
                    ),
                    enabled: false,
                  ),
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(children: [
                  TextFormField(
                    controller: txtJumlahOrder,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: "Jumlah Order",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.inbox),
                    ),
                    onChanged: (value) {
                      setState(() {
                        calculateTotalOrder();
                      });
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(children: [
                  TextFormField(
                    controller: txtTotalHarga,
                    decoration: InputDecoration(
                      labelText: "Total Harga ",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.attach_money_rounded),
                    ),
                    enabled: false,
                  ),
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(children: [
                  TextFormField(
                    controller: txtNoTelp,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: "No Telp",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(children: [
                  TextFormField(
                    onTap: () => displayDatePicker(context),
                    controller: txtTglOrder,
                    decoration: const InputDecoration(
                      labelText: 'Tanggal Order',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.calendar_month),
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(children: [
                  TextFormField(
                    controller: txtKartuKeluarga,
                    decoration: InputDecoration(
                      labelText: "No Kartu Keluarga",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.family_restroom),
                    ),
                    enabled: false,
                  ),
                ]),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white),
                  onPressed: () => submitOrder(),
                  child: const Text("Submit Order")),
              SizedBox(
                height: 15,
              ),
            ]),
          ),
        ),
      ),
    );
  }

  bool checkValidation() {
    if (txtNamaPelanggan.text == "") {
      GlobalFunc.showError(context, "Harap isi Nama Pelanggan !");
      return false;
    }
    return true;
  }

  void submitOrder() {
    if (!checkValidation()) return;

    showDialog(
        context: context,
        builder: (context) {
          GlobalVar.noKartuKeluarga = txtKartuKeluarga.text;
          return DialogOrderPayment();
        }).then((value) {
      if (GlobalVar.succesOrder) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Berhasil Order !"),
            backgroundColor: Colors.green,
          ),
        );
        GlobalVar.succesOrder = false;
      } else {
        ScaffoldMessenger.of(context).clearSnackBars();
        GlobalFunc.showError(context, GlobalVar.orderMessage);
      }
    });
  }

  Future displayDatePicker(BuildContext context) async {
    var date = await showDatePicker(
      context: context,
      initialDate: selected,
      firstDate: initial,
      lastDate: last,
    );

    if (date != null) {
      setState(() {
        txtTglOrder.text = date.toLocal().toString().split(" ")[0];
      });
    }
  }

  Future<void> bindData() async {
    final now = DateTime.now();
    txtNamaPelanggan.text = GlobalVar.currentPelanggan!.nama_lengkap;
    txtAlamat.text = GlobalVar.currentPelanggan!.alamat;
    txtNoTelp.text = GlobalVar.currentPelanggan!.no_telp;
    txtKartuKeluarga.text = GlobalVar.currentPelanggan!.no_kk;
    txtJumlahOrder.text = "1";
    txtTglOrder.text = now.toLocal().toString().split(" ")[0];
    calculateTotalOrder();
  }

  void calculateTotalOrder() {
    int totalValue = int.parse(GlobalVar.selectedKupon!.harga_kupon) *
        int.parse(txtJumlahOrder.text);
    txtTotalHarga.text = totalValue.toString();
    GlobalVar.totalPayment = totalValue.toString();
    GlobalVar.jumlahOrder = txtJumlahOrder.text;
    GlobalVar.tanggalOrder = txtTglOrder.text;
  }
}
