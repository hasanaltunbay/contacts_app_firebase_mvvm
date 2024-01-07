import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:use_firebase/model/person.dart';
import 'package:use_firebase/view_model/main_view_model.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    MainViewModel viewModel =
        Provider.of<MainViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contacts",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
              onPressed: () {
                viewModel.logOut(context);
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              )),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          viewModel.openAddNewPersonPage(context);
        },
      ),
    );
  }

  Widget _buildBody() {
    return Consumer<MainViewModel>(
      builder: (context, viewModel, child) => ListView.builder(
        itemCount: viewModel.persons.length,
        itemBuilder: (BuildContext context, int index) {
          final contact = viewModel.persons[index];
          final contactId = contact.id;
          Person person =
              Person(contact.name, contact.phoneNumber, contact.email);
          return ListTile(
            title: Text(
              contact.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: (Text(
              "${contact.phoneNumber} \n${contact.email}",
              style: TextStyle(fontSize: 15),
            )),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    viewModel.deleteContactItem(contactId!, context);
                  },
                  icon: Icon(Icons.delete),
                ),
                IconButton(
                  onPressed: () {
                    viewModel.editPerson(context, person, contactId!);
                  },
                  icon: Icon(Icons.edit),
                ),
              ],
            ),
            leading: CircleAvatar(
              child: Text(contact.name[0].toUpperCase()),
            ),
          );
        },
      ),
    );
  }
}
