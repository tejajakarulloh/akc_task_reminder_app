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
    apiKey: 'AIzaSyCDKjFaqrPHg4Va6QMS-T8yWfxSEv0mamQ',
    appId: '1:836352732926:web:b854ab67719c52c1073faf',
    messagingSenderId: '836352732926',
    projectId: 'akc-task-reminder-app',
    authDomain: 'akc-task-reminder-app.firebaseapp.com',
    storageBucket: 'akc-task-reminder-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAjvnbwK8MOZ5BuYsT6qpwGjxKL9xf24dQ',
    appId: '1:836352732926:android:0bf2f99ed004a5f6073faf',
    messagingSenderId: '836352732926',
    projectId: 'akc-task-reminder-app',
    storageBucket: 'akc-task-reminder-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCF0OxYtbab9_qzWLDAjz9oxtABfV4sKXU',
    appId: '1:836352732926:ios:986cf9016d286507073faf',
    messagingSenderId: '836352732926',
    projectId: 'akc-task-reminder-app',
    storageBucket: 'akc-task-reminder-app.appspot.com',
    iosClientId: '836352732926-lkkgcl8uaor05g5bltkgdegog3h1uu9p.apps.googleusercontent.com',
    iosBundleId: 'com.aksenkode.akcTaskReminderApp',
  );
}