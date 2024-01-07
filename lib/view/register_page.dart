import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:use_firebase/view_model/register_view_model.dart';

class RegisterPage extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register Page",
          style: TextStyle(color: Colors.white),
        ),
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
                  height: 30,
                ),
                _buildIcon(),
                SizedBox(
                  height: 30,
                ),
                _buildEmailTextField(),
                SizedBox(
                  height: 20,
                ),
                _buildPasswordTextField(),
                SizedBox(
                  height: 20,
                ),
                _buildPasswordConfirmTextField(),
                SizedBox(
                  height: 20,
                ),
                _buildLoginButton(context),
                SizedBox(
                  height: 20,
                ),
                _buildGoToRegisterPageButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Icon(
      Icons.person,
      size: 120,
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
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

  Widget _buildPasswordTextField() {
    return TextFormField(
      obscureText: true,
      controller: _passwordController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter a password";
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          )),
    );
  }

  Widget _buildPasswordConfirmTextField() {
    return TextFormField(
      obscureText: true,
      controller: _passwordConfirmController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter a password again";
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: "Password Again",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          )),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    RegisterViewModel viewModel =
        Provider.of<RegisterViewModel>(context, listen: false);
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          if (_passwordController.text == _passwordConfirmController.text) {
            viewModel.register(context, _emailController.text.trim(),
                _passwordController.text.trim());
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Passwords do not match"),
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Please fill all the fields"),
            ),
          );
        }
      },
      child: Text(
        "Kayıt Ol",
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
    );
  }

  Widget _buildGoToRegisterPageButton(BuildContext context) {
    RegisterViewModel viewModel = Provider.of(context, listen: false);
    return TextButton(
      onPressed: () {
        viewModel.openLoginPage(context);
      },
      child: Text(
        "Hesabınız var mı? Giriş Yapın",
        style: TextStyle(color: Colors.deepPurple),
      ),
    );
  }
}
