import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRPage extends StatefulWidget {
  @override
  _QRPageState createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  String qrData = "https://github.com"; // Başlangıçta QR kodunun içeriği

  void _refreshQRCode() {
    setState(() {
      // QR kod içeriğini güncelle
      qrData = "https://example.com"; // Yeni içeriği burada belirtin
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Kod Sayfası'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QrImageView(
              data: qrData,
              version: QrVersions.auto,
              size: 200.0,
            ),
            SizedBox(height: 20.0),
            Text(
              "QR Code içeriği: $qrData",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _refreshQRCode, // _refreshQRCode fonksiyonunu çağırır
              child: Text('QR Kodu Yenile'),
            ),
          ],
        ),
      ),
    );
  }
}
