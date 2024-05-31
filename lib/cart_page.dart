import 'package:flutter/material.dart';
import 'payment_page.dart'; // Ödeme yap sayfasını import et
import 'home_page.dart';

class CartPage extends StatefulWidget {
  final List<String> cartItems;
  final String username; // Username alanı eklendi

  const CartPage({Key? key, required this.cartItems, required this.username})
      : super(key: key); // Username ekleyerek constructor güncellendi

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final List<Map<String, dynamic>> _products = [
    {
      'name': 'Espresso',
      'image': 'assets/images/espresso.png',
      'price': 4.99,
    },
    {
      'name': 'Latte',
      'image': 'assets/images/latte.png',
      'price': 5.99,
    },
    {
      'name': 'Cappuccino',
      'image': 'assets/images/cappuccino.png',
      'price': 4.49,
    },
    {
      'name': 'Iced Americano',
      'image': 'assets/images/iced_americano.png',
      'price': 3.99,
    },
    {
      'name': 'Iced Latte',
      'image': 'assets/images/iced_latte.png',
      'price': 4.99,
    },
    {
      'name': 'Frappe',
      'image': 'assets/images/frappe.png',
      'price': 6.49,
    },
    {
      'name': 'Sandwich',
      'image': 'assets/images/sandwich.png',
      'price': 7.99,
    },
    {
      'name': 'Cake',
      'image': 'assets/images/cake.png',
      'price': 4.99,
    },
    {
      'name': 'Cookie',
      'image': 'assets/images/cookie.png',
      'price': 2.49,
    },
  ];

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0.0;
    for (var item in widget.cartItems) {
      final product =
          _products.firstWhere((element) => element['name'] == item);
      totalPrice += product['price'];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Sepetim'),
      ),
      body: ListView.builder(
        itemCount: widget.cartItems.length,
        itemBuilder: (context, index) {
          final item = widget.cartItems[index];
          final product =
              _products.firstWhere((element) => element['name'] == item);

          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: Image.asset(
                product['image'], // Ürünün fotoğrafını al
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(item),
              subtitle: Text('\$${product['price']}'), // Ürünün fiyatını al
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    widget.cartItems.remove(item); // Ürünü sepetten kaldır
                  });
                },
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Toplam: \$${totalPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: totalPrice > 0
                    ? () {
                        // Ödeme sayfasına git
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PaymentPage(totalPrice: totalPrice),
                          ),
                        ).then((paymentSuccessful) {
                          if (paymentSuccessful == true) {
                            setState(() {
                              widget.cartItems.clear(); // Sepeti temizle
                            });
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Ödeme Başarılı'),
                                content: Text(
                                    'Ödemeniz başarıyla gerçekleşti. Anasayfaya yönlendiriliyorsunuz.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomePage(
                                              username: widget
                                                  .username), // Dinamik username kullanımı
                                        ),
                                      );
                                    },
                                    child: Text('Tamam'),
                                  ),
                                ],
                              ),
                            );
                          }
                        });
                      }
                    : null, // Sepet tutarı 0 ise buton etkisiz hale getirilir
                child: Text('Ödeme Yap'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
