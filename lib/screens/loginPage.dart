import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ignite3/screens/mainPage.dart';
import 'package:ignite3/screens/registrationPage.dart';
import 'package:ignite3/widgets/progressDialog.dart';
import 'package:ignite3/widgets/taxiButton.dart';
import './registrationPage.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String title) {
    final snackbar = SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  void login() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => ProgressDialog(
        status: 'Logging you in',
      ),
    );
    final User user = (await _auth
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .catchError((ex) {
      Navigator.pop(context);
      PlatformException thisEx = ex;
      showSnackBar(thisEx.message);
    }))
        .user;

    if (user != null) {
      DatabaseReference userRef =
          FirebaseDatabase.instance.reference().child('users/${user.uid}');

      userRef.once().then((DataSnapshot snapshot) {
        if (snapshot.value != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, MainPage.id, (route) => false);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(children: <Widget>[
            SizedBox(height: 70),
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset(
                'images/ignite.png',
                width: 110.0,
                height: 110.0,
                fit: BoxFit.fill,
              ),
            ),
            // Image(
            //   alignment: Alignment.center,
            //   height: 100,
            //   width: 100,
            //   image: AssetImage('images/ignite.png'),
            // ),
            SizedBox(height: 40),
            Text(
              'Sign into Ignite',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, fontFamily: 'Brand-Bold'),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(children: <Widget>[
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    labelStyle: TextStyle(
                      fontSize: 14,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      fontSize: 14,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(
                  height: 40,
                ),
                TaxiButton(
                  title: 'LOGIN',
                  color: Colors.green[700],
                  onPressed: () async {
                    var connectivityResult =
                        await Connectivity().checkConnectivity();
                    if (connectivityResult != ConnectivityResult.mobile &&
                        connectivityResult != ConnectivityResult.wifi) {
                      showSnackBar('No Internet Connection');
                      return;
                    }

                    if (!emailController.text.contains('@')) {
                      showSnackBar('Please enter a valid email address');
                      return;
                    }

                    if (passwordController.text.length < 8) {
                      showSnackBar('Please enter a valid password');
                      return;
                    }
                    login();
                  },
                ),
              ]),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, RegistrationPage.id, (route) => false);
              },
              child: Text('Register Here'),
            ),
          ]),
        ))));
  }
}
