# Firebase Social Authentication 🔐

In the [Codelab - Get to know Firebase for Flutter](https://github.com/AdmiJW/MobileDevelopment/tree/master/Flutter/Codelab%20-%20Get%20to%20know%20Firebase%20for%20Flutter), we get familiarized with the integration of Firebase inside Flutter application. However, only email-password authentication method is done in the codelab. Turns out, things are significantly different for social auth - logging in using Google Accounts, Facebook, Github, Twitter etc.


Therefore, this mini-project serves to get familiarize with the various authentication methods in FlutterFire. Sign-in providers used in this project:

1. Facebook
2. Google Sign In
3. Github

---
<br>

## 1. Github

[__Reference__](https://firebase.flutter.dev/docs/auth/social#github)

1. Add the dependency for your project:

    ```
    flutter pub add github_sign_in
    flutter pub get
    ```
    __At the time of writing, the latest release of this package does not have null-satefy yet, thus may add problems to your package. However, the prerelease version does have null-satefy, and is used in this mini-project. See `pubspec.yaml` for more info__

1. Setup a new (or use existing) Github OAuth App at [Github Developer Settings](https://github.com/settings/developers). Note the __Client ID__, and generate a new __Client Secret__.

1. Go to your project in [Firebase Console](https://console.firebase.google.com/). Add Github as your authentication provider and paste the Client ID and Client Secret in respective fields. Then, copy the __Authorization Redirect Url__.

1. Go back to previous Github Developer Settings, and provide the authorization redirect url (and also Homepage Url).

1. Ready to use.

    ```dart
    import 'package:github_sign_in/github_sign_in.dart';

    Future<UserCredential> signInWithGitHub() async {
        // Change these!!!!!!!
        final GitHubSignIn gitHubSignIn = GitHubSignIn(
            clientId: clientId,
            clientSecret: clientSecret,
            redirectUrl: 'https://my-project.firebaseapp.com/__/auth/handler');

    // Trigger the sign-in flow
    final result = await gitHubSignIn.signIn(context);

    // Create a credential from the access token
    final githubAuthCredential = GithubAuthProvider.credential(result.token);

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(githubAuthCredential);
    }
    ```

---
<br>

## 2. Google

[__Reference__](https://firebase.flutter.dev/docs/auth/social#google)

[__SHA1 Signature Guide__](https://flutteragency.com/how-to-generate-sha-1-in-flutter/)

1. Add the dependency for your project:

    ```
    flutter pub add google_sign_in
    flutter pub get
    ```

1. Obtain the SHA1 key for your application by following this [__Reference__](https://flutteragency.com/how-to-generate-sha-1-in-flutter/). Personally, I used this method 

    ```
    cd android
    ./gradlew signingReport
    ```

    > When creating a new Android app "debug signing certificate SHA-1" is optional, however, it is required for Dynamic Links & Phone Authentication. To generate a certificate run cd android && ./gradlew signingReport and copy the SHA1 from the debug key. This generates two variant keys. You can copy the 'SHA1' that belongs to the debugAndroidTest variant key option.

1. To your Google Firebase Console, add Google Sign-In as a new authentication method. 

1. Within the __Project Settings__ of your project in the console, select the android app, select `Add fingerprint` and insert your SHA1 key inside.

1. In the same page, download `google-services.json` and put it inside your project's `android/app` directory.

1. Ready to use:

    ```dart
    import 'package:google_sign_in/google_sign_in.dart';

    Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
    }
    ```

---
<br>

## 3. Facebook

[__Reference__](https://firebase.flutter.dev/docs/auth/social#facebook)

[__Guide__](https://developers.facebook.com/docs/facebook-login/android/?locale=en)

1. By far, Facebook sign-in is the most painful I've worked so far, so I am lazy to write guide for this. See the above Guides and figure it yourself. Bye.

---
<br>


## Environment Variables & Usage Notes

Google Sign in requires providing the SHA-1 application signature in the firebase console. Therefore you need to have it set up properly in order for Google Sign-in to even work properly. See [__HERE__](https://stackoverflow.com/questions/51845559/generate-sha-1-for-flutter-react-native-android-native-app/58518934#58518934) for some leads on how to do this.

In order for some authentication to work properly, please include a `.env` file on the root directory of the project. Then, set these environment variables respectively:

| Environment Variables | Description |
|-|-|
| `GITHUB_CLIENT_ID` | Github Authentication Client ID |
| `GITHUB_CLIENT_SECRET` | Github Authentication Client Secret |
| `GITHUB_REDIRECT_URL` | Github Authentication Redirect URL |