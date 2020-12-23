import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ignite3/data/appData.dart';
import 'package:ignite3/screens/loginPage.dart';
import 'package:ignite3/screens/registrationPage.dart';
import 'package:provider/provider.dart';

import 'dart:io';

import './screens/mainPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp(
    name: 'db2',
    options: Platform.isIOS
        ? FirebaseOptions(
            appId: '1:724868990884:ios:aa5df65c30ebe7e4252331',
            apiKey: 'AIzaSyCb9rqZLuWx8TPwONErL7fSiXe7qII0jhA',
            projectId: 'ignite3420',
            messagingSenderId: '724868990884',
            databaseURL: 'https://ignite3420-default-rtdb.firebaseio.com',
          )
        : FirebaseOptions(
            appId: '1:724868990884:android:5cc9628fc1146c57252331d',
            apiKey: 'AIzaSyCsQUWYXXhb8_i-bxz4leTcYeQOPB-L6a8',
            messagingSenderId: '724868990884',
            projectId: 'ignite3420',
            databaseURL: 'https://ignite3420-default-rtdb.firebaseio.com',
          ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'Ignite',
        theme: ThemeData(
          fontFamily: 'Brand-Regular',
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: MainPage.id,
        routes: {
          RegistrationPage.id: (context) => RegistrationPage(),
          LoginPage.id: (context) => LoginPage(),
          MainPage.id: (context) => MainPage(),
        },
      ),
    );
  }
}
