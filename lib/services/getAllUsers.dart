import 'package:dio/dio.dart';

class UserService {
  final Dio _dio = Dio();

  Future<List<Map<String, dynamic>>?> getUsers() async {
    try {
      final response = await _dio.get('https://fakestoreapi.com/users');

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> users = List<Map<String, dynamic>>.from(response.data);
        return users;
      } else {
        print('Failed to load users. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading users: $e');
    }
    return null;
  }
}
