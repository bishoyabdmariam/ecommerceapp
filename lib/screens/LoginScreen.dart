import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../services/addUser.dart';
import '../services/getAllUsers.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final dio = Dio();
  final addUser = AddUser(Dio());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    emailController.text = "bishoyabdo236@gmail.com";
    usernameController.text = "bishoy";
    passwordController.text = "123";
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _createUser(),
                child: const Text('Create User'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createUser() async {
    try {
      // Check if the username already exists
      final userList = await UserService().getUsers();
      print(userList?.length);
      if (userList != null) {
        for (var user in userList) {
          if (user['username'] == usernameController.text) {
            // Username already exists, display an error message
            _showErrorDialog('Username already exists. Please choose a different one.');
            return;
          }
        }
      }

      // If the username is unique, proceed to create the user
      final result = await addUser.createUser(
        email: emailController.text,
        username: usernameController.text,
        password: passwordController.text,
      );

      final updatedUserList = await UserService().getUsers();
      print(updatedUserList?.length);

      // Handle the result as needed...
      print(result);
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
