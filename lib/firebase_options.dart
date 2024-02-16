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
    apiKey: 'AIzaSyBggx46XJozzb1e_1Hzi5hTB2Sz71iruvE',
    appId: '1:730333897234:web:7cc0e0ffc592b4007aeecb',
    messagingSenderId: '730333897234',
    projectId: 'chat-app-942ba',
    authDomain: 'chat-app-942ba.firebaseapp.com',
    storageBucket: 'chat-app-942ba.appspot.com',
    measurementId: 'G-CVT45W2WT6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCQdppOTwzcNsRL8PM7JlEVWVrlp5plHF8',
    appId: '1:730333897234:android:c1bc107621a9fcd67aeecb',
    messagingSenderId: '730333897234',
    projectId: 'chat-app-942ba',
    storageBucket: 'chat-app-942ba.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDx7KXH3EVCS4nhY5_c6ootDSDlZcNo0jc',
    appId: '1:730333897234:ios:64130e19c929d1387aeecb',
    messagingSenderId: '730333897234',
    projectId: 'chat-app-942ba',
    storageBucket: 'chat-app-942ba.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDx7KXH3EVCS4nhY5_c6ootDSDlZcNo0jc',
    appId: '1:730333897234:ios:d24f3bd1cf84da1f7aeecb',
    messagingSenderId: '730333897234',
    projectId: 'chat-app-942ba',
    storageBucket: 'chat-app-942ba.appspot.com',
    iosBundleId: 'com.example.chatApp.RunnerTests',
  );
}