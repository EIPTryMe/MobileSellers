library my_prj.globals;

import 'package:trymerenters/GraphQLConfiguration.dart';


class Renter {
  Renter({this.id, this.name, this.email, this.phoneNumber, this.address, this.siret, this.siren});

  int id;
  String name;
  String email;
  String phoneNumber;
  String address;
  String siret;
  String siren;
}


Renter renter = Renter();


GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();