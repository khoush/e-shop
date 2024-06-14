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
    apiKey: 'AIzaSyCY4lk5b4bYg2Wr4kggMhB6VJ81F7wF-GY',
    appId: '1:458918238150:web:9a853210bb47a8b21584c7',
    messagingSenderId: '458918238150',
    projectId: 'e-shop-13b37',
    authDomain: 'e-shop-13b37.firebaseapp.com',
    storageBucket: 'e-shop-13b37.appspot.com',
    measurementId: 'G-8JMCG1TMWQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCfsrIOzjdSBve-RjWGoeqYlbt6I76z82U',
    appId: '1:458918238150:android:f8f8569e6b8fef8a1584c7',
    messagingSenderId: '458918238150',
    projectId: 'e-shop-13b37',
    storageBucket: 'e-shop-13b37.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA5TSjTybqXQhR8moL4hhWyvkFdF804t0w',
    appId: '1:458918238150:ios:522e1d8538c9aefb1584c7',
    messagingSenderId: '458918238150',
    projectId: 'e-shop-13b37',
    storageBucket: 'e-shop-13b37.appspot.com',
    iosBundleId: 'com.example.eshop',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA5TSjTybqXQhR8moL4hhWyvkFdF804t0w',
    appId: '1:458918238150:ios:f80332736ddc78851584c7',
    messagingSenderId: '458918238150',
    projectId: 'e-shop-13b37',
    storageBucket: 'e-shop-13b37.appspot.com',
    iosBundleId: 'com.example.eshop.RunnerTests',
  );
}
