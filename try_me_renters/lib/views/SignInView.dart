import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:trymerenters/Auth0API.dart';
import 'package:trymerenters/Globals.dart';
import 'package:trymerenters/Request.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();
  var _email;
  var _password;
  String error = '';

  Widget _entryFieldEmail(String title) {
    return Container(
      child: Form(
        key: _formKeyEmail,
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xff1f2c76), width: 2.0)),
            labelText: title,
          ),
          validator: (value) {
            if (value.isEmpty) {
              return "Vous n\'avez pas rentré votre email";
            }
            _email = value;
            return null;
          },
        ),
      ),
    );
  }

  Widget _entryFieldPassword(String title) {
    return Container(
      child: Form(
        key: _formKeyPassword,
        child: TextFormField(
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xff1f2c76), width: 2.0)),
            labelText: title,
          ),
          keyboardType: TextInputType.text,
          obscureText: true,
          validator: (value) {
            if (value.isEmpty) {
              return "Vous n\'avez pas rentré votre mot de passe";
            }
            _password = value;
            return null;
          },
        ),
      ),
    );
  }

  Widget _submitButton() {
    return ButtonTheme(
      height: 50.0,
      child: RaisedButton(
        onPressed: () {
          if (_formKeyEmail.currentState.validate() &&
              _formKeyPassword.currentState.validate()) {
            Auth0API.login(_email, _password).then((isConnected) {
              if (isConnected) {
                Request.getUser().whenComplete(() {
                  if (user.companyId != null) {
                    Request.getCompany().whenComplete(() {
                      Navigator.pushNamedAndRemoveUntil(
                          context, 'home', ModalRoute.withName('/'));
                    });
                  } else {
                    setState(() {
                      error = 'Connectez-vous avec un compte entreprise';
                    });
                  }
                });
              } else {
                setState(() {
                  error = 'Email ou mot de passe invalide';
                });
              }
            });
          }
        },
        color: Color(0xffFCA311),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Text(
          "Se connecter",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        padding: const EdgeInsets.all(0.0),
      ),
    );
  }

  Widget _iDPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryFieldEmail("Email"),
        SizedBox(height: 20.0),
        _entryFieldPassword("Mot de Passe"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _iDPasswordWidget(),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        error,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    _submitButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
