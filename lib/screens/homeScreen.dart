import 'package:ecommerceapp/controllers/CartController.dart';
import 'package:ecommerceapp/screens/ProductDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../controllers/FavouriteController.dart';
import '../models/productsModel.dart';
import '../services/fetchProducts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductApi productApi = ProductApi();

  @override
  Widget build(BuildContext context) {
    final FavouriteController favouriteController =
        Get.put(FavouriteController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart_outlined),
              onPressed: () {},
            ),
          ),
        ],
        title: const Text('Product List'),
      ),
      body: FutureBuilder<List<Product>>(
        future: productApi.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            final products = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return InkWell(
                  onTap: () async {
                    Get.to(() => ProductDetailsScreen(product: product));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 80,
                              height: 80,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  product.image ?? "",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Flexible(
                              child: SingleChildScrollView(
                                child: Text(
                                  product.title ?? '',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "${product.price.toString()} \$",
                              style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                        Obx(
                          () => Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: () {
                                favouriteController.toggleProduct(product);
                              },
                              icon: Icon(
                                favouriteController.favouriteItems
                                        .contains(product)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.red, // Set your desired color
                                size: 24.0, // Set your desired size
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            left: 0,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amberAccent,
                                ),
                                Text(product.rating!.rate.toString() ?? ""),
                              ],
                            )),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
