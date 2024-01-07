import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditPersonViewModel with ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void editPerson(
    BuildContext context,
    String id,
    String name,
    String phoneNumber,
    String email,
  ) async {
    await _firestore.collection("persons").doc(id).update({
      "email": email,
      "name": name,
      "phoneNumber": phoneNumber,
    });

    Navigator.pop(context);
  }
}
