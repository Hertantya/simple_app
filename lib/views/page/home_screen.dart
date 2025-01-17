import 'package:simple_app/views/page/ads_screen.dart';
import 'package:simple_app/views/page/history_screen.dart';
import 'package:simple_app/views/page/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:simple_app/views/page/scan_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> checkLogin() async {
    // var check = await GlobalFunc.checkLoginUser();
    // var check = false;
    // if (!check) {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => LoginScreen(),
    //     ),
    //   );
    // }
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 20,
        title: const Text('Pamsimas'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // 2 columns
          crossAxisSpacing: 16.0, // Space between columns
          mainAxisSpacing: 16.0, // Space between rows
          children: [
            GestureDetector(
              onTap: () {
                // Navigate to the second screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const scan_screen()),
                );
              },
              child: buildImageWithText(
                  'assets/images/scan_qr_code_icon.png', 'QR Code'),
            ),
            GestureDetector(
              onTap: () {
                // Navigate to the second screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const history_screen()),
                );
              },
              child: buildImageWithText(
                  'assets/images/report_icon.png', 'Riwayat Tagihan'),
            ),
            GestureDetector(
              onTap: () {
                // Navigate to the second screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ads_screen()),
                );
              },
              child: buildImageWithText(
                  'assets/images/warning_outline_icon.png', 'Pengaduan'),
            ),
            GestureDetector(
              onTap: () {
                // Navigate to the second screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: buildImageWithText(
                  'assets/images/advertising_icon.png', 'Pengumuman'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImageWithText(String imagePath, String label) {
    return Column(
      children: [
        Expanded(
          child: Image.asset(
            imagePath,
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(label),
      ],
    );
  }
}
