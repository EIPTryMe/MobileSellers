import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  double borderRadius = 12.0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double oneFifth = height / 5;

    return Column(
      children: [
        Stack(
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Container(
                  height: oneFifth,
                  color: Colors.grey[100],
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.assignment,
                            size: height / 8,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Toutes les commandes",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.white10,
                    onTap: () => Navigator.pushNamed(context, ""),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: (oneFifth) / 6),
        Stack(
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Container(
                  height: oneFifth,
                  color: Colors.grey[100],
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.assignment_late,
                            size: height / 8,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Commandes reçues",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.white10,
                    onTap: () => Navigator.pushNamed(context, ""),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: (oneFifth) / 6),
        Stack(
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Container(
                  height: oneFifth,
                  color: Colors.grey[100],
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.send,
                            size: height / 8,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Commandes expédiées",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.white10,
                    onTap: () => Navigator.pushNamed(context, ""),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: (oneFifth) / 6),
        Stack(
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Container(
                  height: oneFifth,
                  color: Colors.grey[100],
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.assignment_turned_in,
                            size: height / 8,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Commandes livrées",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.white10,
                    onTap: () => Navigator.pushNamed(context, ""),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

//class Orders extends StatefulWidget {
//  @override
//  _OrdersState createState() => _OrdersState();
//}
//
//class _OrdersState extends State<Orders> {
//  List<Order> orders = List();
//
//  void getData() async {
//    Request.getOrders(company.id).then((value) => setState(() {
//          orders = value;
//        }));
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    getData();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return ListView(
//      padding: EdgeInsets.only(top: 0.0),
//      children: orders
//          .map((order) => Padding(
//                padding: const EdgeInsets.all(2.0),
//                child: OrderCard(order: order),
//              ))
//          .toList(),
//    );
//  }
//}
