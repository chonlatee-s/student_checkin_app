import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Column(
        children: [
          Image.asset(
            'assets/logo/logo.jpg',
            width: 100,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: TextButton(
              onPressed: () {
                context.go('/login');
              },
              child: const Text('Loading . . .'),
            ),
          ),
        ],
      ),
    );
  }

  // ตรวจสอบ token มีไหม ถ้ามี หมดอายุหรือยัง
  _checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      final result = await http.get(
        Uri.parse('https://api.itdevclub.com/api/students'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final json = jsonDecode(result.body);
      if (json['ok'] == 1) {
        context.go('/home');
      } else {
        context.go('/login');
      }
    } else {
      context.go('/login');
    }
  }
}
