# 🔥 Get to know Firebase for Flutter codelab

[Get to know Firebase for Flutter]: https://firebase.google.com/codelabs/firebase-get-to-know-flutter


This is the tutorial project for the [Get to know Firebase for Flutter][] codelab. However, I'll hereby note down some key points that I learnt from this codelab.


---
<br>

Flutter is developed by Google, and so is Firebase. Therefore, google made it easy for developers to integrate firebase into flutter via [__FlutterFire__](https://firebase.flutter.dev/docs/overview), which completes both the front-end and back-end in application development.

> At the time of writing, FlutterFire is at version 0.1.1+2. Future changes may cause incompatibility with this note.

> This readme serves as my note. For official documentation, please visit [This link](https://firebase.flutter.dev/docs/overview)

---
<br>

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

1. *(Optional)* If you are planning to release on MacOS platform, you have to perform the following modifications:
   
    In `macos/Runner/DebugProfile.entitlements`:

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
            <key>com.apple.security.app-sandbox</key>
            <true/>
            <key>com.apple.security.cs.allow-jit</key>
            <true/>
            <key>com.apple.security.network.server</key>
            <true/>
            <!-- Add the following two lines -->
            <key>com.apple.security.network.client</key>
            <true/>
    </dict>
    </plist>
    ```

    In `macos/Runner/Release.entitlements`

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
            <key>com.apple.security.app-sandbox</key>
            <true/>
            <!-- Add the following two lines -->
            <key>com.apple.security.network.client</key>
            <true/>
    </dict>
    </plist>
    ```



---
<br>

# 2 - Firebase Authentication

You may want your application to have your users authenticated. Maybe through email+password, maybe through Google sign-in, maybe using phone number?


1. Add `firebase_auth` as a dependency into your project.

    ```
    flutter pub add firebase_auth
    flutter pub get
    ```

1. Ensure your `Firebase` is initialized properly before using authentication services. See section above if you haven't.

1. Now most of the time, you will access authentication related methods through `FirebaseAuth.instance`, which can be thought to be the singleton authentication instance available throughout your application.

### 2.1 - Add Listeners to Authentication Changes

There are 3 methods you can subscribe to listen for authentication state changes:

| Method | Description |
|-|-|
| `authStateChanges()` | * Right after the listener has been registered.<br>* When a user is signed in.<br>* When the current user is signed out. |
| `idTokenChanges()` | * Right after the listener has been registered.<br>* When a user is signed in.<br>* When the current user is signed out.<br>* When there is a change in the current user's token. |
| `userChanges()` | * Right after the listener has been registered.<br>* When a user is signed in.<br>* When the current user is signed out.<br>* When there is a change in the current user's token.<br>* When the following methods provided by FirebaseAuth.instance.currentUser are called:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* reload()<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* unlink()<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* updateEmail()<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* updatePassword()<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* updatePhoneNumber()<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* updateProfile() |


Here's an example of how to listen for authentication changes:

```dart
FirebaseAuth.instance
  .userChanges()
  .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
```

## 2.2 - Authentication workflow

All the authentication workflow can be found [HERE](https://firebase.flutter.dev/docs/auth/usage), including signing in via email+password, social auth, user management etc. It basically involves calling methods of `FlutterAuth.instance` and catching `FirebaseAuthException` when it occurs. 


---
<br>

# 3 - Firestore

Firestore is a No-SQL database that is (crucial) part of the Firebase system. Not only it provides reading and writing data with simplier APIs, it even allows us to subscribe to changes in the database so we can implement realtime updates in our application.

1. Start by adding the package as dependency (and that's it! Firestore is available after you rebuild)

    ```bash
    flutter pub add cloud_firestore
    flutter pub get
    ```

[__Reference HERE__](https://firebase.flutter.dev/docs/firestore/usage)

<br>

### 3.1 - Quick Start

Start by importing the package into your code:
```dart
import 'package:cloud_firestore/cloud_firestore.dart';
```

Almost everything is available inside `FirebaseFirestore.instance` (of type `FirebaseFirestore`). You can think of it as the singleton `FirebaseFirestore` available throughout our application.

You should be familiar of the firestore structure: Collections are like tables and Documents are like rows in terms of SQL databases. Therefore, we can obtain the `CollectionReference` of our firestore and perform regular operations on it:

```dart
CollectionReference users = FirebaseFirestore.instance.collection('users');

Future<void> addUser() {
  // Call the user's CollectionReference to add a new user
  return users
      .add({
        'full_name': fullName, // John Doe
        'company': company, // Stokes and Sons
        'age': age // 42
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}
```

Querying either returns `QuerySnapshot` (If it potentially yields multiple documents) or `DocumentSnapshot` (If it must only be 0 or 1 document returned).

```dart
FirebaseFirestore.instance
  .collection('users')
  .get()
  .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
          print(doc["first_name"]);
      });
  });
```


```dart
FirebaseFirestore.instance
  .collection('users')
  .doc(userId)
  .get()
  .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      print('Document exists on the database');
    }
  });
```

<br>

### 3.2 - Example one-time read

```dart
CollectionReference users = FirebaseFirestore.instance.collection('users');

return FutureBuilder<DocumentSnapshot>(
  future: users.doc(documentId).get(),
  builder:
      (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

    if (snapshot.hasError) {
      return Text("Something went wrong");
    }

    if (snapshot.hasData && !snapshot.data!.exists) {
      return Text("Document does not exist");
    }

    if (snapshot.connectionState == ConnectionState.done) {
      Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
      return Text("Full Name: ${data['full_name']} ${data['last_name']}");
    }

    return Text("loading");
  },
);
```

<br>


### 3.3 - Example Realtime Changes:

```dart
final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').snapshots();

// Example here uses StreamBuilder to build widgets according to updates
@override
Widget build(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    stream: _usersStream,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return Text('Something went wrong');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return Text("Loading");
      }

      return ListView(
        children: snapshot.data!.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          return ListTile(
            title: Text(data['full_name']),
            subtitle: Text(data['company']),
          );
        }).toList(),
      );
    },
  );
}
```

<br>

### 3.4 - Example Querying

We mainly use `where` method to filter our queries. 

```dart
FirebaseFirestore.instance
  .collection('users')
  .where('age', isGreaterThan: 20)
  .get()
  .then(...);
```

<br>

### 3.5 - Example Write and Update

Use `add()`, `set()` and `update()`.

```dart
CollectionReference users = FirebaseFirestore.instance.collection('users');

Future<void> addUser() {
  // Call the user's CollectionReference to add a new user
  return users
      .add({
        'full_name': fullName, // John Doe
        'company': company, // Stokes and Sons
        'age': age // 42
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}
```


```dart
users
  .doc('ABC123')
  .set({
    'full_name': "Mary Jane",
    'age': 18
  })
  .then((value) => print("User Added"))
  .catchError((error) => print("Failed to add user: $error"));
```


```dart
users
  .doc('ABC123')
  .update({'company': 'Stokes and Sons'})
  .then((value) => print("User Updated"))
  .catchError((error) => print("Failed to update user: $error"));
```

<br>

### 3.6 - Example delete

```dart
users
  .doc('ABC123')
  .delete()
  .then((value) => print("User Deleted"))
  .catchError((error) => print("Failed to delete user: $error"));
```



# 4 - Continuation

Each firebase services have their own respective packages, like `firebase_auth` and `cloud_firestore`. Luckily, all of them are well documentated and you can check out the references at [HERE](https://firebase.flutter.dev/docs/overview)


Perhaps I will make more notes in the future to record about how each services are implemented.