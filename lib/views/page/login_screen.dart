//import 'package:simple_app/services/pelanggan.services.dart';
import 'package:simple_app/utils/global_func.dart';
//import 'package:simple_app/utils/global_var.dart';
import 'package:simple_app/views/page/home_screen.dart';
import 'package:simple_app/views/page/register_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool hidePassword = false;
final txtEmail = TextEditingController();
final txtPassword = TextEditingController();
//bool _successLogin = false;

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterAlignment: AlignmentDirectional.centerEnd,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 80),
                child: Column(
                  children: [
                    const Text(
                      "Pamsimas",
                      style: TextStyle(fontSize: 30, fontFamily: "Chiller"),
                    ),
                    TextFormField(
                      controller: txtEmail,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: txtPassword,
                      obscureText: !hidePassword,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.lock),
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
                    const SizedBox(height: 5),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        tapLogin(context);
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(45),
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Tidak memiliki akun? ",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterScreen(),
                                ));
                          },
                          child: const Text(
                            "Daftar",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    )
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

bool checkValidation(BuildContext context) {
  if (txtEmail.text == "" || txtPassword.text == "") {
    GlobalFunc.showError(context, "Harap isi semua field!");
    return false;
  }
  return true;
}

void tapLogin(BuildContext context) async {
  if (!checkValidation(context)) return;
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const HomeScreen(),
    ),
  );

  // GlobalVar.currentPelanggan = await PelangganService.checkLoginPelanggan(
  //     context, txtEmail.text, txtPassword.text);

  // if (GlobalVar.currentPelanggan != null) {
  //   GlobalFunc.setUserLogined(txtEmail.text);
  //   _successLogin = true;
// disinii diisi navigator push
  // }
}
