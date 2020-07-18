import 'package:flutter/material.dart';

import 'package:fluro/fluro.dart';

import 'package:trymerenters/views/HomeView.dart';
import 'package:trymerenters/views/SignInView.dart';

class FluroRouter {
  static Router router = Router();
  static Handler _homeHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => HomeView());
  static Handler _signInHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => SignInView());


  static void setupRouter() {
    router.define(
      'home',
      handler: _homeHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      'signIn',
      handler: _signInHandler,
      transitionType: TransitionType.cupertino,
    );
  }
}