import 'package:chat_app/Views/Screens/chat_page.dart';
import 'package:chat_app/Views/helper/AuthHelper.dart';
import 'package:chat_app/Views/helper/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      body: StreamBuilder(
        stream: Firestorehelper.firestorehelper.fetchuser(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          } else if (snapshot.hasData) {
            QuerySnapshot<Map<String, dynamic>>? data = snapshot.data;

            List<QueryDocumentSnapshot<Map<String, dynamic>>>? allusers =
                data?.docs;
            return ListView.builder(
              itemCount: allusers!.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () async {
                    Get.to(chat_page(), arguments: <String>[
                      "${allusers[i]['email']}",
                      "${allusers[i]['uid']}"
                    ]);
                    Firestorehelper.allmessages =
                        await Firestorehelper.firestorehelper.display(
                            uid1: AuthHelper.authHelper.auth.currentUser!.uid,
                            uid2: allusers[i]['uid']);
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(
                          "${allusers[i]['email'].toString().split("@")[0]}"),
                      subtitle: Text("${allusers[i]['email']}"),
                      trailing: IconButton(
                        onPressed: () {
                          Firestorehelper.firestorehelper
                              .deleteuser(uid: allusers[i]['uid']);
                        },
                        icon: Icon(Icons.remove_circle_sharp),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
