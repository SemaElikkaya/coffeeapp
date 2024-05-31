import 'settings.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'promotion_page.dart';
import 'cart_page.dart';
import 'components/tab_controller.dart';

class HomePage extends StatefulWidget {
  final String username;
  const HomePage({Key? key, required this.username}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<String> cartItems = []; // Sepet içeriği listesi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: unnecessary_null_comparison
        title: Text(widget.username == null
            ? "Kullanıcı Yok"
            : "Hoşgeldin " + widget.username + " !"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              color: Colors.blue,
              padding: EdgeInsets.fromLTRB(16, 40, 16, 16),
              child: Text(
                'Menü',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Profil'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Ayarlar'),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingsPage(
                              username: widget.username,
                            )));
              },
            ),
            ListTile(
              title: Text('Çıkış Yap'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/coffee.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: MyTabController(
              onItemAddedToCart: (itemName) {
                setState(() {
                  cartItems.add(itemName); // Ürünü sepete ekle
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        Expanded(child: Text('$itemName sepete eklendi')),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CartPage(
                                    cartItems: cartItems,
                                    username: widget.username),
                              ),
                            );
                          },
                          child: Text('Sepete Git'),
                        ),
                      ],
                    ),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
          ),
        ],
      ), // TabController kullanılan widget
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Anasayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Promosyonlar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Sepetim',
          ),
        ],
        selectedItemColor: Colors.blue,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PromotionPage()),
      ).then((_) {
        setState(() {
          _selectedIndex = 0; // Anasayfa seçeneğine geri dön
        });
      });
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              CartPage(cartItems: cartItems, username: widget.username),
        ),
      ).then((_) {
        setState(() {
          _selectedIndex = 0; // Anasayfa seçeneğine geri dön
        });
      });
    }
  }
}
