import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:trymerenters/Globals.dart';
import 'package:trymerenters/GraphQLConfiguration.dart';
import 'package:trymerenters/Queries.dart';

class ProductView extends StatefulWidget {
  ProductView({this.id});

  final String id;

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  Product product = Product();
  bool gotData = false;

  Future getData() async {
    QueryResult result;
    QueryOptions queryOption =
        QueryOptions(documentNode: gql(Queries.product(int.parse(widget.id))));
    graphQLConfiguration = GraphQLConfiguration();
    result = await graphQLConfiguration.clientToQuery.query(queryOption);
    if (this.mounted) {
      setState(() {
        product = QueryParse.getProduct(result.data['product'][0]);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData().whenComplete(() {
      if (this.mounted)
        setState(() {
          gotData = true;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1F2C47),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.pushNamed(context, 'productEdit/${this.widget.id}'),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 12,
            child: ListView(
              children: <Widget>[
                Container(
                  color: Colors.grey[300],
                  height: 400,
                  child: product.pictures == null
                      ? null
                      : Builder(builder: (context) {
                          double width = MediaQuery.of(context).size.width;
                          double height = MediaQuery.of(context).size.height;
                          return CarouselSlider(
                            items: product.pictures == null
                                ? null
                                : product.pictures
                                    .asMap()
                                    .map((i, item) => MapEntry(
                                          i,
                                          GestureDetector(
                                            onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CarouselFullscreen(
                                                            images: product
                                                                .pictures,
                                                            current: i))),
                                            child: Image.network(
                                              item,
                                              fit: BoxFit.cover,
                                              width: width,
                                            ),
                                          ),
                                        ))
                                    .values
                                    .toList(),
                            options: CarouselOptions(
                                height: height, viewportFraction: 1.0),
                          );
                        }),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        product.name == null ? '' : product.name,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        product.brand == null ? '' : product.brand,
                        style: TextStyle(fontSize: 14.0),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      /*Text(
                        product.pricePerDay == null ? '' : product.pricePerDay.toString() + '€/Jour',
                        style: TextStyle(color: Colors.green, fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        product.pricePerWeek == null ? '' : product.pricePerWeek.toString() + '€/Semaine',
                        style: TextStyle(color: Colors.green, fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),*/
                      Text(
                        product.pricePerMonth == null
                            ? ''
                            : product.pricePerMonth.toString() + '€/Mois',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      if (product.description != null)
                        Text(product.description),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Spécification',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      if (product.specifications != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: product.specifications
                              .map((value) => Text(value['name']))
                              .toList(),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CarouselFullscreen extends StatelessWidget {
  CarouselFullscreen({this.images, this.current});

  final List images;
  final int current;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Builder(builder: (context) {
          return CarouselSlider(
            items: images
                .map((item) => GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Image.network(
                        item,
                        height: height,
                      ),
                    ))
                .toList(),
            options: CarouselOptions(
                height: height, viewportFraction: 1.0, initialPage: current),
          );
        }),
      ),
    );
  }
}
