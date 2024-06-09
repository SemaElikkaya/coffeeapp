import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'reset_password.dart';

class AuthPage extends StatefulWidget {
  final String email;

  AuthPage({required this.email});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  String _phoneNumber = '';
  String _securityQuestion = '';
  String _securityAnswer = '';
  bool _isLoading = false;

  Future<void> _verifyIdentity() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': widget.email,
          'phone_number': _phoneNumber,
          'security_answer': _securityAnswer,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Kimlik doğrulama başarılı!',
            style: TextStyle(color: Color(0xFFFFF2D7)),
          ),
          backgroundColor: Colors.brown.withOpacity(0.6),
        ));

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResetPasswordPage(username: widget.email),
          ),
        );
      } else {
        final errorMessage = jsonDecode(response.body)['error'] ??
            'Kimlik doğrulama başarısız oldu.';
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Doğrulama Başarısız'),
            content: Text(errorMessage),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Tamam'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Doğrulama Hatası'),
          content: Text(
              'Beklenmeyen bir hata oluştu. Lütfen daha sonra tekrar deneyin.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tamam'),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kimlik Doğrulama')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Text('Email: ${widget.email}'),
              TextFormField(
                decoration: InputDecoration(labelText: 'Telefon Numarası'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen telefon numaranızı girin';
                  }
                  return null;
                },
                onSaved: (value) {
                  _phoneNumber = value!;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Güvenlik Sorusu'),
                value: _securityQuestion.isEmpty ? null : _securityQuestion,
                items: [
                  DropdownMenuItem(
                    value: 'İlk evcil hayvanınızın adı nedir?',
                    child: Text('İlk evcil hayvanınızın adı nedir?'),
                  ),
                  DropdownMenuItem(
                    value: 'İlkokul öğretmeninizin adı nedir?',
                    child: Text('İlkokul öğretmeninizin adı nedir?'),
                  ),
                  DropdownMenuItem(
                    value: 'En sevdiğiniz yemek nedir?',
                    child: Text('En sevdiğiniz yemek nedir?'),
                  ),
                ],
                onChanged: (newValue) {
                  setState(() {
                    _securityQuestion = newValue!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen bir güvenlik sorusu seçin';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'Güvenlik Sorusu Cevabı'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen güvenlik sorusunun cevabını girin';
                  }
                  return null;
                },
                onSaved: (value) {
                  _securityAnswer = value!;
                },
              ),
              SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown,
                          foregroundColor: Color(0xFFF8F4E1)),
                      onPressed: _verifyIdentity,
                      child: Text('Doğrulama Yap'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
