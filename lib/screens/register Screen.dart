import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../services/addUser.dart';
import '../services/getAllUsers.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final dio = Dio();
  final addUser = AddUser(Dio());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    emailController.text = "bishoyabdo236@gmail.com";
    usernameController.text = "bishoy";
    passwordController.text = "123";
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty || value.trim().isEmpty || value.trim().isEmpty || value.trim().isEmpty) {
                    return 'Please enter a valid Email';
                  }
                  // You can add more validation logic here if needed
                  return null; // Return null if the input is valid
                },
              ),
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password',),
              ),
              TextFormField(
                controller: password2Controller,
                decoration: const InputDecoration(labelText: 'Confirm password'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Create User'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account"),
                  TextButton(
                    onPressed: () {},
                    child: const Text("Register"),
                  ),
                ],
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
            _showErrorDialog(
                'Username already exists. Please choose a different one.');
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
