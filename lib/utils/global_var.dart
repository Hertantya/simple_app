import 'dart:io';

import 'package:simple_app/model/kupon.model.dart';
import 'package:simple_app/model/pelanggan.model.dart';
import 'package:simple_app/model/transaction_order.model.dart';

class GlobalVar {
  // static String URL_API = "https://retohi.com/cgi-dev/w3b/api/";
  static String URL_API =
      "https://baboon-complete-lizard.ngrok-free.app/pta_web/public/api/";
  static String URL_Image = URL_API + "/uploads/";
  static bool succesOrder = false;
  static String orderMessage = "";

  static String noKartuKeluarga = "";
  static String jumlahOrder = "0";
  static String tanggalOrder = "";
  static String totalPayment = "0";

  static KuponData? selectedKupon = null;
  static PelangganData? currentPelanggan = null;
  static TransactionOrderData? currentOrder = null;

  static File? imageKK = null;
}
