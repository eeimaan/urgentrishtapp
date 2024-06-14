// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyA4CZfNkAdtsINHt8ULbHz6mrkbfsNFHAc',
    appId: '1:138932951122:web:cf072afb072b4130cce78b',
    messagingSenderId: '138932951122',
    projectId: 'urgentrishtapp',
    authDomain: 'urgentrishtapp.firebaseapp.com',
    storageBucket: 'urgentrishtapp.appspot.com',
    measurementId: 'G-9CHNFWKXCG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAVtIk0WJjU_Xu90D8gYS2z6KQ1W2VjF6U',
    appId: '1:138932951122:android:2dd3b3b7d943987dcce78b',
    messagingSenderId: '138932951122',
    projectId: 'urgentrishtapp',
    storageBucket: 'urgentrishtapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD0TFq0mUegqKw3ZJ8dQOj7tzxSQe62rmA',
    appId: '1:138932951122:ios:d53bd1bbe2d84429cce78b',
    messagingSenderId: '138932951122',
    projectId: 'urgentrishtapp',
    storageBucket: 'urgentrishtapp.appspot.com',
    iosBundleId: 'com.example.urgentrishtapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD0TFq0mUegqKw3ZJ8dQOj7tzxSQe62rmA',
    appId: '1:138932951122:ios:d53bd1bbe2d84429cce78b',
    messagingSenderId: '138932951122',
    projectId: 'urgentrishtapp',
    storageBucket: 'urgentrishtapp.appspot.com',
    iosBundleId: 'com.example.urgentrishtapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA4CZfNkAdtsINHt8ULbHz6mrkbfsNFHAc',
    appId: '1:138932951122:web:028c221d523da92bcce78b',
    messagingSenderId: '138932951122',
    projectId: 'urgentrishtapp',
    authDomain: 'urgentrishtapp.firebaseapp.com',
    storageBucket: 'urgentrishtapp.appspot.com',
    measurementId: 'G-V02C9DDH1F',
  );
}