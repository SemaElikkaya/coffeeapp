import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/theme_notifier.dart';
import 'home_page.dart';

class SettingsPage extends StatefulWidget {
  final String username;
  final String useremail;

  const SettingsPage(
      {Key? key, required this.username, required this.useremail})
      : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ayarlar'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(
                  username: widget.username,
                  useremail: widget.useremail,
                ),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bildirimler',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'Bildirimleri açıp kapatabilirsiniz.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Tema',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'Uygulama temasını seçebilirsiniz.',
                style: TextStyle(fontSize: 16),
              ),
              SwitchListTile(
                title: Text('Dark Mode'),
                value: Provider.of<ThemeNotifier>(context).isDarkMode,
                onChanged: (value) {
                  Provider.of<ThemeNotifier>(context, listen: false)
                      .toggleTheme();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                        username: widget.username,
                        useremail: widget.useremail,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
