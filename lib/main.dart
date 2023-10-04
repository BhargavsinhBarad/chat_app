import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Views/Screens/login_page.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: login_page(),
    ),
  );
}
