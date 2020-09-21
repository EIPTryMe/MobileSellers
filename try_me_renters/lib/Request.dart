import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:trymerenters/Globals.dart';
import 'package:trymerenters/GraphQLConfiguration.dart';
import 'package:trymerenters/Queries.dart';

enum OrderBy { PRICE, NEW, NAME }

class Request {
  static Future getUser() async {
    QueryResult result;
    QueryOptions queryOption =
        QueryOptions(documentNode: gql(Queries.user(auth0User.uid)));
    result = await graphQLConfiguration.clientToQuery.query(queryOption);
    QueryParse.getUser(result.data['user'][0]);
  }

  static Future getCompany() async {
    QueryResult result;
    QueryOptions queryOption = QueryOptions(documentNode: gql(Queries.company(user.companyId)));
    result = await graphQLConfiguration.clientToQuery.query(queryOption);
    QueryParse.getCompany(result.data['company'][0]);
  }

  static Future modifyCompany() async {
    QueryResult result;
    QueryOptions queryOption = QueryOptions(
        documentNode: gql(Mutations.modifyCompany(
            company.id,
            company.name != null ? company.name : "",
            company.address != null ? company.address : "",
            company.email != null ? company.email : "",
            company.phoneNumber != null ? company.phoneNumber : "",
            company.siret != null ? company.siret : "",
            company.siren != null ? company.siren : "")));
    result = await graphQLConfiguration.clientToQuery.query(queryOption);
  }

  static Future modifyProduct(Product product) async {
    QueryResult result;
    QueryOptions queryOption = QueryOptions(
        documentNode: gql(Mutations.modifyProduct(
            product.id,
            product.name,
            product.brand,
            product.pricePerMonth,
            product.pricePerWeek,
            product.pricePerDay,
            product.stock,
            product.description.replaceAll('\n', '\\n'))));
    result = await graphQLConfiguration.clientToQuery.query(queryOption);
  }

  static Future getProducts(OrderBy orderBy, bool asc) async {
    List<Product> products = List();
    String sort = '';

    if (orderBy == OrderBy.PRICE)
      sort = 'order_by: {price_per_month: ' +
          (asc ? 'asc' : 'desc') +
          ', name: asc}';
    else if (orderBy == OrderBy.NEW)
      sort = 'order_by: {created_at: ' + (asc ? 'asc' : 'desc') + '}';
    else if (orderBy == OrderBy.NAME)
      sort = 'order_by: {name: ' + (asc ? 'asc' : 'desc') + '}';

    QueryResult result;
    QueryOptions queryOption =
        QueryOptions(documentNode: gql(Queries.productsCompany(company.id, sort)));
    graphQLConfiguration = GraphQLConfiguration();
    result = await graphQLConfiguration.clientToQuery.query(queryOption);
    (result.data['company'][0]['products'] as List).forEach((element) {
      products.add(QueryParse.getProductHome(element));
    });
    return (products);
  }
}
