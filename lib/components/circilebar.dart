import 'package:flutter/material.dart';

class SimpleCircularProgressBar extends StatelessWidget {
  final ValueNotifier<double>? valueNotifier;
  final bool mergeMode;
  final Widget Function(double) onGetText;

  const SimpleCircularProgressBar({
    Key? key,
    this.valueNotifier,
    required this.mergeMode,
    required this.onGetText,
    required double value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 120, // İlerleme çubuğunun genişliği
        height: 120, // İlerleme çubuğunun yüksekliği
        child: CircularProgressIndicator(
          value: valueNotifier?.value ?? 0.5,
          strokeWidth: 10,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ),
    );
  }
}
