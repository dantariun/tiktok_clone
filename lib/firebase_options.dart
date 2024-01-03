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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCtLrRUyt7nzIsNuCAyXmoCdDznzgSQOy4',
    appId: '1:255363654885:web:fbf8e18edfac8299b8a00c',
    messagingSenderId: '255363654885',
    projectId: 'tiktok-pepper-kim',
    authDomain: 'tiktok-pepper-kim.firebaseapp.com',
    storageBucket: 'tiktok-pepper-kim.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAfNEwKYB-_I_wIcMXAh5L8AiMfltL6mbA',
    appId: '1:255363654885:android:336c9f3a9b50857db8a00c',
    messagingSenderId: '255363654885',
    projectId: 'tiktok-pepper-kim',
    storageBucket: 'tiktok-pepper-kim.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBIv80hnA5nbKPuhzN7VUoOp8_-P0JLUak',
    appId: '1:255363654885:ios:857eed8ae52910beb8a00c',
    messagingSenderId: '255363654885',
    projectId: 'tiktok-pepper-kim',
    storageBucket: 'tiktok-pepper-kim.appspot.com',
    iosBundleId: 'com.cubox.tiktokClone',
  );
}
