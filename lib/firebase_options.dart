// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCu32i-FP0c3Ak_xJaFMqme4NQyrn2intc',
    appId: '1:785150704513:web:7c7af732c4f114828b0680',
    messagingSenderId: '785150704513',
    projectId: 'b-chat-app-53380',
    authDomain: 'b-chat-app-53380.firebaseapp.com',
    storageBucket: 'b-chat-app-53380.appspot.com',
    measurementId: 'G-VNE296P12P',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD9T5uWx2ac60nkauITpdujqOLWkFegYto',
    appId: '1:785150704513:android:de16b1dbbcd021ec8b0680',
    messagingSenderId: '785150704513',
    projectId: 'b-chat-app-53380',
    storageBucket: 'b-chat-app-53380.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyANJEabzksevh_3dMca8Dy_MaOvHbhcGPI',
    appId: '1:785150704513:ios:7681e42e58fe71218b0680',
    messagingSenderId: '785150704513',
    projectId: 'b-chat-app-53380',
    storageBucket: 'b-chat-app-53380.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyANJEabzksevh_3dMca8Dy_MaOvHbhcGPI',
    appId: '1:785150704513:ios:f5f54cc06df7f6478b0680',
    messagingSenderId: '785150704513',
    projectId: 'b-chat-app-53380',
    storageBucket: 'b-chat-app-53380.appspot.com',
    iosBundleId: 'com.example.chatApp.RunnerTests',
  );
}
