library my_prj.globals;

import 'package:trymerenters/GraphQLConfiguration.dart';

class Auth0User {
  Auth0User(
      {this.uid,
      this.username,
      this.picture,
      this.email,
      this.isEmailVerified});

  String uid;
  String username;
  String picture;
  String email;
  bool isEmailVerified = false;
  bool webLogged = false;
}

class User {
  User({this.companyId});

  int companyId;
}

class Company {
  Company(
      {this.id,
      this.name,
      this.email,
      this.phoneNumber,
      this.address,
      this.siret,
      this.siren,
      this.pathToAvatar});

  int id;
  String name;
  String email;
  String phoneNumber;
  String address;
  String siret;
  String siren;
  String pathToAvatar;
}

class Product {
  Product(
      {this.id,
      this.name,
      this.brand,
      this.pricePerDay,
      this.pricePerWeek,
      this.pricePerMonth,
      this.stock,
      this.description,
      this.specifications,
      this.pictures});

  int id;
  String name;
  String brand;
  double pricePerDay;
  double pricePerWeek;
  double pricePerMonth;
  int stock;
  String description;
  List specifications;
  List pictures;
}

class Order {
  Order({this.id, this.total, this.status, this.products});

  int id;
  double total;
  String status;
  List<Product> products;
}

Auth0User auth0User = Auth0User();

User user = User();
Company company = Company();

GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
