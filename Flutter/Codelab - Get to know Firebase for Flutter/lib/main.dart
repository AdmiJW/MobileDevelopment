import 'dart:async';


//? Import the firebase related packages: (firebase_core, firebase_auth, cloud_firestore)
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//? 'firebase_options.dart' is auto generated when you run 'flutterfire configure'
import 'firebase_options.dart';
import 'src/authentication.dart';
import 'src/widgets.dart';



//? 1 - ensure WidgetsFlutterBinding are initialized before proceeding.
//? 2 - You may choose to initialize firebase here, but the codelab does it in the state's init() method
//? 3 - runApp()
void main() {
	WidgetsFlutterBinding.ensureInitialized();
	runApp(
		MultiProvider(
			providers: [
				ChangeNotifierProvider.value(value: ApplicationState()),
			],
			builder: (context, child)=> App(),
		)
	);
}



class App extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Firebase Meetup',
			theme: ThemeData(
				buttonTheme: Theme.of(context).buttonTheme.copyWith(
					highlightColor: Colors.deepPurple,
				),
				primarySwatch: Colors.deepPurple,
				textTheme: GoogleFonts.robotoTextTheme(
					Theme.of(context).textTheme,
				),
				visualDensity: VisualDensity.adaptivePlatformDensity,
			),
			home: const HomePage(),
		);
	}
}



class HomePage extends StatelessWidget {
	const HomePage({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('Firebase Meetup'),
			),
			body: ListView(
				children: <Widget>[
					Image.asset('assets/codelab.png'),
					const SizedBox(height: 8),
					const IconAndDetail(Icons.calendar_today, 'October 30'),
					const IconAndDetail(Icons.location_city, 'San Francisco'),
					
					//? This is a stateful widget (but relies on provider's state) that changes at different state.
					//? Eg: logout button, log in form etc
					Consumer<ApplicationState>(
						builder: (context, appState, child)=> Authentication(
							email: appState.email,
							loginState: appState.loginState,
							startLoginFlow: appState.startLoginFlow,
							verifyEmail: appState.verifyEmail,
							signInWithEmailAndPassword: appState.signInWithEmailAndPassword,
							cancelRegistration: appState.cancelRegistration,
							registerAccount: appState.registerAccount,
							signOut: appState.signOut,
						)
					),

					const Divider(
						height: 8,
						thickness: 1,
						indent: 8,
						endIndent: 8,
						color: Colors.grey,
					),
					const Header("What we'll be doing"),
					const Paragraph(
						'Join us for a day full of Firebase Workshops and Pizza!',
					),

					//? This is the section that display a list of guest messages, as well as text field for sending
					//? your guest message
					Consumer<ApplicationState>(
						builder: (context, appState, child)=> Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								if (appState.loginState == ApplicationLoginState.loggedIn) ...[
									const Header('Discussion'),
									GuestBook(
										addMessage: (message)=> appState.addMessageToGuestBook(message),
										messages: appState.guestBookMessages,
									)
								],
							],
						),
					),
				],
			),
		);
	}
}




//? ApplicationState, which holds mainly authentication data
class ApplicationState extends ChangeNotifier {

	//? ApplicationLoginState is an enum defined inside authentication.dart.
	ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
	String? _email;
	StreamSubscription<QuerySnapshot>? _guestBookSubscription;
	List<GuestBookMessage> _guestBookMessages = [];
	
	//? Simple getters
	String? get email => _email;
	ApplicationLoginState get loginState => _loginState;
	List<GuestBookMessage> get guestBookMessages => _guestBookMessages;


	ApplicationState() {
		init();
	}


	//? Initializes Firebase, add listener to the FirebaseAuth instance
	Future<void> init() async {
		await Firebase.initializeApp(
			options: DefaultFirebaseOptions.currentPlatform,
		);

		//? If the user is logged in, we will fetch all guest messages and list them out
		//? Otherwise the guest messages in the state will be cleared.
		FirebaseAuth.instance.userChanges().listen((user) {
			if (user != null) {
				_loginState = ApplicationLoginState.loggedIn;
				_guestBookSubscription = FirebaseFirestore.instance
					.collection('guestbook')
					.orderBy('timestamp', descending: true)
					.snapshots()
					.listen((snapshot) {
						_guestBookMessages = [];
						for (final document in snapshot.docs) {
							_guestBookMessages.add(
								GuestBookMessage(
									name: document.data()['name'] as String,
									message: document.data()['text'] as String,
								),
							);
						}
						notifyListeners();
					});
			} else {
				_loginState = ApplicationLoginState.loggedOut;
				_guestBookMessages = [];
				_guestBookSubscription?.cancel();
			}
			notifyListeners();
		});
	}


	void startLoginFlow() {
		_loginState = ApplicationLoginState.emailAddress;
		notifyListeners();
	}


	Future<void> verifyEmail(String email, void Function(FirebaseAuthException e) errorCallback) async {
		try {

			//? Given an email, returns a list of available sign in methods for this email (or empty if none)
			var methods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

			//? Existing user - Proceed to password
			if (methods.contains('password')) {
				_loginState = ApplicationLoginState.password;
			} 
			//? Non-existing email - Proceed to registration
			else {
				_loginState = ApplicationLoginState.register;
			}
			_email = email;
			notifyListeners();
		} on FirebaseAuthException catch (e) {
			errorCallback(e);
		}
	}


	Future<void> signInWithEmailAndPassword
		(String email, String password, void Function(FirebaseAuthException e) errorCallback) async 
	{
		try {
			await FirebaseAuth.instance.signInWithEmailAndPassword(
				email: email,
				password: password,
			);
		} on FirebaseAuthException catch (e) {
			errorCallback(e);
		}
	}


	void cancelRegistration() {
		_loginState = ApplicationLoginState.emailAddress;
		notifyListeners();
	}


	Future<void> registerAccount
		(String email, String displayName, String password, void Function(FirebaseAuthException e) errorCallback) async
	{
		try {
			var credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
				email: email,
				password: password,
			);
			await credential.user!.updateDisplayName(displayName);
		} on FirebaseAuthException catch (e) {
			errorCallback(e);
		}
	}


	void signOut() {
		FirebaseAuth.instance.signOut();
	}


	Future<DocumentReference> addMessageToGuestBook(String message) {
		if (_loginState != ApplicationLoginState.loggedIn) {
			throw Exception("Must be logged in");
		}

		return FirebaseFirestore.instance
			.collection('guestbook')
			.add(<String, dynamic>{
				'text': message,
				'timestamp': DateTime.now().millisecondsSinceEpoch,
				'name': FirebaseAuth.instance.currentUser!.displayName,
				'userId': FirebaseAuth.instance.currentUser!.uid,
			});
	}
}



class GuestBookMessage {
	final String name;
	final String message;
	
	GuestBookMessage({required this.name, required this.message});
}



class GuestBook extends StatefulWidget {
	final FutureOr<void> Function(String message) addMessage;
	final List<GuestBookMessage> messages;

	const GuestBook({ Key? key, required this.addMessage, required this.messages }) : super(key: key);

	@override
	_GuestBookState createState() => _GuestBookState();
}

class _GuestBookState extends State<GuestBook> {
	final _formKey = GlobalKey<FormState>(debugLabel: '_GuestBookState');
	final _controller = TextEditingController();


	@override
	Widget build(BuildContext context) {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				Padding(
					padding: const EdgeInsets.all(8.0),
					child: Form(
						key: _formKey,
						child: Row(
							children: [
								Expanded(
									child: TextFormField(
										controller: _controller,
										decoration: const InputDecoration(
											hintText: 'Leave a message',
										),
										validator: (value) {
											if (value == null || value.isEmpty) {
												return 'Enter your message to continue';
											}
											return null;
										}
									),
								),
								const SizedBox(width: 8),
								StyledButton(
									onPressed: () async {
										if (_formKey.currentState!.validate()) {
											await widget.addMessage(_controller.text);
											_controller.clear();
										}
									},
									child: Row(
										children: const [
											Icon(Icons.send),
											SizedBox(width: 4),
											Text('SEND'),
										],
									),
								)
							]
						)
					)
				),
				const SizedBox(height: 8),
				for (var message in widget.messages)
					Paragraph('${message.name}: ${message.message}'),
				const SizedBox(height: 8),
			],
		);
	}
}
