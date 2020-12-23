import 'package:firebase_database/firebase_database.dart';

class Account {
  String fullName;
  String email;
  String phone;
  String id;

  Account({this.fullName, this.email, this.phone, this.id});

  Account.fromSnapshot(DataSnapshot snapshot) {
    id = snapshot.key;
    phone = snapshot.value['phone'];
    email = snapshot.value['email'];
    fullName = snapshot.value['fullname'];
  }
}
