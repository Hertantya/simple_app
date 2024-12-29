import 'package:simple_app/model/pelanggan.model.dart';
import 'package:simple_app/services/pelanggan.services.dart';
import 'package:simple_app/utils/global_func.dart';
import 'package:simple_app/utils/global_var.dart';
import 'package:simple_app/views/page/home_screen.dart';
import 'package:simple_app/views/page/login_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

final txtNamaPelanggan = TextEditingController();
final txtAlamat = TextEditingController();
final txtNoTelp = TextEditingController();
final txtEmail = TextEditingController();
final txtPassword = TextEditingController();
final txtConfirmPassword = TextEditingController();
bool hidePassword = false;
bool hideConfirmPassword = false;

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    bindData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset("assets/images/freed.png"),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "Profile Saya",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    TextFormField(
                      controller: txtEmail,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: txtNoTelp,
                      decoration: InputDecoration(
                        labelText: "No Telp",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.numbers),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      obscureText: !hidePassword,
                      controller: txtPassword,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      obscureText: !hideConfirmPassword,
                      controller: txtConfirmPassword,
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            hideConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              hideConfirmPassword = !hideConfirmPassword;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        tapUpdate(context);
                      },
                      child: Text(
                        "Simpan",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(45),
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        tapLogOut(context);
                      },
                      child: Text(
                        "Logout",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> bindData() async {
  final now = DateTime.now();
  if (GlobalVar.currentPelanggan != null) {
    txtEmail.text = GlobalVar.currentPelanggan!.email;
    txtNamaPelanggan.text = GlobalVar.currentPelanggan!.nama_lengkap;
    txtAlamat.text = GlobalVar.currentPelanggan!.alamat;
  }
}

void tapLogOut(BuildContext context) {
  GlobalFunc.setUserLogined("");
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => LoginScreen(),
    ),
  );
}

bool checkValidation(BuildContext context) {
  if (txtEmail.text == "" || txtPassword.text == "") {
    GlobalFunc.showError(context, "Harap isi semua field!");
    return false;
  }
  if (txtConfirmPassword.text != txtPassword.text) {
    GlobalFunc.showError(
        context, "Password dengan Konfirmasi Password tidak sama!");
    return false;
  }
  return true;
}

void tapUpdate(BuildContext context) async {
  GlobalFunc.showLoaderDialog(context);
  if (!checkValidation(context)) return;

  PelangganData data = PelangganData(
      id_pelanggan: GlobalVar.currentPelanggan!.id_pelanggan,
      nama_lengkap: GlobalVar.currentPelanggan!.nama_lengkap,
      tanggal_lahir: GlobalVar.currentPelanggan!.tanggal_lahir,
      jenis_kelamin: GlobalVar.currentPelanggan!.jenis_kelamin,
      alamat: GlobalVar.currentPelanggan!.alamat,
      no_telp: GlobalVar.currentPelanggan!.no_telp,
      email: txtEmail.text,
      password: txtPassword.text,
      asal_desa: GlobalVar.currentPelanggan!.asal_desa,
      no_kk: "",
      path_gambar_kk: "");
  String checkPost = await PelangganService.updatePelanggan(context, data);

  if (checkPost != "") {
    GlobalFunc.showMessage(context, "Sukses update data!");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }
}
