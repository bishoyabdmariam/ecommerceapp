import 'package:get/get.dart';

import '../models/productsModel.dart';


class FavouriteController extends GetxController {
  RxList favouriteItems = [].obs;

  void toggleProduct(Product product) {
    if (!favouriteItems.contains(product)) {
      favouriteItems.add(product);
    } else {
      favouriteItems.remove(product);
    }
    // You can add additional logic if needed
  }
}
