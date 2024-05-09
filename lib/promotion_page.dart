import 'package:flutter/material.dart';
import 'dart:math';
import 'components/qr_page.dart';
import 'components/qr_scanner.dart';

class PromotionPage extends StatefulWidget {
  @override
  _PromotionPageState createState() => _PromotionPageState();
}

class _PromotionPageState extends State<PromotionPage> {
  int _progressValue1 = 0;
  int _progressValue2 = 0;

  void _incrementProgress1() {
    setState(() {
      _progressValue1 =
          (_progressValue1 + 1) % 6; // 5 adımda bir döngüyü sağlamak için
    });
  }

  void _decrementProgress1() {
    setState(() {
      if (_progressValue1 > 0) {
        _progressValue1--;
      }
    });
  }

  void _incrementProgress2() {
    setState(() {
      _progressValue2 =
          (_progressValue2 + 1) % 11; // 10 adımda bir döngüyü sağlamak için
    });
  }

  void _decrementProgress2() {
    setState(() {
      if (_progressValue2 > 0) {
        _progressValue2--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Promosyonlar'),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GenerateCodePage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buildProgressBar(
                    value: _progressValue1,
                    totalSteps: 5,
                    title: '5 kahve sizden, 1 kahve bizden!',
                    buttonText: 'HEDİYE EKLE',
                    onButtonPressed: _incrementProgress1,
                    onRemovePressed: _decrementProgress1,
                  ),
                  SizedBox(height: 20),
                  buildProgressBar(
                    value: _progressValue2,
                    totalSteps: 10,
                    title: '10 çekirdek kahve sizden, 1 çekirdek kahve bizden!',
                    buttonText: 'HEDİYE EKLE',
                    onButtonPressed: _incrementProgress2,
                    onRemovePressed: _decrementProgress2,
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 180,
                  height: 80,
                  child: ElevatedButton(
                    onPressed: () {
                      // İlk düğmeye basıldığında yapılacak işlemler
                    },
                    child: Text('HEDİYE / PROMOSYONLAR'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 180,
                  height: 80,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ScanCodePage()),
                      );
                    },
                    child: Text('QR KODU TARAT'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildProgressBar({
    required int value,
    required int totalSteps,
    required String title,
    required String buttonText,
    required VoidCallback onButtonPressed,
    required VoidCallback onRemovePressed,
  }) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              child: CustomPaint(
                painter: CircleProgressBarPainter(
                  progress: value / totalSteps.toDouble(),
                ),
              ),
            ),
            Text(
              '$value/$totalSteps',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: onButtonPressed,
              tooltip: 'Hediye Ekle',
            ),
            SizedBox(width: 20),
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: onRemovePressed,
              tooltip: 'Hediye Sil',
            ),
          ],
        ),
      ],
    );
  }
}

class CircleProgressBarPainter extends CustomPainter {
  final double progress;

  CircleProgressBarPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = size.width / 2 - paint.strokeWidth / 2;

    canvas.drawCircle(center, radius, paint);

    Paint progressPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.orange, Colors.red],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double progressAngle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      progressAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
