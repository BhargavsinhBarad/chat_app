import 'package:chat_app/Views/helper/AuthHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (AuthHelper.authHelper.auth.currentUser?.email == null)
            ? Text("user")
            : Text(
                "${AuthHelper.authHelper.auth.currentUser?.email?.split("@")[0]}"),
        actions: [
          IconButton(
            onPressed: () {
              AuthHelper.authHelper.logout();
              Get.back();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
