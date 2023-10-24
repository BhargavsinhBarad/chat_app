import 'package:chat_app/Views/Screens/Home_page.dart';
import 'package:chat_app/Views/Screens/sinup_page.dart';
import 'package:chat_app/Views/Screens/splashscreen.dart';
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
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 25),

                  const Icon(
                    Icons.message,
                    size: 75,
                  ),

                  const SizedBox(height: 30),

                  Text(
                    "Login in ChatApp",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: emailcontroller,
                      onChanged: (val) {
                        setState(
                          () {
                            Email = val;
                          },
                        );
                      },
                      decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: "Enter Email",
                          hintStyle: TextStyle(color: Colors.grey[500])),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: passcontroller,
                      onChanged: (val) {
                        setState(() {
                          Password = val;
                        });
                      },
                      obscureText: (pas == false) ? true : false,
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
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: "Enter Password",
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // forgot password?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // sign in button
                  GestureDetector(
                    onTap: () async {
                      if (formkey.currentState!.validate()) {
                        formkey.currentState!.save();
                        Map<String, dynamic> res = await AuthHelper.authHelper
                            .login(email: Email!, password: Password!);
                        if (res['user'] != null) {
                          Get.to(splash());
                        } else {
                          Get.snackbar("flutter", "failed");
                        }
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          Map<String, dynamic> res =
                              await AuthHelper.authHelper.singwithgoogle();
                          if (res['user'] != null) {
                            Get.to(splash());
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.grey[200],
                          ),
                          child: Image.asset(
                            "lib/Assets/image/google.png",
                            height: 40,
                          ),
                        ),
                      ),
                      SizedBox(width: 25),
                      GestureDetector(
                        onTap: () async {
                          Map<String, dynamic> res =
                              await AuthHelper.authHelper.anonymouslylogin();
                          if (res['user'] != null) {
                            Get.to(splash());
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.grey[200],
                          ),
                          child: Image.asset(
                            "lib/Assets/image/6.png",
                            height: 40,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      TextButton(
                        onPressed: () {
                          Get.to(sinup_page());
                        },
                        child: Text(
                          'Register now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
    // return Scaffold(
    //   body: Stack(
    //     children: [
    //       Container(
    //         height: Get.height * 0.5,
    //         child: Center(
    //           child: Container(
    //             height: Get.height * 0.4,
    //             width: Get.width * 0.4,
    //             decoration: BoxDecoration(
    //               image: DecorationImage(
    //                 image: AssetImage("lib/Assets/image/pngwing.com.png"),
    //               ),
    //             ),
    //           ),
    //         ),
    //         decoration: BoxDecoration(
    //           color: Colors.blue,
    //         ),
    //       ),
    //       SingleChildScrollView(
    //         child: Column(
    //           children: [
    //             SizedBox(
    //               height: Get.height * 0.35,
    //             ),
    //             Center(
    //               child: Form(
    //                 key: formkey,
    //                 child: Container(
    //                   height: Get.height * 0.55,
    //                   width: Get.width * 0.9,
    //                   decoration: BoxDecoration(
    //                     color: Colors.lightBlueAccent,
    //                     borderRadius: BorderRadius.circular(20),
    //                   ),
    //                   child: Column(
    //                     children: [
    //                       SizedBox(
    //                         height: Get.height * 0.01,
    //                       ),
    //                       Text(
    //                         "LOGIN",
    //                         style: TextStyle(
    //                           fontSize: 20,
    //                           fontWeight: FontWeight.bold,
    //                         ),
    //                       ),
    //                       SizedBox(
    //                         height: 20,
    //                       ),
    //                       Padding(
    //                         padding: const EdgeInsets.only(left: 25, right: 25),
    //                         child: TextFormField(
    //                           validator: (val) {
    //                             if (val!.isEmpty) {
    //                               return "Enter Email";
    //                             }
    //                           },
    //                           onSaved: (val) {
    //                             Email = val;
    //                           },
    //                           decoration: InputDecoration(
    //                             label: Text("Email"),
    //                             hintText: "Enter your Email...",
    //                             border: OutlineInputBorder(
    //                               borderRadius: BorderRadius.circular(35),
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                       SizedBox(
    //                         height: 20,
    //                       ),
    //                       Padding(
    //                         padding: const EdgeInsets.only(left: 25, right: 25),
    //                         child: TextFormField(
    //                           obscureText: (pas == false) ? true : false,
    //                           onSaved: (val) {
    //                             Password = val;
    //                           },
    //                           validator: (val) {
    //                             if (val!.isEmpty) {
    //                               return "Enter Password";
    //                             }
    //                           },
    //                           decoration: InputDecoration(
    //                             suffixIcon: IconButton(
    //                               onPressed: () {
    //                                 setState(() {
    //                                   pas = !pas;
    //                                 });
    //                               },
    //                               icon: Icon((pas == true)
    //                                   ? CupertinoIcons.eye_slash
    //                                   : CupertinoIcons.eye),
    //                             ),
    //                             label: Text("Password"),
    //                             hintText: "Enter your Password...",
    //                             border: OutlineInputBorder(
    //                               borderRadius: BorderRadius.circular(35),
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                       GestureDetector(
    //                         onTap: () async {
    //                           if (formkey.currentState!.validate()) {
    //                             formkey.currentState!.save();
    //                             Map<String, dynamic> res = await AuthHelper
    //                                 .authHelper
    //                                 .login(email: Email!, password: Password!);
    //                             if (res['user'] != null) {
    //                               Get.to(splash());
    //                             } else {
    //                               Get.snackbar("flutter", "failed");
    //                             }
    //                           }
    //                         },
    //                         child: Container(
    //                           margin:
    //                               EdgeInsets.only(left: 25, right: 25, top: 25),
    //                           height: Get.height * 0.08,
    //                           width: Get.width,
    //                           decoration: BoxDecoration(
    //                             border: Border.all(),
    //                             borderRadius: BorderRadius.circular(30),
    //                           ),
    //                           child: Center(
    //                             child: Text(
    //                               "LOGIN",
    //                               style: TextStyle(
    //                                 fontWeight: FontWeight.w500,
    //                                 fontSize: 20,
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                       Padding(
    //                         padding: const EdgeInsets.only(
    //                           left: 25,
    //                         ),
    //                         child: Align(
    //                           alignment: FractionalOffset.topLeft,
    //                           child: TextButton(
    //                             onPressed: () {
    //                               Get.to(splash());
    //                             },
    //                             child: Text(
    //                               "Create Account..",
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                         children: [
    //                           ElevatedButton(
    //                             onPressed: () async {
    //                               Map<String, dynamic> res = await AuthHelper
    //                                   .authHelper
    //                                   .anonymouslylogin();
    //                               if (res['user'] != null) {
    //                                 Get.to(splash());
    //                               }
    //                             },
    //                             child: Text("Login with user"),
    //                           ),
    //                           ElevatedButton(
    //                             onPressed: () async {
    //                               Map<String, dynamic> res = await AuthHelper
    //                                   .authHelper
    //                                   .singwithgoogle();
    //                               if (res['user'] != null) {
    //                                 Get.to(splash());
    //                               }
    //                             },
    //                             child: Text("Login with Google"),
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
