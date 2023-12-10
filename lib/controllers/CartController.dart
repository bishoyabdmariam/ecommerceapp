import 'package:get/get.dart';

import '../models/productsModel.dart';


class CartController extends GetxController {
  RxMap cartItems = {}.obs;

  void addToCart(Product product) {
    if (cartItems.containsKey(product)) {
      cartItems[product] = cartItems[product]! + 1;
    } else {
      cartItems[product] = 1;
    }
    // You can add additional logic if needed
  }

  void removeFromCart(Product product) {
    if (cartItems.containsKey(product)) {
      if (cartItems[product]! > 1) {
        cartItems[product] = cartItems[product]! - 1;
      } else {
        cartItems.remove(product);
      }
    }
    // You can add additional logic if needed
  }
}
