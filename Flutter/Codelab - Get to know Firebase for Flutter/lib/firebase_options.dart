// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB9hnf7okNol1C1JhyYsYqI3Tp0AfsPZls',
    appId: '1:417620240744:web:2aa490d99d2b27b9e38edd',
    messagingSenderId: '417620240744',
    projectId: 'fir-flutter-codelab-2a63c',
    authDomain: 'fir-flutter-codelab-2a63c.firebaseapp.com',
    storageBucket: 'fir-flutter-codelab-2a63c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAnFNiEJn_LbJOYB8B6FGv6X44Cu2KMvQs',
    appId: '1:417620240744:android:12a6694b46df058de38edd',
    messagingSenderId: '417620240744',
    projectId: 'fir-flutter-codelab-2a63c',
    storageBucket: 'fir-flutter-codelab-2a63c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDY0tu-WtxLgISZqo994P0XPOC6fZul1Pw',
    appId: '1:417620240744:ios:fb89151138172d26e38edd',
    messagingSenderId: '417620240744',
    projectId: 'fir-flutter-codelab-2a63c',
    storageBucket: 'fir-flutter-codelab-2a63c.appspot.com',
    iosClientId: '417620240744-hduv9p7tvvmc23uip5608akn24o4aekk.apps.googleusercontent.com',
    iosBundleId: 'com.example.gtkFlutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDY0tu-WtxLgISZqo994P0XPOC6fZul1Pw',
    appId: '1:417620240744:ios:fb89151138172d26e38edd',
    messagingSenderId: '417620240744',
    projectId: 'fir-flutter-codelab-2a63c',
    storageBucket: 'fir-flutter-codelab-2a63c.appspot.com',
    iosClientId: '417620240744-hduv9p7tvvmc23uip5608akn24o4aekk.apps.googleusercontent.com',
    iosBundleId: 'com.example.gtkFlutter',
  );
}
