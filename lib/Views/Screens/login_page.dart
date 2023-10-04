import 'package:chat_app/Views/Screens/sinup_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class login_page extends StatefulWidget {
  const login_page({super.key});

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  String? Email;
  String? Password;
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
              // borderRadius: BorderRadius.only(
              //   bottomLeft: Radius.circular(200),
              //   bottomRight: Radius.circular(200),
              // ),
              color: Colors.blue,
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: Get.height * 0.35,
              ),
              Center(
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
                          onSaved: (val) {
                            Password = val;
                          },
                          decoration: InputDecoration(
                            label: Text("Password"),
                            hintText: "Enter your Password...",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25, right: 25, top: 25),
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
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
