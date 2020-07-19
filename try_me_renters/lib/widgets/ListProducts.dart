import 'package:flutter/material.dart';

import 'package:trymerenters/Globals.dart';
import 'package:trymerenters/widgets/ProductCard.dart';

class ListProducts extends StatefulWidget {
  @override
  _ListProductsState createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  List<Product> products = [
    Product(name: "iPhone", pricePerMonth: 50),
    Product(name: "Table", pricePerMonth: 26),
    Product(name: "Lapin", pricePerMonth: 2),
    Product(name: "Oui", pricePerMonth: 43),
    Product(name: "iPhone", pricePerMonth: 50),
    Product(name: "Table", pricePerMonth: 26),
    Product(name: "Lapin", pricePerMonth: 2),
    Product(name: "Oui", pricePerMonth: 43)
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 0.0),
      children: products.map((product) => Padding(
        padding: const EdgeInsets.all(2.0),
        child: ProductCard(product: product),
      )).toList(),
    );
  }
}
