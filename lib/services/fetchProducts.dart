import 'package:dio/dio.dart';

import '../models/productsModel.dart';

class ProductApi {
  final Dio _dio = Dio();

  Future<List<Product>> getProducts() async {
    try {
      final response = await _dio.get('https://fakestoreapi.com/products/');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
