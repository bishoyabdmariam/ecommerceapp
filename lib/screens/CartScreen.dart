import 'package:ecommerceapp/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/CartController.dart';
import '../models/productsModel.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      floatingActionButton: ElevatedButton(
        onPressed: (){},
        child: const Text("Process to CheckOut"),
      ),*/
      appBar: AppBar(
        title: const Text('My Cart'),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Get.off(const HomeScreen());
          }, icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: cartController.cartItems.isEmpty
          ? const Center(
              child: Text("There is no Products in the Cart, try adding some."),
            )
          : ListView.builder(
              itemCount: cartController.cartItems.length,
              itemBuilder: (context, index) {
                final Product cartItem =
                    cartController.cartItems.keys.toList()[index];
                final int quantity = cartController.cartItems[cartItem]!;

                return Card(
                  margin: const EdgeInsets.all(8.0),
                  elevation: 4.0,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(cartItem.image ?? ''),
                    ),
                    title: Text(cartItem.title ?? ''),
                    subtitle: Text('Category: ${cartItem.category ?? ''}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            // Decrease quantity
                            cartController.removeFromCart(cartItem);
                            setState(() {});
                          },
                        ),
                        Text('$quantity'),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            // Increase quantity
                            cartController.addToCart(cartItem);
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
