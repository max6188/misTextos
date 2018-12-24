import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

//https://stackoverflow.com/questions/50397372/how-do-i-use-onauthstatechanged-for-firebase-auth-in-flutter
// ************** Begin Auth

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

Future<FirebaseUser> signInWithGoogle() async {
  // Attempt to get the currently authenticated user
  GoogleSignInAccount currentUser = _googleSignIn.currentUser;
  if (currentUser == null) {
    // Attempt to sign in without user interaction
    currentUser = await _googleSignIn.signInSilently();
  }
  if (currentUser == null) {
    // Force the user to interactively sign in
    currentUser = await _googleSignIn.signIn();
  }

  final GoogleSignInAuthentication auth = await currentUser.authentication;

  // Authenticate with firebase
  final FirebaseUser user = await _auth.signInWithGoogle(
    idToken: auth.idToken,
    accessToken: auth.accessToken,
  );

  assert(user != null);
  assert(!user.isAnonymous);

  return user;
}


Future<Null> signOutWithGoogle() async {
  debugPrint('in the SIGN OUT FUNCTION');
  await _auth.signOut();
  await _googleSignIn.signOut();

}

// ************** ENd Auth

void main() => runApp(new MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: new SplashPage(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new LoginPage(),
        '/app': (BuildContext context) => new AppPage(),
      },
    );
  }
}

class SplashPage extends StatefulWidget {
  @override
  State createState() => new _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;



  @override
  void initState() {
    super.initState();

    _auth.onAuthStateChanged.firstWhere((user) => user != null).then((user) {
      debugPrint('AUTH STATE HAS CHANGED');
      debugPrint('user id: '+user.uid);
      Navigator.of(context).pushReplacementNamed('/app');
    });

    new Future.delayed(new Duration(seconds: 1)).then((_) => signInWithGoogle());
  }

  @override
  Widget build(BuildContext context) {
    return new Text('splash 123');
  }
}


class AppPage extends StatelessWidget {

  void _logout(){
    debugPrint('pressed logout button');
    signOutWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('In Da App'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _logout),
        ],
      ),
      body: new Text('Welcome'),
    );
  }
}

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Text('You gotta login'),
    );
  }
}