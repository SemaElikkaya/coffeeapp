import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final username;
  const HomePage({Key? key, @required this.username}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.username == null ? "Kullanıcı Yok" : widget.username),
      ),
      body: Center(
        child: Text("Anasayfa"),
      ),
    );
  }
}
