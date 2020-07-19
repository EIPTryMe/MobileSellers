import 'package:flutter/material.dart';

import 'package:trymerenters/Auth0API.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();
  FocusNode myFocusNodeId = new FocusNode();
  FocusNode myFocusNodePassword = new FocusNode();
  var _email;
  var _password;
  String error = '';

  Widget _entryFieldEmail(String title) {
    return Container(
      padding: const EdgeInsets.only(left: 50.0, right: 50.0),
      child: Form(
        key: _formKeyEmail,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              focusNode: myFocusNodeId,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xff1f2c76), width: 2.0)),
                  labelText: title,
                  labelStyle: TextStyle(color: myFocusNodeId.hasFocus ? Color(0xfffca311) : Colors.grey[800])),
              validator: (value) {
                if (value.isEmpty) {
                  return "Vous n\'avez pas rentré votre email";
                }
                _email = value;
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _entryFieldPassword(String title) {
    return Container(
      padding: const EdgeInsets.only(left: 50.0, right: 50.0),
      child: Form(
        key: _formKeyPassword,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              focusNode: myFocusNodePassword,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xff1f2c76), width: 2.0)),
                  labelText: title,
                  labelStyle: TextStyle(color: myFocusNodePassword.hasFocus ? Color(0xfffca311) : Colors.grey[800])),
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
          ],
        ),
      ),
    );
  }

  Widget _createAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Pas encore inscrit ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(context, 'signUp'),
            child: Text(
              'Inscrivez-vous',
              style: TextStyle(color: Color(0xffFCA311), fontSize: 13, fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget _submitButton() {
    return ButtonTheme(
      minWidth: 200.0,
      height: 50.0,
      child: RaisedButton(
        onPressed: () {
          if (_formKeyEmail.currentState.validate() && _formKeyPassword.currentState.validate()) {
            Navigator.pushNamedAndRemoveUntil(context, 'home', ModalRoute.withName('/'));
            /*Auth0API.login(_email, _password).then((isConnected) {
                  if (isConnected) {
                    Request.getUser().whenComplete(() {
                      if (user.companyId == null) {
                        Navigator.pushNamedAndRemoveUntil(context, 'home', ModalRoute.withName('/'));
                      } else {
                        setState(() {
                          error = 'Connectez-vous en tant qu\'entreprise';
                        });
                      }
                    });
                  } else {
                    setState(() {
                      error = 'Email ou mot de passe invalide';
                    });
                  }
                });*/
          }
        },
        color: Color(0xffFCA311),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Text(
          "Se connecter",
          style: TextStyle(
            color: Colors.white,
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
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: heightScreen / 5,
          ),
          _iDPasswordWidget(),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                child: Text(
                  error,
                  style: TextStyle(color: Colors.red),
                ),
              )),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 50,
          ),
          _submitButton(),
          SizedBox(
            height: widthScreen / 2.2,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _createAccountLabel(),
          ),
        ],
      ),
    )));
  }
}
