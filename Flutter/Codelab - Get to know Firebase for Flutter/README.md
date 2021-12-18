# 🔥 Get to know Firebase for Flutter codelab

[Get to know Firebase for Flutter]: https://firebase.google.com/codelabs/firebase-get-to-know-flutter


This is the tutorial project for the [Get to know Firebase for Flutter][] codelab. However, I'll note down some points that is learnt from this codelab.


---

Flutter is developed by Google, and so is Firebase. Therefore, google made it easy for developers to integrate firebase into flutter via [__FlutterFire__](https://firebase.flutter.dev/docs/overview), which completes both the front-end and back-end in application development.

> At the time of writing, FlutterFire is at version 0.1.1+2. Future changes may cause incompatibility with this note.

> This readme serves as my note. For official documentation, please visit [This link](https://firebase.flutter.dev/docs/overview)

---

# 1 - Setting up

1. If this is your first time setting up flutterfire, run `dart pub global activate flutterfire_cli` from the terminal. This needs to be done one time only, and enables you to directly use `flutterfire` from the terminal (If it complains that it is not added to the PATH environment variable, you may manually add it yourself)

1. Add `firebase_core` along with other firebase services you want as dependencies into your project
    ```bash
    flutter pub add firebase_core

    flutter pub add firebase_auth       # Example
    flutter pub add cloud_firestore     # Example

    flutter pub get
    ```

1. Within your project, run `flutterfire configure`. Follow along the steps in choosing your firebase project and targetted platform. At the end, you will see `firebase_options.dart` is automatically generated for you.

1. `Firebase` needs to be initialized. You may do so in the `main()` function:
    ```dart
    main() async {
        WidgetsFlutterBinding.ensureInitialized();
        await Firebase.initializeApp(
            // This is auto imported from firebase_options.dart
            options: DefaultFirebaseOptions.currentPlatform,   
        );
        runApp(MyApp());
    }
    ```



---

# 2 - Continuation

Each firebase services have their own respective packages, like `firebase_auth` and `cloud_firestore`. Luckily, all of them are well documentated and you can check out the references at [HERE](https://firebase.flutter.dev/docs/overview)


Perhaps I will make more notes in the future to record about how each services are implemented.