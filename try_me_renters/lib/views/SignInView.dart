import 'package:flutter/material.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Sign IN"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          RaisedButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, 'home', ModalRoute.withName('/'));
            },
            color: Colors.black,
            child: Text(
              "Se connecter",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}