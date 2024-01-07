import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:use_firebase/view_model/add_new_person_view_model.dart';

class AddNewPersonPage extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  AddNewPersonPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Person Page",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                _buildNameTextField(),
                SizedBox(
                  height: 30,
                ),
                _buildPhoneNumberTextField(),
                SizedBox(
                  height: 30,
                ),
                _buildEmailTextField(),
                SizedBox(
                  height: 30,
                ),
                _buildAddNewPersonButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameTextField() {
    return TextFormField(
      controller: _nameController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter a name";
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: "Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          )),
    );
  }

  Widget _buildPhoneNumberTextField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _phoneNumberController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter a phone number";
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: "Phone Number",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          )),
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter a email";
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          )),
    );
  }

  Widget _buildAddNewPersonButton(BuildContext context) {
    AddNewPersonViewModel viewModel =
        Provider.of<AddNewPersonViewModel>(context, listen: false);
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          viewModel.addNewPerson(
            context,
            _nameController.text.trim(),
            _phoneNumberController.text.trim(),
            _emailController.text.trim(),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Please fill all the fields"),
            ),
          );
        }
      },
      child: Text(
        "Add New Person",
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
    );
  }
}
