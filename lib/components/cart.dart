class Cart {
  static List<String> _items = [];

  static List<String> get items => _items;

  static void addItem(String item) {
    _items.add(item);
    print('$item sepete eklendi.');
  }

  static void removeItem(String item) {
    _items.remove(item);
    print('$item sepetten çıkarıldı.');
  }
}
