import 'dart:developer';

import 'package:chat_app/Views/helper/AuthHelper.dart';
import 'package:chat_app/Views/helper/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
        title: Text("chat app"),
        centerTitle: true,
      ),
      body: Column(
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
                            child: Chip(label: Text("${mas[i]['msg']}")),
                          )
                        ],
                      );
                    });
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
    );
  }
}
