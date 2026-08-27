import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'LifeBook Beta is currently configured for Android only.',
      );
    }

    return android;
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDgIm3gYnr_UZthASaqysYhzPIgm3CY5mc',
    appId: '1:134422208922:android:61391ad4bacc64dcfa5a23',
    messagingSenderId: '134422208922',
    projectId: 'lifebook-beta-2002',
    storageBucket: 'lifebook-beta-2002.firebasestorage.app',
  );
}
