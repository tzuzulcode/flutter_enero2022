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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAdR7GhzZEhqADIe8TGD3vh71JifywfnxY',
    appId: '1:445933623452:web:76276892582bd0f090b559',
    messagingSenderId: '445933623452',
    projectId: 'tzuzul-code',
    authDomain: 'tzuzul-code.firebaseapp.com',
    storageBucket: 'tzuzul-code.appspot.com',
    measurementId: 'G-RSGR1KE3QS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDyGcH10GrYdEGMj8PKEwR8RfSM57TE7Y4',
    appId: '1:445933623452:android:a11778abd6ff27c690b559',
    messagingSenderId: '445933623452',
    projectId: 'tzuzul-code',
    storageBucket: 'tzuzul-code.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB1_Kai7XPts62KeGaUvViPjOybeMvZrqI',
    appId: '1:445933623452:ios:e5bb3618ab7a85a390b559',
    messagingSenderId: '445933623452',
    projectId: 'tzuzul-code',
    storageBucket: 'tzuzul-code.appspot.com',
    iosClientId: '445933623452-rnkhj35rs7v3t71ve6e27ft1q2doqnp1.apps.googleusercontent.com',
    iosBundleId: 'com.tzuzulcode.com',
  );
}