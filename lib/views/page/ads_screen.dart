//import 'package:simple_app/services/pelanggan.services.dart';
//import 'package:simple_app/utils/global_var.dart';
import 'package:flutter/material.dart';

class ads_screen extends StatefulWidget {
  const ads_screen({super.key});

  @override
  State<ads_screen> createState() => _AdsScreenState();
}

final txtAds = TextEditingController();

class _AdsScreenState extends State<ads_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        title: const Text('Pamsimas'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: txtAds,
              maxLines: 5, // Multiline textarea
              decoration: const InputDecoration(
                hintText: 'Enter your report',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle button press
                final ads = txtAds.text;
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Submitted Data'),
                    content: Text('content: $ads'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
