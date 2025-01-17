import 'dart:io';

import 'package:simple_app/model/karyawan.model.dart';
import 'package:simple_app/model/kupon.model.dart';
import 'package:simple_app/model/pelanggan.model.dart';
import 'package:simple_app/model/transaction_order.model.dart';

class GlobalVar {
  // static String URL_API = "https://retohi.com/cgi-dev/w3b/api/";
  // ignore: non_constant_identifier_names
  static String URL_API = "http://10.0.2.2:8000/api/";
  // ignore: non_constant_identifier_names
  static String URL_Image = "$URL_API/uploads/";
  static bool succesOrder = false;
  static String orderMessage = "";

  static String noKartuKeluarga = "";
  static String jumlahOrder = "0";
  static String tanggalOrder = "";
  static String totalPayment = "0";

  static KuponData? selectedKupon;
  static PelangganData? currentPelanggan;
  static KaryawanData? currentKaryawan;
  static TransactionOrderData? currentOrder;

  static File? imageKK;
}
