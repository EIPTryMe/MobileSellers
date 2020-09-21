import 'package:flutter/material.dart';

import 'package:trymerenters/widgets/OrderCard.dart';

import 'package:trymerenters/Globals.dart';
import 'package:trymerenters/Request.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order> orders = List();

  void getData() async {
    Request.getOrders(company.id).then((value) => setState(() {
          orders = value;
        }));
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

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
/*
 query MyQuery {
  order_item(where: {product: {company_id: {_eq: 43}}}, order_by: {created_at: desc}) {
    product {
      id
      name
      price_per_month
      picture {
        url
      }
    }
  }
}
*/
