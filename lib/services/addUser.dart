import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AddUser {
  final Dio dio;

  AddUser(this.dio);

  Future<Map<String, dynamic>?> createUser({
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        'https://fakestoreapi.com/users',
        /*data: {
          'email': email,
          'username': username,
          'password': password,
          'name': {'firstname': firstname, 'lastname': lastname},
          'address': {
            'city': city,
            'street': street,
            'number': number,
            'zipcode': zipcode,
            'geolocation': {'lat': lat, 'long': long}
          },
          'phone': phone,
        },*/
        data: {
          'email': email,
          'username': username,
          'password': password,
          'name': {'firstname': "Bishoy", 'lastname': "Habib"},
          "address": {
            "city": "kilcoole",
            "street": "new road",
            "number": 7682,
            "zipcode": "12926-3874",
            "geolocation": {"lat": "-37.3159", "long": "81.1496"}
          },
          'phone': "01202089993",
        },
      );

      if (response.statusCode! < 300) {
        return response.data;
      } else {
        print("A7A f45");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }
}
