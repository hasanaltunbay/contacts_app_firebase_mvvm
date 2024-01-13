import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:use_firebase/model/person.dart';
import 'package:use_firebase/view/add_new_person_page.dart';
import 'package:use_firebase/view/edit_person_page.dart';
import 'package:use_firebase/view_model/add_new_person_view_model.dart';
import 'package:use_firebase/view_model/edit_person_view_model.dart';

import '../view/login_page.dart';
import 'login_view_model.dart';

class MainViewModel with ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseAuth _auth = FirebaseAuth.instance;

  List<Person> _persons = [];

  List<Person> get persons => _persons;

  MainViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getPersons();
    });
  }

  void _getPersons() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection("persons").get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
        in snapshot.docs) {
      Person person = Person.fromMap(
        documentSnapshot.id,
        documentSnapshot.data(),
      );
      _persons.add(person);
    }
    notifyListeners();
  }

  void openAddNewPersonPage(BuildContext context) {
    MaterialPageRoute pageRoute = MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
              create: (context) => AddNewPersonViewModel(),
              child: AddNewPersonPage(),
            ));
    Navigator.push(context, pageRoute).then((value) {
      _persons.clear();
      _getPersons();
    });
  }

  void openLoginPage(BuildContext context) {
    MaterialPageRoute pageRoute = MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
              create: (context) => LoginViewModel(),
              child: LoginPage(),
            ));
    Navigator.pushReplacement(context, pageRoute);
  }

  void logOut(BuildContext context) async {
    await _auth.signOut();
    openLoginPage(context);
  }

  void deleteContactItem(String id, BuildContext context) async {
    await _firestore.collection("persons").doc(id).delete();
    _persons.clear();
    _getPersons();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Contact deleted"),
      ),
    );
  }

  void editPerson(
    BuildContext context,
    Person person,
    String id,
  ) {
    MaterialPageRoute pageRoute = MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
              create: (context) => EditPersonViewModel(),
              child: EditPersonPage(
                person: person,
                id: id,
              ),
            ));
    Navigator.push(context, pageRoute).then((value) {
      _persons.clear();
      _getPersons();
    });
  }
}
