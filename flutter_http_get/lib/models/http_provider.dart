import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpProvider with ChangeNotifier {
  List<dynamic> _data = [];

  List<dynamic> get data => _data;

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      _data = json.decode(response.body);
      notifyListeners();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
