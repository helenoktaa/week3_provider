import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    //membungkus aplikasi dengan ChangeNotifier Provider
    //agar state bisa diakses dimana saja
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: const MyApp(),
    ),
  );
}

// 1. State model (business logic)
class CartModel extends ChangeNotifier {
  final List<String> _items = [];

  List<String> get items => _items;

  void add(String itemName) {
    _items.add(itemName);
    //perhatikan code ini memberitahu UI untuk update
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }
}

// 2. UI Layer
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const MyCatalog(),
        '/cart': (context) => const MyCart(),
      },
    );
  }
}

// Halaman Katalog
class MyCatalog extends StatelessWidget {
 const MyCatalog({super.key});

 @override
 Widget build(BuildContext context) {
  final products = ['Nasi Goreng', 'Sate Ayam', 
  'Es Teh', 'Ayam Bakar','Kopi'];
 return Scaffold(
  appBar: AppBar(
    title: const Text('Katalog Makanan'),
    actions: [
  IconButton(
    icon: const Icon(Icons.shopping_cart),
    onPressed: () => Navigator.pushNamed(context, '/cart'),
  ),
],
  ),
  body: ListView.builder(
  itemCount: products.length,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text(products[index]),
      trailing: AddButton(item: products[index]),
    );
  },
),
 );
 }
}

// Widget Tombol Tambah (Menggunakan Provider)
class AddButton extends StatelessWidget {
  final String item;
  const AddButton({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    // context.select memantau apakah item ini sudah ada di keranjang
    final isInCart = context.select<CartModel, bool>(
      (cart) => cart.items.contains(item),
    );

    return TextButton(
      onPressed: isInCart
          ? null
          : () {
              // context.read digunakan untuk memanggil fungsi tanpa
              // "mendengarkan" perubahan
              context.read<CartModel>().add(item);
            },
      child: isInCart
          ? const Icon(Icons.check, color: Colors.green)
          : const Text('TAMBAH'),
    );
  }
}