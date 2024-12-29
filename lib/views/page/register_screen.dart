import 'dart:io';

import 'package:simple_app/model/kupon.model.dart';
import 'package:simple_app/model/pelanggan.model.dart';
import 'package:simple_app/services/kupon.services.dart';
import 'package:simple_app/services/pelanggan.services.dart';
import 'package:simple_app/utils/global_func.dart';
import 'package:simple_app/utils/global_var.dart';
import 'package:simple_app/views/page/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

File? selectedImage;
bool hidePassword = false;
bool hideConfirmPassword = false;
List<String> _optJenisKelamin = ['Laki-Laki', 'Perempuan'];
String _currentJenisKelamin = _optJenisKelamin[0];
List<KuponData> desaList = List.empty();

DateTime selected = DateTime.now();
DateTime initial = DateTime(1900);
DateTime last = DateTime(2025);
final txtNamaLengkap = TextEditingController();
final txtTglLahir = TextEditingController();
final txtJenisKelamin = TextEditingController();
final txtAlamat = TextEditingController();
final txtNoTelp = TextEditingController();
final txtEmail = TextEditingController();
final txtPassword = TextEditingController();
final txtConfirmPassword = TextEditingController();

final txtKartuKeluarga = TextEditingController();
var desaValue;

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    super.initState();
    loadDesa();
  }

  Future pickImageGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;
    setState(() {
      selectedImage = File(returnedImage.path);
    });
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
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "Register Data",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    TextFormField(
                      controller: txtNamaLengkap,
                      decoration: InputDecoration(
                        labelText: "Nama Lengkap",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onTap: () => displayDatePicker(context),
                      controller: txtTglLahir,
                      decoration: const InputDecoration(
                        labelText: 'Tanggal Lahir',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.calendar_month),
                      ),
                      readOnly: true,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Radio(
                            value: "Laki-Laki",
                            groupValue: _currentJenisKelamin,
                            onChanged: (value) {
                              setState(() {
                                _currentJenisKelamin = value.toString();
                              });
                            }),
                        Text(
                          "Laki-Laki",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Radio(
                            value: "Perempuan",
                            groupValue: _currentJenisKelamin,
                            onChanged: (value) {
                              setState(() {
                                _currentJenisKelamin = value.toString();
                              });
                            }),
                        Text(
                          "Perempuan",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: txtNoTelp,
                      decoration: InputDecoration(
                        labelText: "No Telephone",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: FutureBuilder<List<KuponData>>(
                        future: KuponService.getListDesa(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasData) {
                            final list = snapshot.data!;
                            return DropdownButton(
                              isExpanded: true,
                              hint: Text('Pilih Desa Asal'),
                              items: list.map((item) {
                                return DropdownMenuItem(
                                  value: item!.nama_desa,
                                  child: Text(item!.nama_desa),
                                );
                              }).toList(),
                              onChanged: (newVal) {
                                setState(() {
                                  desaValue = newVal;
                                });
                              },
                              value: desaValue,
                            );
                          } else {
                            return const Text("No data!");
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: txtAlamat,
                      decoration: InputDecoration(
                        labelText: "Alamat",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.location_pin),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: txtKartuKeluarga,
                      decoration: InputDecoration(
                        labelText: "No Kartu Keluarga",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.family_restroom),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(children: [
                        Text(
                          "",
                        ),
                        ElevatedButton(
                            onPressed: () => pickImageGallery(),
                            child: const Text("Upload Kartu Keluarga")),
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                          child: selectedImage != null
                              ? Image.file(selectedImage!)
                              : Text(""),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
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
                      controller: txtPassword,
                      obscureText: !hidePassword,
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
                      controller: txtConfirmPassword,
                      obscureText: !hideConfirmPassword,
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
                        tapRegister(context);
                      },
                      child: Text(
                        "Register",
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
                      },
                      child: Text(
                        "Login",
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

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("USA"), value: "USA"),
      DropdownMenuItem(child: Text("Canada"), value: "Canada"),
      DropdownMenuItem(child: Text("Brazil"), value: "Brazil"),
      DropdownMenuItem(child: Text("England"), value: "England"),
    ];
    return menuItems;
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
        txtTglLahir.text = date.toLocal().toString().split(" ")[0];
      });
    }
  }
}

bool checkValidation(BuildContext context) {
  if (txtNamaLengkap.text == "" ||
      txtTglLahir.text == "" ||
      _currentJenisKelamin == "" ||
      txtAlamat.text == "" ||
      txtNoTelp.text == "" ||
      txtEmail.text == "" ||
      txtPassword.text == "") {
    GlobalFunc.showError(context, "Harap isi semua field!");
    return false;
  }

  if (txtKartuKeluarga.text == "") {
    GlobalFunc.showError(context, "Harap isi Kartu Keluarga !");
    return false;
  }
  if (txtConfirmPassword.text != txtPassword.text) {
    GlobalFunc.showError(
        context, "Password dengan Konfirmasi Password tidak sama!");
    return false;
  }
  if (desaValue == null) {
    GlobalFunc.showError(context, "Harap pilih asal desa!");
    return false;
  }
  return true;
}

void tapRegister(BuildContext context) async {
  GlobalFunc.showLoaderDialog(context);
  if (!checkValidation(context)) return;

  GlobalVar.noKartuKeluarga = txtKartuKeluarga.text;
  GlobalVar.imageKK = selectedImage;
  PelangganData data = PelangganData(
    id_pelanggan: "",
    nama_lengkap: txtNamaLengkap.text,
    tanggal_lahir: txtTglLahir.text,
    jenis_kelamin: _currentJenisKelamin,
    alamat: txtAlamat.text,
    no_telp: txtNoTelp.text,
    email: txtEmail.text,
    password: txtPassword.text,
    asal_desa: desaValue,
    no_kk: GlobalVar.noKartuKeluarga,
    path_gambar_kk: "",
  );
  String checkPost =
      await PelangganService.createPelanggan(context, data, GlobalVar.imageKK!);

  if (checkPost != "") {
    GlobalFunc.showMessage(context, "Sukses registrasi akun!");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }
}

Future loadDesa() async {
  desaList = await KuponService.getListDesa();
}
