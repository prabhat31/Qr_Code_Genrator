import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanQrCode extends StatefulWidget {
  const ScanQrCode({Key? key}) : super(key: key);

  @override
  _ScanQRCodeState createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQrCode> {
  String qrResult = 'Scanner Data will appear here ';

  Future<void> scanQr() async {
    try {
      final QrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );
      if (!mounted) return;
      if (QrCode == '-1') {
        return;
      }
      setState(() {
        qrResult = QrCode;
      });
    } on PlatformException {
      setState(() {
        qrResult = 'Fail to read QR Code';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QR Code Scanner')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Text('$qrResult', style: TextStyle(color: Colors.black)),
            SizedBox(height: 30),
            ElevatedButton(onPressed: scanQr, child: Text('Scan Code')),
          ],
        ),
      ),
    );
  }
}
