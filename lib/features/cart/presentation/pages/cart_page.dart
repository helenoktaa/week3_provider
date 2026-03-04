import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartProvider>();

    return Scaffold(
      appBar:
          AppBar(title: const Text('Keranjang Belanja')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) =>
                  ListTile(
                title: Text(cart.items[index].name),
              ),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () => cart.removeAll(),
              child:
                  const Text('Hapus Keranjang'),
            ),
          ),
        ],
      ),
    );
  }
}