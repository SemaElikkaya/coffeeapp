import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final List<String> cartItems;

  const CartPage({Key? key, required this.cartItems}) : super(key: key);

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Yeni ürün eklemek için bir dialog gösterelim
          showDialog(
            context: context,
            builder: (context) {
              String newItem = ''; // Yeni eklenen ürünü tutacak değişken
              return AlertDialog(
                title: Text('Ürün Ekle'),
                content: TextField(
                  // Yeni ürünü eklemek için bir text field
                  onChanged: (value) {
                    newItem = value; // Yeni ürünü al
                  },
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Dialog'ı kapat
                    },
                    child: Text('İptal'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (newItem.isNotEmpty) {
                        setState(() {
                          widget.cartItems.add(newItem); // Ürünü sepete ekle
                        });
                        Navigator.pop(context); // Dialog'ı kapat
                      }
                    },
                    child: Text('Ekle'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
