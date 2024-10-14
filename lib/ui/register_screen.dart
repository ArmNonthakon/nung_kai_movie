import 'package:flutter/material.dart';

import '../model/user.dart';
import '../utils/validation_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterScreen> {
  final _registerKey = GlobalKey<FormState>();
  String? _userName;
  String? _email;
  String? _password;
  String? _confirmPassword;

  void _showDialog(String title, String content, VoidCallback onOkPressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                onOkPressed(); // Call the callback function
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Colors.white),
          padding: const EdgeInsets.fromLTRB(30, 40, 30, 20),
          margin: const EdgeInsets.fromLTRB(20, 80, 20, 0),
          child: Form(
            key: _registerKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                  onChanged: (value) => _userName = value,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.perm_identity)),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (ValidationService.validateInputIsEmpty(value!) !=
                        null) {
                      return 'Please enter your email';
                    }
                    final result = ValidationService.validateEmail(value);
                    if (result != null) {
                      return null;
                    } else {
                      return result;
                    }
                  },
                  onChanged: (value) => _email = value,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email)),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    }
                    return null;
                  },
                  onChanged: (value) => _password = value,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.key)),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  controller: TextEditingController(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _password) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  onChanged: (value) => _confirmPassword = value,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirm Password',
                      prefixIcon: Icon(Icons.key)),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(9, 54, 114, 1)),
                        onPressed: () {
                          if (_registerKey.currentState?.validate() ?? false) {
                            User newUser = User(
                                userName: _userName!,
                                email: _email!,
                                password: _password!);
                            _showDialog(
                              'Sign up Successful',
                              'Sign up with email $_email.',
                              () {
                                Navigator.pop(context,
                                    newUser); // Close the dialog and navigate back
                              },
                            );
                          }
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(fontSize: 18, color: Colors.yellow),
                        ))),
                const SizedBox(
                  height: 10,
                ),
                Center(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Already have an account? Sign In",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
