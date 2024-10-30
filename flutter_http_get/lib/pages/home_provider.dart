import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/http_provider.dart'; // Ensure the path is correct

class HomeProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<HttpProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("GET - PROVIDER"),
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                height: 100,
                width: 100,
                child: Consumer<HttpProvider>(
                  builder: (context, value, child) {
                    // Ensure you are accessing the data correctly
                    String avatarUrl = value.data.isNotEmpty && value.data[0]['avatar'] != null
                        ? value.data[0]['avatar']
                        : "https://www.uclg-planning.org/sites/default/files/styles/featured_home_left/public/no-user-id"; // Default avatar URL
                    return Image.network(
                      avatarUrl,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            FittedBox(
              child: Consumer<HttpProvider>(
                builder: (context, value, child) => Text(
                  value.data.isNotEmpty && value.data[0]['id'] != null
                      ? "ID : ${value.data[0]["id"]}"
                      : "ID : Belum ada data",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: 20),
            FittedBox(child: Text("Name :", style: TextStyle(fontSize: 20))),
            FittedBox(
              child: Consumer<HttpProvider>(
                builder: (context, value, child) => Text(
                  (value.data.isNotEmpty && value.data[0]['first_name'] != null && value.data[0]['last_name'] != null)
                      ? "${value.data[0]["first_name"]} ${value.data[0]["last_name"]}"
                      : "Belum ada data",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: 20),
            FittedBox(child: Text("Email :", style: TextStyle(fontSize: 20))),
            FittedBox(
              child: Consumer<HttpProvider>(
                builder: (context, value, child) => Text(
                  value.data.isNotEmpty && value.data[0]['email'] != null
                      ? value.data[0]["email"]
                      : "Belum ada data",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: 100),
            OutlinedButton(
              onPressed: () {
                dataProvider.fetchData(); // Assuming this is the method to fetch data
              },
              child: Text(
                "GET DATA",
                style: TextStyle(fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
