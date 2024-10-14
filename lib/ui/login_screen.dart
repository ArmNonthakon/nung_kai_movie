import 'package:final_mobile_project/ui/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<User> users = [
    User(userName: 'Example', email: 'example@gmail.com', password: '12345678')
  ];
  final _loginKey = GlobalKey<FormState>();
  String? _email;
  String? _password;

  int checkUser(String inputEmail, String inputPassword) {
    int index = users.indexWhere((element) => element.email == inputEmail);
    if (index != -1 && users[index].password == inputPassword) {
      return index;
    } else {
      return -1;
    }
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );
    if (!context.mounted) return;

    users.add(result);
  }

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
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Colors.white),
          padding: const EdgeInsets.fromLTRB(30, 40, 30, 50),
          margin: const EdgeInsets.fromLTRB(20, 160, 20, 0),
          child: Form(
            key: _loginKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login',
                  style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  onChanged: (value) => setState(() {
                    _email = value;
                  }),
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email)),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    }
                    return null;
                  },
                  onChanged: (value) => setState(() {
                    _password = value;
                  }),
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
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
                          if (_loginKey.currentState?.validate() ?? false) {
                            final result = checkUser(_email!, _password!);
                            if (result == -1) {
                              _showDialog(
                                'Login Unsuccessful',
                                'Email or Password is incorrect',
                                () {}, // No additional action needed for unsuccessful login
                              );
                            } else {
                              _showDialog(
                                'Login Successful',
                                'Logged in as ${users[result].userName}.',
                                () {
                                  final user = users.firstWhere(
                                      (element) => element.email == _email);
                                  Navigator.pop(context,
                                      user.userName); // Close the dialog and navigate back
                                },
                              );
                            }
                          }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 18, color: Colors.yellow),
                        ))),
                const SizedBox(
                  height: 10,
                ),
                Center(
                    child: TextButton(
                        onPressed: () {
                          _navigateAndDisplaySelection(context);
                        },
                        child: const Text(
                          "Don't have an account? Sign Up",
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
