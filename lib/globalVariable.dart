import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ignite3/data/models/account.dart';

String mapKey = 'AIzaSyBvjFjaCUcaeHq6De2hAG9wSZvw4dIipN0';

final CameraPosition googlePlex =
    CameraPosition(target: LatLng(39.765030, -105.032480), zoom: 14.4746);

// ignore: deprecated_member_use
User currentFirebaseUser;

Account currentUserInfo;
