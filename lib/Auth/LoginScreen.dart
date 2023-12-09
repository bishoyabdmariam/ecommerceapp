import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../services/addUser.dart';

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
/*  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController zipcodeController = TextEditingController();
  final TextEditingController latController = TextEditingController();
  final TextEditingController longController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();*/

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
/*              TextFormField(
                controller: firstnameController,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              TextFormField(
                controller: lastnameController,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              TextFormField(
                controller: cityController,
                decoration: InputDecoration(labelText: 'City'),
              ),
              TextFormField(
                controller: streetController,
                decoration: InputDecoration(labelText: 'Street'),
              ),
              TextFormField(
                controller: numberController,
                decoration: InputDecoration(labelText: 'Number'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: zipcodeController,
                decoration: InputDecoration(labelText: 'Zip Code'),
              ),
              TextFormField(
                controller: latController,
                decoration: InputDecoration(labelText: 'Latitude'),
              ),
              TextFormField(
                controller: longController,
                decoration: InputDecoration(labelText: 'Longitude'),
              ),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),*/
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
      final result = await addUser.createUser(
        email: emailController.text,
        username: usernameController.text,
        password: passwordController.text,
        /*firstname: firstnameController.text,
        lastname: lastnameController.text,
        city: cityController.text,
        street: streetController.text,
        number: int.parse(numberController.text),
        zipcode: zipcodeController.text,
        lat: latController.text,
        long: longController.text,
        phone: phoneController.text,*/
      );

      // Handle the result as needed...
      if (kDebugMode) {
        print(result);
        print("A7A");
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }
}
