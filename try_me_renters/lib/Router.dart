import 'package:flutter/material.dart';

import 'package:fluro/fluro.dart';

import 'package:trymerenters/views/HomeView.dart';
import 'package:trymerenters/views/OrdersView.dart';
import 'package:trymerenters/views/ProductEditView.dart';
import 'package:trymerenters/views/ProductView.dart';
import 'package:trymerenters/views/SignInView.dart';

class FluroRouter {
  static Router router = Router();
  static Handler _homeHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => HomeView());
  static Handler _orderHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => OrdersView(status: params['status'][0]));
  static Handler _productEditHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => ProductEditView(id: params['id'][0]));
  static Handler _productHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => ProductView(id: params['id'][0]));
  static Handler _signInHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => SignInView());

  static void setupRouter() {
    router.define(
      'home',
      handler: _homeHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      'order/:status',
      handler: _orderHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      'productEdit/:id',
      handler: _productEditHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      'product/:id',
      handler: _productHandler,
      transitionType: TransitionType.cupertinoFullScreenDialog,
    );
    router.define(
      'signIn',
      handler: _signInHandler,
      transitionType: TransitionType.cupertino,
    );
  }
}