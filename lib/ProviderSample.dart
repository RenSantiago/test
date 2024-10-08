import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => Cart(),
      child: MaterialApp(
        home: ShoppingCartScreen(),
      ),
    );

  }
}


class ShoppingCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);


    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart (${cart.itemCount} items)'),
      ),
      body: Column(
        children: [
          // List of items to add to the cart
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text('Item 1'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      cart.addItem('Item 1');
                    },
                    child: Text('Add to Cart'),
                  ),
                ),
                ListTile(
                  title: Text('Item 2'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      cart.addItem('Item 2');
                    },
                    child: Text('Add to Cart'),
                  ),
                ),
                // Add more items here
              ],
            ),
          ),
          // Display cart items
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(cart.items[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


// Cart model
class Cart extends ChangeNotifier {
  final List<String> _items = [];


  void addItem(String item) {
    _items.add(item);
    notifyListeners(); // Notify listeners to rebuild UI
  }


  List<String> get items => _items;


  int get itemCount => _items.length;
}

