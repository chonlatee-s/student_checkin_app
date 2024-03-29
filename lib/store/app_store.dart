import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final students = [];
final studentsChanged = ChangeNotifier();

void getStudents() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  // print('token=$token');

  final result = await http.get(
    Uri.parse('https://api.itdevclub.com/api/students'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  final json = jsonDecode(result.body);
  // ใส่ clear ไว้ทุก จะได้ข้อมูลใหม่เสมอ ควรทำ ป้องกันข้อมูลซ้ำ
  students.clear();
  // ถ้าใช้ add ต้องวนลูป แต่ถ้าใช้ addAll ใส่ทั้งก้อนได้เลย แต่ต้องเป็น array อยู่แล้ว
  students.addAll(json['data']['students']);
  studentsChanged.notifyListeners();
}
