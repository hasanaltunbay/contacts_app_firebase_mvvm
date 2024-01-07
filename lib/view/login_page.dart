import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:use_firebase/view_model/login_view_model.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login Page",
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
                  height: 50,
                ),
                _buildIcon(),
                SizedBox(
                  height: 50,
                ),
                _buildEmailTextField(),
                SizedBox(
                  height: 20,
                ),
                _buildPasswordTextField(),
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
      Icons.lock,
      size: 120,
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter a name";
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

  Widget _buildLoginButton(BuildContext context) {
    LoginViewModel viewModel =
        Provider.of<LoginViewModel>(context, listen: false);
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          viewModel.login(
            context,
            _emailController.text.trim(),
            _passwordController.text.trim(),
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
        "Giriş Yap",
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
    );
  }

  Widget _buildGoToRegisterPageButton(BuildContext context) {
    LoginViewModel viewModel = Provider.of(context, listen: false);
    return TextButton(
      onPressed: () {
        viewModel.openRegisterPage(context);
      },
      child: Text(
        "Hesabınız yok mu? Hesap oluşturun",
        style: TextStyle(color: Colors.deepPurple),
      ),
    );
  }
}
