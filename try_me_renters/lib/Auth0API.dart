import 'package:flutter_auth0/flutter_auth0.dart';

import 'package:trymerenters/Globals.dart' as global;

class Auth0API {
  static String domain = 'dev-2o6a8byc.eu.auth0.com';
  static String clientId = 'YIfBoxMsxuVG6iTGNlxX3g7lvecyzrVQ';

  static Auth0 auth0 = Auth0(baseUrl: 'https://$domain/', clientId: clientId);

  static Future<bool> login(String email, String password) async {
    global.auth0User = global.Auth0User();
    global.renter = global.Renter();
    try {
      var response = await auth0.auth.passwordRealm({'username': email, 'password': password, 'realm': 'Username-Password-Authentication'});

      print('''
    \nAccess Token: ${response['access_token']}
    ''');

      return (await userInfo(response['access_token']));
    } catch (e) {
      print(e);
      return (false);
    }
  }

  static Future<bool> userInfo(String bearer) async {
    try {
      var authClient = Auth0Auth(auth0.auth.clientId, auth0.auth.client.baseUrl, bearer: bearer);
      var info = await authClient.getUserInfo();

      global.auth0User.uid = info['sub'];
      global.auth0User.username = info['nickname'];
      global.auth0User.picture = info['picture'];
      global.auth0User.email = info['email'];
      global.auth0User.isEmailVerified = info['email_verified'];

      String buffer = '';
      info.forEach((k, v) => buffer = '$buffer\n$k: $v');
      print(buffer);

      return (true);
    } catch (e) {
      print(e);
      return (false);
    }
  }
}
