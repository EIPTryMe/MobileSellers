import 'package:flutter/material.dart';

import 'package:trymerenters/Globals.dart';
import 'package:trymerenters/widgets/OrderCard.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order> orders = [
    Order(
        total: 398,
        products: [Product(name: "iPhone", pricePerMonth: 50), Product(name: "Table", pricePerMonth: 26), Product(name: "Lapin", pricePerMonth: 2)]),

  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 0.0),
      children: orders
          .map((order) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: OrderCard(order: order),
              ))
          .toList(),
    );
  }
}
