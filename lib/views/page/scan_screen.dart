//import 'package:simple_app/services/pelanggan.services.dart';
//import 'package:simple_app/utils/global_var.dart';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zxing/flutter_zxing.dart';
import 'package:simple_app/views/widget/debug_info_widget.dart';
import 'package:simple_app/views/widget/scan_result_widget.dart';
import 'package:simple_app/views/widget/unsupported_platform_widget.dart';

class scan_screen extends StatefulWidget {
  const scan_screen({super.key});

  @override
  State<scan_screen> createState() => _ScanScreenState();
}

final txtAds = TextEditingController();

class _ScanScreenState extends State<scan_screen> {
  Uint8List? createdCodeBytes;

  Code? result;
  Codes? multiResult;

  bool isMultiScan = false;

  bool showDebugInfo = true;
  int successScans = 0;
  int failedScans = 0;

  @override
  Widget build(BuildContext context) {
    final isCameraSupported = defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const TabBar(
            tabs: [
              Tab(text: 'Scan Code'),
              Tab(text: 'Create Code'),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            if (kIsWeb)
              const UnsupportedPlatformWidget()
            else if (!isCameraSupported)
              const Center(
                child: Text('Camera not supported on this platform'),
              )
            else if (result != null && result?.isValid == true)
              ScanResultWidget(
                result: result,
                onScanAgain: () => setState(() => result = null),
              )
            else
              Stack(
                children: [
                  ReaderWidget(
                    onScan: _onScanSuccess,
                    onScanFailure: _onScanFailure,
                    onMultiScan: _onMultiScanSuccess,
                    onMultiScanFailure: _onMultiScanFailure,
                    onMultiScanModeChanged: _onMultiScanModeChanged,
                    onControllerCreated: _onControllerCreated,
                    isMultiScan: isMultiScan,
                    scanDelay: Duration(milliseconds: isMultiScan ? 50 : 500),
                    resolution: ResolutionPreset.high,
                    lensDirection: CameraLensDirection.back,
                    flashOnIcon: const Icon(Icons.flash_on),
                    flashOffIcon: const Icon(Icons.flash_off),
                    flashAlwaysIcon: const Icon(Icons.flash_on),
                    flashAutoIcon: const Icon(Icons.flash_auto),
                    galleryIcon: const Icon(Icons.photo_library),
                    toggleCameraIcon: const Icon(Icons.switch_camera),
                    actionButtonsBackgroundBorderRadius:
                        BorderRadius.circular(10),
                    actionButtonsBackgroundColor: Colors.black.withOpacity(0.5),
                  ),
                  if (showDebugInfo)
                    DebugInfoWidget(
                      successScans: successScans,
                      failedScans: failedScans,
                      error: isMultiScan ? multiResult?.error : result?.error,
                      duration: isMultiScan
                          ? multiResult?.duration ?? 0
                          : result?.duration ?? 0,
                      onReset: _onReset,
                    ),
                ],
              ),
            if (kIsWeb)
              const UnsupportedPlatformWidget()
            else
              ListView(
                children: [
                  WriterWidget(
                    messages: const Messages(
                      createButton: 'Create Code',
                    ),
                    onSuccess: (result, bytes) {
                      setState(() {
                        createdCodeBytes = bytes;
                      });
                    },
                    onError: (error) {
                      _showMessage(context, 'Error: $error');
                    },
                  ),
                  if (createdCodeBytes != null)
                    Image.memory(createdCodeBytes ?? Uint8List(0), height: 400),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void _onControllerCreated(_, Exception? error) {
    if (error != null) {
      // Handle permission or unknown errors
      _showMessage(context, 'Error: $error');
    }
  }

  _onScanSuccess(Code? code) {
    setState(() {
      successScans++;
      result = code;
    });
  }

  _onScanFailure(Code? code) {
    setState(() {
      failedScans++;
      result = code;
    });
    if (code?.error?.isNotEmpty == true) {
      _showMessage(context, 'Error: ${code?.error}');
    }
  }

  _onMultiScanSuccess(Codes codes) {
    setState(() {
      successScans++;
      multiResult = codes;
    });
  }

  _onMultiScanFailure(Codes result) {
    setState(() {
      failedScans++;
      multiResult = result;
    });
    if (result.codes.isNotEmpty == true) {
      _showMessage(context, 'Error: ${result.codes.first.error}');
    }
  }

  _onMultiScanModeChanged(bool isMultiScan) {
    setState(() {
      this.isMultiScan = isMultiScan;
    });
  }

  _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  _onReset() {
    setState(() {
      successScans = 0;
      failedScans = 0;
    });
  }
}
