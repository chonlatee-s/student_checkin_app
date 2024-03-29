import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final userCtrl = TextEditingController(text: '');
  final passCtrl = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 50,
          bottom: 50,
          left: 20,
          right: 20,
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                // print('logo tapped');
              },
              child: Image.asset(
                'assets/logo/logo.jpg',
                width: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: TextField(
                controller: userCtrl,
                decoration: const InputDecoration(
                  label: Text('Username'),
                  icon: Icon(Icons.face),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 20,
              ),
              child: TextField(
                controller: passCtrl,
                obscureText: true,
                decoration: const InputDecoration(
                  label: Text('Password'),
                  icon: Icon(Icons.key_off),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Register'),
                ),
                const SizedBox(
                  width: 10,
                ),
                FilledButton(
                  onPressed: () {
                    doLogin(context);
                  },
                  child: const Text('Login'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  doLogin(BuildContext context) async {
    // cal api login
    final result = await http.post(
      Uri.parse('https://api.itdevclub.com/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': userCtrl.text,
        'password': passCtrl.text,
      }),
    );

    final json = jsonDecode(result.body) as Map<String, dynamic>;
    if (json['ok'] == 0) {
      // TODO: show error
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('${json['error']}'),
            duration: const Duration(seconds: 10),
          ),
        );
      return;
    }

    //save token
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', json['token']);
    context.go('/home');
  }
}
