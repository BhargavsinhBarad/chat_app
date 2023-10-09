import 'package:chat_app/Views/helper/AuthHelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Firestorehelper {
  Firestorehelper._();

  static Firestorehelper firestorehelper = Firestorehelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> adduser({required Map<String, dynamic> data}) async {
    await firestore
        .collection("users")
        .doc("${AuthHelper.authHelper.auth.currentUser?.uid}")
        .set(data);
  }
}
