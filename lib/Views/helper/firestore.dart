import 'package:chat_app/Views/helper/AuthHelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Firestorehelper {
  Firestorehelper._();

  static Firestorehelper firestorehelper = Firestorehelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Stream? allmessages;

  adduser({required Map<String, dynamic> data}) {
    firestore
        .collection("users")
        .doc("${AuthHelper.authHelper.auth.currentUser?.uid}")
        .set(data);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchuser() {
    Stream<QuerySnapshot<Map<String, dynamic>>> data = firestore
        .collection("users")
        .where("uid", isNotEqualTo: AuthHelper.authHelper.auth.currentUser?.uid)
        .snapshots();
    return data;
  }

  deleteuser({required String uid}) async {
    await firestore.collection("users").doc(uid).delete();
  }

  sendmessage(
      {required String uid1, required String uid2, required String msg}) async {
    String user1 = uid1;
    String user2 = uid2;

    QuerySnapshot<Map<String, dynamic>> roomdoc =
        await firestore.collection("chat").get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> alldocs =
        await roomdoc.docs;

    bool chatroom = false;
    String fetcheduser1 = "";
    String fetcheduser2 = "";

    for (QueryDocumentSnapshot<Map<String, dynamic>> e in alldocs) {
      fetcheduser1 = e.id.split("_")[0];
      fetcheduser2 = e.id.split("_")[1];

      if ((fetcheduser1 == user1 || fetcheduser1 == user2) &&
          (fetcheduser2 == user1 || fetcheduser2 == user2)) {
        chatroom = true;
      }
    }
    if (chatroom == false) {
      //not available
      await firestore
          .collection("chat")
          .doc("${uid1}_${uid2}")
          .set({"sender": uid1, "receive": uid2});
      await firestore
          .collection("chat")
          .doc("${uid1}_${uid2}")
          .collection("massage")
          .add(
        {
          "sentby": uid1,
          "receivedby": uid2,
          "timestap": FieldValue.serverTimestamp(),
          "msg": msg
        },
      );
    } else {
      //available
      await firestore
          .collection("chat")
          .doc("${fetcheduser1}_${fetcheduser2}")
          .collection("massage")
          .add(
        {
          "sentby": uid1,
          "receivedby": uid2,
          "timestap": FieldValue.serverTimestamp(),
          "msg": msg
        },
      );
    }
  }

  // fetchmessages({required String uid1, required String uid2}) async {
  //   String user1 = uid1;
  //   String user2 = uid2;
  //
  //   QuerySnapshot<Map<String, dynamic>> roomdoc =
  //       await firestore.collection("chat").get();
  //
  //   List<QueryDocumentSnapshot<Map<String, dynamic>>> allDoc =
  //       await roomdoc.docs;
  //
  //   for (QueryDocumentSnapshot<Map<String, dynamic>> e in allDoc) {
  //     fuser1 = e.id.split("_")[0];
  //     fuser2 = e.id.split("_")[1];
  //
  //     if ((fuser1 == user1 || fuser1 == user2) &&
  //         (fuser2 == user1 || fuser2 == user2)) {
  //       croom = true;
  //     }
  //   }
  // }

  display({required String uid1, required String uid2}) async {
    String fuser1 = "";
    String fuser2 = "";
    bool croom = false;
    String user1 = uid1;
    String user2 = uid2;

    QuerySnapshot<Map<String, dynamic>> roomdoc =
        await firestore.collection("chat").get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> allDoc =
        await roomdoc.docs;

    for (QueryDocumentSnapshot<Map<String, dynamic>> e in allDoc) {
      fuser1 = e.id.split("_")[0];
      fuser2 = e.id.split("_")[1];

      if ((fuser1 == user1 || fuser1 == user2) &&
          (fuser2 == user1 || fuser2 == user2)) {
        croom = true;
      }
    }
    if (croom == false) {
      await firestore
          .collection("chat")
          .doc("${uid1}_${uid2}")
          .set({"sender": uid1, "receive": uid2});
      return firestore
          .collection("chat")
          .doc("${uid1}_${uid2}")
          .collection("massage")
          .orderBy("timestap", descending: true)
          .snapshots();
    } else {
      return firestore
          .collection("chat")
          .doc("${fuser1}_${fuser2}")
          .collection("massage")
          .orderBy("timestap", descending: true)
          .snapshots();
    }
  }
}
