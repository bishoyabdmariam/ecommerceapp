import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../controllers/CartController.dart';
import '../controllers/FavouriteController.dart';
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
  final CartController cartController = Get.find<CartController>();
  final FavouriteController favouriteController =
      Get.find<FavouriteController>();

  TextEditingController commentController = TextEditingController();

  double userRating = 0; // You can set the initial user rating

  @override
  Widget build(BuildContext context) {
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Category: ${widget.product.category ?? ''}',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Obx(
                        () => IconButton(
                          onPressed: () {
                            Get.closeCurrentSnackbar();
                            Get.snackbar(
                              "${widget.product.title}",
                              favouriteController.favouriteItems
                                      .contains(widget.product)
                                  ? "Removed From cart"
                                  : 'Added to Cart',
                              backgroundColor: Colors.black54,
                              colorText: Colors.white,
                            );
                            favouriteController.toggleProduct(widget.product);
                          },
                          icon: Icon(
                            favouriteController.favouriteItems
                                    .contains(widget.product)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red, // Set your desired color
                            size: 24.0, // Set your desired size
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Column(
                      children: [
                        RatingBar.builder(
                          tapOnlyMode: true,
                          unratedColor: Colors.black87,
                          initialRating: widget.product.rating?.rate ?? 0,
                          ignoreGestures: true,
                          updateOnDrag: false,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemBuilder: (context, _) => const Icon(
                            Icons.favorite_border,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (newRate) {},
                        ),
                        Text('${widget.product.rating!.count!.toString()} users rated this item'),
                      ],
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
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          double newRating =
                              userRating; // Initialize with the current user rating
                          return AlertDialog(
                            title: const Text('Rate and Comment'),
                            content: StatefulBuilder(
                              builder:
                                  (BuildContext context, StateSetter setState) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    RatingBar.builder(
                                      initialRating: newRating,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 2.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.favorite_border,
                                        color: Colors.amber,
                                        size: 10,
                                      ),
                                      onRatingUpdate: (rating) {
                                        setState(() {
                                          newRating = rating;
                                        });
                                      },
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "Your Rating is ",
                                        ),
                                        Text(
                                          newRating.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        hintText: 'Write your comment...',
                                      ),
                                      maxLines: 3,
                                      onChanged: (comment) {
                                        // Handle the comment input if needed
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Handle the rating and comment submission
                                  print('User rating: $newRating');
                                  print(
                                      'User comment: ${commentController.text}');

                                  Get.snackbar(
                                    'Rated!',
                                    'You rated the product with $newRating stars and commented.',
                                    backgroundColor: Colors.black54,
                                    colorText: Colors.white,
                                  );

                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: const Text('Submit'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Rate Product'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.off(() => const CartScreen());
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
}
