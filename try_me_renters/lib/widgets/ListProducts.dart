import 'package:flutter/material.dart';

import 'package:trymerenters/widgets/Filter.dart';
import 'package:trymerenters/widgets/ProductCard.dart';

import 'package:trymerenters/Globals.dart';
import 'package:trymerenters/Request.dart';

class ListProducts extends StatefulWidget {
  @override
  _ListProductsState createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  List<Product> products = List();

  void callback(String option) {
    getData(option);
  }

  void getData([String option]) async {
    OrderBy orderBy;
    bool asc;
    if (option == 'Nom A-Z' || option == null) {
      orderBy = OrderBy.NAME;
      asc = true;
    } else if (option == 'Nom Z-A') {
      orderBy = OrderBy.NAME;
      asc = false;
    } else if (option == 'Prix croissant') {
      orderBy = OrderBy.PRICE;
      asc = true;
    } else if (option == 'Prix décroissant') {
      orderBy = OrderBy.PRICE;
      asc = false;
    } else if (option == 'Nouveautés') {
      orderBy = OrderBy.NEW;
      asc = false;
    }
    Request.getProducts(orderBy, asc).then((products) {
      if (this.mounted)
        setState(() {
          this.products = products;
        });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 1,
          child: Filter(callback),
        ),
        Expanded(
          flex: 15,
          child: ListView(
            children: products
                .map((product) =>
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                  child: ProductCard(
                    product: product,
                  ),
                ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
