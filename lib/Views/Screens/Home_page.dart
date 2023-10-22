import 'package:chat_app/Views/Screens/chat_page.dart';
import 'package:chat_app/Views/Screens/login_page.dart';
import 'package:chat_app/Views/helper/AuthHelper.dart';
import 'package:chat_app/Views/helper/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../Provider/themeprovider.dart';

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            (AuthHelper.authHelper.auth.currentUser?.email == null)
                ? const CircleAvatar(
                    radius: 80,
                    foregroundImage: AssetImage("lib/Assets/image/1.png"),
                  )
                : CircleAvatar(
                    radius: 80,
                    foregroundImage: NetworkImage(
                      "${AuthHelper.authHelper.auth.currentUser!.photoURL}",
                    ),
                  ),
            // Divider(),
            (AuthHelper.authHelper.auth.currentUser?.email == null)
                ? Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text("Name:  user"),
                    ))
                : Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Name:  ${AuthHelper.authHelper.auth.currentUser?.email?.split("@")[0]}",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
            (AuthHelper.authHelper.auth.currentUser?.email == null)
                ? Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text("Email:  user"),
                    ))
                : Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Email: ${AuthHelper.authHelper.auth.currentUser?.email}",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "LightTheme",
                    style: TextStyle(fontSize: 18),
                  ),
                  Switch(
                    value: Provider.of<themeprovider>(context, listen: true)
                        .theme
                        .isdark,
                    onChanged: (val) {
                      Provider.of<themeprovider>(context, listen: false)
                          .changetheme(val);
                    },
                  ),
                ],
              ),
            ),
            Divider(),
            GestureDetector(
              onTap: () {
                AuthHelper.authHelper.logout();
                Get.to(login_page());
              },
              child: Container(
                padding: EdgeInsets.all(9),
                width: Get.width,
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "logout",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("ChatApp"),
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
                      "${allusers[i]['uid']}",
                      "${allusers[i]['image']}"
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
                        icon: const Icon(Icons.remove_circle_sharp),
                      ),
                      leading: (allusers[i]['image'] == "null")
                          ? const CircleAvatar(
                              foregroundImage: AssetImage(
                                "lib/Assets/image/1.png",
                              ),
                            )
                          : CircleAvatar(
                              foregroundImage: NetworkImage(
                                "${allusers[i]['image']}",
                              ),
                            ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
