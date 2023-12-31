import 'package:chat_app/Views/Screens/login_page.dart';
import 'package:chat_app/Views/helper/AuthHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class sinup_page extends StatefulWidget {
  const sinup_page({super.key});

  @override
  State<sinup_page> createState() => _sinup_pageState();
}

class _sinup_pageState extends State<sinup_page> {
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
                  const Icon(
                    Icons.lock,
                    size: 100,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Create A Account",
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
                        setState(() {
                          Email = val;
                        });
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
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
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
                  GestureDetector(
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        formkey.currentState!.save();
                        AuthHelper.authHelper
                            .signup(email: Email!, password: Password!);
                        Get.snackbar("chat app", "Successfully Signup");
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
                          "Sign up",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
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
    //       Form(
    //         key: formkey,
    //         child: SingleChildScrollView(
    //           child: Column(
    //             children: [
    //               SizedBox(
    //                 height: Get.height * 0.35,
    //               ),
    //               Center(
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
    //                         "SINGUP",
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
    //                           validator: (val) {
    //                             if (val!.isEmpty) {
    //                               return "Enter password";
    //                             }
    //                           },
    //                           onSaved: (val) {
    //                             Password = val;
    //                           },
    //                           decoration: InputDecoration(
    //                             suffixIcon: IconButton(
    //                               onPressed: () {
    //                                 setState(() {
    //                                   pas = !pas;
    //                                 });
    //                               },
    //                               icon: Icon((pas == false)
    //                                   ? CupertinoIcons.eye
    //                                   : CupertinoIcons.eye_slash),
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
    //                         onTap: () {
    //                           if (formkey.currentState!.validate()) {
    //                             formkey.currentState!.save();
    //                             AuthHelper.authHelper
    //                                 .signup(email: Email!, password: Password!);
    //                             Get.snackbar("chat app", "Successfully Signup");
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
    //                               "SINGUP",
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
    //                               Get.to(login_page());
    //                             },
    //                             child: Text(
    //                               "Login Account...",
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
