import 'package:coffeeapp/profile_page.dart';
import 'package:coffeeapp/settings.dart';
import 'package:flutter/material.dart';
import 'package:coffeeapp/login_page.dart';
import 'promotion_page.dart';
import 'cart_page.dart';
import 'components/tab_controller.dart';

class HomePage extends StatefulWidget {
  final String username;
  final String useremail;
  const HomePage({Key? key, required this.username, required this.useremail})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<String> cartItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hoşgeldin " + widget.username + " !"),
      ),
      drawer: Drawer(
        child: Container(
          color: Color.fromARGB(255, 253, 246, 229).withOpacity(0.5),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(widget.username),
                accountEmail: Text(widget.useremail),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/images/profile.jpg'),
                ),
                decoration: BoxDecoration(
                  color: Colors.brown,
                ),
              ),
              ListTile(
                leading: Icon(Icons.person, color: Colors.brown),
                title: Text('Profil'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(
                        username: widget.username,
                        useremail: widget.useremail,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.brown),
                title: Text('Ayarlar'),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingsPage(
                                username: widget.username,
                                useremail: widget.useremail,
                              )));
                },
              ),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.brown),
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
      ),
      body: Column(
        children: [
          Expanded(
            child: MyTabController(
              onItemAddedToCart: (itemName) {
                setState(() {
                  cartItems.add(itemName);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.brown.withOpacity(0.8),
                    content: Row(
                      children: [
                        Expanded(
                            child: Text('$itemName sepete eklendi',
                                style: TextStyle(color: Color(0xFFFFF2D7)))),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CartPage(
                                  cartItems: cartItems,
                                  username: widget.username,
                                  useremail: widget.useremail,
                                ),
                              ),
                            );
                          },
                          child: Text('Sepete Git',
                              style: TextStyle(color: Color(0xFFFFF2D7))),
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
      ),
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
        selectedItemColor: Colors.brown,
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
          _selectedIndex = 0;
        });
      });
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CartPage(
            cartItems: cartItems,
            username: widget.username,
            useremail: widget.useremail,
          ),
        ),
      ).then((_) {
        setState(() {
          _selectedIndex = 0;
        });
      });
    }
  }
}
