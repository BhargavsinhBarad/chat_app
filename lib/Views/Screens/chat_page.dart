import 'dart:developer';

import 'package:chat_app/Views/helper/AuthHelper.dart';
import 'package:chat_app/Views/helper/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../Provider/themeprovider.dart';

class chat_page extends StatefulWidget {
  const chat_page({super.key});

  @override
  State<chat_page> createState() => _chat_pageState();
}

class _chat_pageState extends State<chat_page> {
  TextEditingController mascontroller = TextEditingController();
  String message = "";
  @override
  Widget build(BuildContext context) {
    List<String?> data =
        ModalRoute.of(context)!.settings.arguments as List<String>;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            (data[2] == "null")
                ? const CircleAvatar(
                    radius: 15,
                    foregroundImage: AssetImage(
                      "lib/Assets/image/1.png",
                    ),
                  )
                : CircleAvatar(
                    radius: 15,
                    foregroundImage: NetworkImage(
                      "${data[2]}",
                    ),
                  ),
            SizedBox(
              width: 8,
            ),
            Text("${data[0].toString().split("@")[0]}"),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              (Provider.of<themeprovider>(context, listen: true).theme.isdark ==
                      true)
                  ? "lib/Assets/image/3.png"
                  : "lib/Assets/image/2.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Expanded(
                  child: StreamBuilder(
                stream: Firestorehelper.allmessages,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("${snapshot.hasError}");
                  } else if (snapshot.hasData) {
                    List<QueryDocumentSnapshot<Map<String, dynamic>>> mas =
                        snapshot.data.docs;
                    return ListView.builder(
                      reverse: true,
                      itemCount: mas.length,
                      itemBuilder: (ctx, i) {
                        return Row(
                          mainAxisAlignment: (mas[i]['sentby'] ==
                                  AuthHelper.authHelper.auth.currentUser!.uid)
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Chip(
                                  label: Text("${mas[i]['msg']}"),
                                  backgroundColor: (mas[i]['sentby'] ==
                                          AuthHelper
                                              .authHelper.auth.currentUser!.uid)
                                      ? (Provider.of<themeprovider>(context,
                                                      listen: true)
                                                  .theme
                                                  .isdark ==
                                              true)
                                          ? Colors.black12
                                          : Colors.black26
                                      : (Provider.of<themeprovider>(context,
                                                      listen: true)
                                                  .theme
                                                  .isdark ==
                                              true)
                                          ? Colors.grey
                                          : Colors.black),
                            )
                          ],
                        );
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              )),
              Padding(
                padding: const EdgeInsets.all(5),
                child: TextFormField(
                  controller: mascontroller,
                  onChanged: (val) {
                    setState(() {
                      message = val;
                    });
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          mascontroller.clear();
                          log("${data[0]}");
                          log("${message}");
                          Firestorehelper.firestorehelper.sendmessage(
                            uid1: AuthHelper.authHelper.auth.currentUser!.uid,
                            uid2: data[0]!,
                            msg: message,
                          );
                        },
                        icon: Icon(Icons.send)),
                    hintText: "Send massage......",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
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
