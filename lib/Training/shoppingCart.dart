import 'package:flutter/material.dart';

class ShoppingCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShoppingCartScreen(),
    );
  }
}


class ShoppingCartScreen extends StatefulWidget {
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}


class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  List<String> _cartItems = [];


  // Function to add item to cart
  void _addItem(String item) {
    setState(() {
      _cartItems.add(item);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart (${_cartItems.length} items)'),
      ),
      body: Column(
        children: [
          // List of items you can add to the cart
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text('Item 1'),
                  trailing: ElevatedButton(
                    onPressed: () => _addItem('Item 1'),
                    child: Text('Add to Cart'),
                  ),
                ),
                ListTile(
                  title: Text('Item 2'),
                  trailing: ElevatedButton(
                    onPressed: () => _addItem('Item 2'),
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
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_cartItems[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

