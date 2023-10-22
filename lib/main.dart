import 'package:chat_app/Views/Screens/intro_screen.dart';
import 'package:chat_app/Views/Screens/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Provider/themeprovider.dart';
import 'Views/Screens/login_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool isvisited = preferences.getBool("isIntroVisited") ?? false;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ListenableProvider<themeprovider>(create: (context) => themeprovider()),
    ],
    builder: (context, _) => GetMaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(useMaterial3: true),
      theme: ThemeData.light(useMaterial3: true),
      themeMode:
          (Provider.of<themeprovider>(context, listen: true).theme.isdark ==
                  true)
              ? ThemeMode.light
              : ThemeMode.dark,
      initialRoute: (isvisited) ? 'splash' : '/',
      routes: {
        '/': (ctx) => intro_page(),
        'splash': (ctx) => splash(),
      },
    ),
  ));
}
