import 'package:simple_app/model/transaction_order.model.dart';
import 'package:simple_app/services/transaction_order.services.dart';
import 'package:simple_app/utils/global_var.dart';
import 'package:simple_app/views/page/trx_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// List<String> _optPaymentMethod = ['OVO', 'DANA', 'Virtual BCA'];
List<String> _optPaymentMethod = ['Bank BRI'];

class DialogOrderPayment extends StatefulWidget {
  const DialogOrderPayment({super.key});

  @override
  State<DialogOrderPayment> createState() => _DialogOrderPaymentState();
}

class _DialogOrderPaymentState extends State<DialogOrderPayment> {
  var _isInvalid = false;
  var _isPaymentProcess = false;
  String _currentPayment = _optPaymentMethod[0];
  final txtNoTelp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        height: MediaQuery.of(context).size.width + 150,
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              "Pembayaran",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Container(
              child: Icon(
                Icons.account_balance_wallet,
                size: 64,
                color: Colors.green,
              ),
            ),
            // loadPaymentMethod("OVO", "payment-ovo.png"),
            // loadPaymentMethod("DANA", "payment-dana.png"),
            loadPaymentMethod("Bank BRI", "payment-bri.png"),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Column(
                children: [
                  Text("No Telp / Rekening"),
                  SizedBox(height: 5),
                  TextField(
                    controller: txtNoTelp,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      border: OutlineInputBorder(),
                      hintText: '...',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  if (!_isInvalid)
                    Text(
                      "* Harap isi No Telp!",
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  SizedBox(height: 5),
                  Text("Total Pembayaran"),
                  Text(
                    GlobalVar.totalPayment,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 15),
                  if (_isPaymentProcess) const CircularProgressIndicator(),
                  if (!_isPaymentProcess)
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white),
                        onPressed: () => submitPayment(),
                        child: const Text("Bayar")),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container loadPaymentMethod(String paymentMethodValue, String imageLogo) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Row(
        children: [
          Radio(
              value: paymentMethodValue,
              groupValue: _currentPayment,
              onChanged: (value) {
                setState(() {
                  _currentPayment = value.toString();
                });
              }),

          // Image.asset("assets/images/" + imageLogo),
          ClipOval(
            child: Image.asset("assets/images/" + imageLogo,
                height: 40.0, width: 40.0, fit: BoxFit.contain),
          ),
          // ClipPath(
          //   clipper: ShapeBorderClipper(shape: const CircleBorder()),
          //   clipBehavior: Clip.hardEdge,
          //   child: Image.asset(
          //     "assets/images/" + imageLogo,
          //     height: 40,
          //     width: 60,
          //     fit: BoxFit.fill,
          //   ),
          // ),
          SizedBox(width: 20),
          Text(paymentMethodValue)
        ],
      ),
    );
  }

  bool checkValidation(BuildContext context) {
    if (txtNoTelp.text == "") {
      return false;
    }
    return true;
  }

  Future submitPayment() async {
    _isInvalid = checkValidation(context);
    if (!_isInvalid) return;
    setState(() {
      _isPaymentProcess = true;
    });

    TransactionOrderData data = TransactionOrderData(
        id_order: "",
        id_pelanggan: GlobalVar.currentPelanggan!.id_pelanggan,
        id_kupon: GlobalVar.selectedKupon!.id_kupon,
        no_kk: GlobalVar.noKartuKeluarga,
        path_gambar_kk: "",
        tanggal_order: GlobalVar.tanggalOrder,
        jumlah_order: GlobalVar.jumlahOrder,
        total_order: txtTotalHarga.text,
        status_order: "Pending",
        nama_pelanggan: "",
        jenis_kupon: "",
        harga_kupon: "");
    String checkPost =
        await TransactionOrderService.createTransactionOrder(context, data);

    GlobalVar.succesOrder = checkPost != "";

    setState(() {
      _isPaymentProcess = false;
    });
    // GlobalVar.succesOrder = true;
    Navigator.of(context).pop();
  }
}
