import 'package:chat_app/Views/helper/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthHelper {
  AuthHelper._();

  static AuthHelper authHelper = AuthHelper._();

  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  Future<Map<String, dynamic>> anonymouslylogin() async {
    Map<String, dynamic> res = {};

    try {
      UserCredential userCredential = await auth.signInAnonymously();

      res['user'] = userCredential.user;
    } on FirebaseAuthException catch (e) {
      res['error'] = e.code;
    }
    return res;
  }

  Future<Map<String, dynamic>> signup(
      {required String email, required String password}) async {
    Map<String, dynamic> res = {};

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      res['user'] = userCredential.user;
    } on FirebaseAuthException catch (e) {
      res['error'] = e.code;
    }
    return res;
  }

  Future<Map<String, dynamic>> login(
      {required String email, required String password}) async {
    Map<String, dynamic> res = {};

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      Firestorehelper.firestorehelper.adduser(
        data: {
          "email": userCredential.user?.email,
          "uid": userCredential.user?.uid,
        },
      );
      res['user'] = userCredential.user;
    } on FirebaseAuthException catch (e) {
      res['error'] = e.code;
    }
    return res;
  }

  Future<Map<String, dynamic>> singwithgoogle() async {
    Map<String, dynamic> res = {};

    try {
      final GoogleSignInAccount? googluser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googlauth =
          await googluser?.authentication;

      OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googlauth?.accessToken, idToken: googlauth?.idToken);

      UserCredential userCredential =
          await auth.signInWithCredential(credential);

      Firestorehelper.firestorehelper.adduser(
        data: {
          "email": userCredential.user?.email,
          "uid": userCredential.user?.uid,
        },
      );
      res['user'] = userCredential.user;
    } on FirebaseAuthException catch (e) {
      res['error'] = e.code;
    }
    return res;
  }

  Future<void> logout() async {
    await auth.signOut();
    await googleSignIn.signOut();
  }
}
