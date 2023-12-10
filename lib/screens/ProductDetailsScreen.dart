import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/CartController.dart';
import '../models/productsModel.dart';
import '../models/productsModel.dart';
import 'CartScreen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late CartController cartController;

  @override
  Widget build(BuildContext context) {
    cartController = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title ?? ''),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.plus_one_outlined,
                ),
                onPressed: () {
                  Get.closeAllSnackbars();
                  cartController.addToCart(widget.product);
                  Get.snackbar(
                    'Added to Cart',
                    '${widget.product.title} added to your cart.',
                    backgroundColor: Colors.black54,
                    colorText: Colors.white,
                  );

                  setState(() {});
                },
              ),
              if (cartController.cartItems.isNotEmpty)
                Positioned(
                  right: 1,
                  top: 1,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 8,
                    child: Text(
                      cartController.cartItems.length.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.product.image ?? ''),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16.0),
                  Text(
                    'Category: ${widget.product.category ?? ''}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    cartController.cartItems[widget.product] == null
                        ? "You don't have any of that item in Your Cart"
                        : "You have ${cartController.cartItems[widget.product]} of this Item in your cart ",
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.off(()=> const CartScreen());
                      },
                      child: const Text('Cart Details'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*void _onCartPressed() {
    Get.to(() => const CartScreen());
  }*/

/*
  void launchUrl(Uri uri) async {
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch $uri';
    }
  }

*/
}
