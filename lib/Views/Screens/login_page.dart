import 'package:chat_app/Views/Screens/Home_page.dart';
import 'package:chat_app/Views/Screens/sinup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/AuthHelper.dart';

class login_page extends StatefulWidget {
  const login_page({super.key});

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String? Email;
  String? Password;
  bool pas = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: Get.height * 0.5,
            child: Center(
              child: Container(
                height: Get.height * 0.4,
                width: Get.width * 0.4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("lib/Assets/image/pngwing.com.png"),
                  ),
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.35,
                ),
                Center(
                  child: Form(
                    key: formkey,
                    child: Container(
                      height: Get.height * 0.55,
                      width: Get.width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Text(
                            "LOGIN",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25, right: 25),
                            child: TextFormField(
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Enter Email";
                                }
                              },
                              onSaved: (val) {
                                Email = val;
                              },
                              decoration: InputDecoration(
                                label: Text("Email"),
                                hintText: "Enter your Email...",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25, right: 25),
                            child: TextFormField(
                              obscureText: (pas == false) ? true : false,
                              onSaved: (val) {
                                Password = val;
                              },
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Enter Password";
                                }
                              },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      pas = !pas;
                                    });
                                  },
                                  icon: Icon((pas == true)
                                      ? CupertinoIcons.eye_slash
                                      : CupertinoIcons.eye),
                                ),
                                label: Text("Password"),
                                hintText: "Enter your Password...",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (formkey.currentState!.validate()) {
                                formkey.currentState!.save();
                                Map<String, dynamic> res = await AuthHelper
                                    .authHelper
                                    .login(email: Email!, password: Password!);
                                if (res['user'] != null) {
                                  Get.to(home_page());
                                } else {
                                  Get.snackbar("flutter", "failed");
                                }
                              }
                            },
                            child: Container(
                              margin:
                                  EdgeInsets.only(left: 25, right: 25, top: 25),
                              height: Get.height * 0.08,
                              width: Get.width,
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  "LOGIN",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                            ),
                            child: Align(
                              alignment: FractionalOffset.topLeft,
                              child: TextButton(
                                onPressed: () {
                                  Get.to(sinup_page());
                                },
                                child: Text(
                                  "Create Account..",
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  Map<String, dynamic> res = await AuthHelper
                                      .authHelper
                                      .anonymouslylogin();
                                  if (res['user'] != null) {
                                    Get.to(home_page());
                                  }
                                },
                                child: Text("Login with user"),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  Map<String, dynamic> res = await AuthHelper
                                      .authHelper
                                      .singwithgoogle();
                                  if (res['user'] != null) {
                                    Get.to(home_page());
                                  }
                                },
                                child: Text("Login with Google"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
