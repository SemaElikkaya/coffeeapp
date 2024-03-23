import "package:coffeeapp/home_page.dart";
import "package:flutter/material.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String username;
  late String password;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                    labelText: "Kullanıcı Adı",
                    labelStyle: TextStyle(color: Colors.purple),
                    border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Kullanıcı Adınızı Giriniz';
                  } else {
                    return null; // Geçerli durumu belirtmek için null döndürüyoruz.
                  }
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onSaved: (value) {
                  username = value!;
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                    labelText: "Şifre",
                    labelStyle: TextStyle(color: Colors.purple),
                    border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Şifrenizi Giriniz';
                  } else {
                    return null; // Geçerli durumu belirtmek için null döndürüyoruz.
                  }
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onSaved: (value) {
                  password = value!;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MaterialButton(
                    child: Text("Üye Ol"),
                    onPressed: () {},
                  ),
                  MaterialButton(
                    child: Text("Şifremi Unuttum"),
                    onPressed: () {},
                  ),
                ],
              ),
              _loginButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginButton() => ElevatedButton(
        child: Text("Giriş Yap"),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            if (username == "sema" && password == "a") {
              debugPrint("Giriş Başarılı!");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(
                      username: username,
                    ),
                  ));
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Hata"),
                      content: Text("Giriş Bilgileriniz Hatalı"),
                      actions: <Widget>[
                        MaterialButton(
                            child: Text("Geri Dön"),
                            onPressed: () => Navigator.pop(context))
                      ],
                    );
                  });
            }
          }
        },
      );
}