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
    apiKey: 'AIzaSyC_RBun7I-J1bgGNJ0VFE0AkHL-CuBvhis',
    appId: '1:522531275243:web:c3ba9cd3fb4ff3ddb359ae',
    messagingSenderId: '522531275243',
    projectId: 'tekber-37847',
    authDomain: 'tekber-37847.firebaseapp.com',
    storageBucket: 'tekber-37847.firebasestorage.app',
    measurementId: 'G-T42BRXL3MD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDoAt-UgG-ZBPi3sCYrIHcT323j7mnld3w',
    appId: '1:522531275243:android:54b65170635710f1b359ae',
    messagingSenderId: '522531275243',
    projectId: 'tekber-37847',
    storageBucket: 'tekber-37847.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBiPuv8tAQ3Qu3CVpO4EMdLU707VAu0Udo',
    appId: '1:522531275243:ios:2d510ee7435cc556b359ae',
    messagingSenderId: '522531275243',
    projectId: 'tekber-37847',
    storageBucket: 'tekber-37847.firebasestorage.app',
    iosBundleId: 'com.example.healthTrackerApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBiPuv8tAQ3Qu3CVpO4EMdLU707VAu0Udo',
    appId: '1:522531275243:ios:2d510ee7435cc556b359ae',
    messagingSenderId: '522531275243',
    projectId: 'tekber-37847',
    storageBucket: 'tekber-37847.firebasestorage.app',
    iosBundleId: 'com.example.healthTrackerApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC_RBun7I-J1bgGNJ0VFE0AkHL-CuBvhis',
    appId: '1:522531275243:web:b7a41aa8aab803d9b359ae',
    messagingSenderId: '522531275243',
    projectId: 'tekber-37847',
    authDomain: 'tekber-37847.firebaseapp.com',
    storageBucket: 'tekber-37847.firebasestorage.app',
    measurementId: 'G-2NEJ8NSM7G',
  );
}
