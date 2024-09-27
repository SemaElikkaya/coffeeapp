import 'package:flutter/material.dart';

class MyTabController extends StatefulWidget {
  final Function(String) onItemAddedToCart;

  MyTabController({required this.onItemAddedToCart});

  @override
  _MyTabControllerState createState() => _MyTabControllerState();
}

class _MyTabControllerState extends State<MyTabController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // Geri butonunu kaldırma
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60.0), // TabBar yüksekliğini ayarla
            child: TabBar(
              isScrollable: false, // TabBar'ın kaydırılabilir olmasını sağla
              tabs: [
                buildTab('Sıcak Kahveler'),
                buildTab('Soğuk Kahveler'),
                buildTab('Yiyecekler')
              ],
              indicatorColor:
                  Colors.brown, // Seçilen tab gösterge çizgisi rengi
              labelColor: Colors.brown, // Seçilen tab yazı rengi
              unselectedLabelColor: Colors.black, // Seçilmemiş tab yazı rengi
            ),
          ),
        ),
        body: TabBarView(
          children: [
            HotCoffeeList(onItemAddedToCart: widget.onItemAddedToCart),
            ColdCoffeeList(onItemAddedToCart: widget.onItemAddedToCart),
            FoodList(onItemAddedToCart: widget.onItemAddedToCart),
          ],
        ),
      ),
    );
  }

  Widget buildTab(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 15.0),
      ),
    );
  }
}

class HotCoffeeList extends StatelessWidget {
  final Function(String) onItemAddedToCart;

  HotCoffeeList({required this.onItemAddedToCart});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: [
        CoffeeItem(
          name: 'Espresso',
          image: 'assets/images/espresso.png',
          price: 4.99,
          onItemAddedToCart: onItemAddedToCart,
        ),
        CoffeeItem(
          name: 'Latte',
          image: 'assets/images/latte.png',
          price: 5.99,
          onItemAddedToCart: onItemAddedToCart,
        ),
        CoffeeItem(
          name: 'Cappuccino',
          image: 'assets/images/cappuccino.png',
          price: 4.49,
          onItemAddedToCart: onItemAddedToCart,
        ),
        // Add more coffee items as needed
      ],
    );
  }
}

class ColdCoffeeList extends StatelessWidget {
  final Function(String) onItemAddedToCart;

  ColdCoffeeList({required this.onItemAddedToCart});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: [
        CoffeeItem(
          name: 'Iced Americano',
          image: 'assets/images/iced_americano.png',
          price: 3.99,
          onItemAddedToCart: onItemAddedToCart,
        ),
        CoffeeItem(
          name: 'Iced Latte',
          image: 'assets/images/iced_latte.png',
          price: 4.99,
          onItemAddedToCart: onItemAddedToCart,
        ),
        CoffeeItem(
          name: 'Frappe',
          image: 'assets/images/frappe.png',
          price: 6.49,
          onItemAddedToCart: onItemAddedToCart,
        ),
        // Add more cold coffee items as needed
      ],
    );
  }
}

class FoodList extends StatelessWidget {
  final Function(String) onItemAddedToCart;

  FoodList({required this.onItemAddedToCart});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: [
        CoffeeItem(
          name: 'Sandwich',
          image: 'assets/images/sandwich.png',
          price: 7.99,
          onItemAddedToCart: onItemAddedToCart,
        ),
        CoffeeItem(
          name: 'Cake',
          image: 'assets/images/cake.png',
          price: 4.99,
          onItemAddedToCart: onItemAddedToCart,
        ),
        CoffeeItem(
          name: 'Cookie',
          image: 'assets/images/cookie.png',
          price: 2.49,
          onItemAddedToCart: onItemAddedToCart,
        ),
        // Add more food items as needed
      ],
    );
  }
}

class CoffeeItem extends StatelessWidget {
  final String name;
  final String image;
  final double price;
  final Function(String) onItemAddedToCart;

  const CoffeeItem({
    Key? key,
    required this.name,
    required this.image,
    required this.price,
    required this.onItemAddedToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 255, 255, 253),
      margin: EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '\$$price',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                onItemAddedToCart(name);
              },
              icon: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
