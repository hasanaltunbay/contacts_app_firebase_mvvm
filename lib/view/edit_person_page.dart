import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:use_firebase/view_model/edit_person_view_model.dart';

import '../model/person.dart';

class EditPersonPage extends StatefulWidget {
  final Person person;
  final String id;

  EditPersonPage({super.key, required this.person, required this.id});

  @override
  State<EditPersonPage> createState() => _EditPersonPageState();
}

class _EditPersonPageState extends State<EditPersonPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.person.name;
    _phoneNumberController.text = widget.person.phoneNumber;
    _emailController.text = widget.person.email;
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Person Page",
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
                _buildEditPersonButton(context),
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

  Widget _buildEditPersonButton(BuildContext context) {
    EditPersonViewModel viewModel =
        Provider.of<EditPersonViewModel>(context, listen: false);
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          viewModel.editPerson(
            context,
            widget.id,
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
        "Update Person",
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
    );
  }
}
