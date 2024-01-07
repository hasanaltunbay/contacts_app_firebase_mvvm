import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/person.dart';

class AddNewPersonViewModel with ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void addNewPerson(
    BuildContext context,
    String name,
    String phoneNumber,
    String email,
  ) async {
    Person person = Person(name, phoneNumber, email);
    await _firestore.collection("persons").doc().set(person.toMap());

    Navigator.pop(context);
  }
}
