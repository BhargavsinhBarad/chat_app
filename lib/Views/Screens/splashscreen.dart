import 'dart:async';

import 'package:chat_app/Views/Screens/Home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 4),
      () {
        Get.to(home_page());
      },
    );
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                // shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("lib/Assets/image/pngwing.com.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            const Text(
              "ChatApp",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
