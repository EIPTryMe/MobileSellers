import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:trymerenters/Globals.dart';
import 'package:trymerenters/Queries.dart';
import 'package:trymerenters/Request.dart';

class ProductEditView extends StatefulWidget {
  ProductEditView({this.id});

  final String id;

  @override
  _ProductEditViewState createState() => _ProductEditViewState();
}

class _ProductEditViewState extends State<ProductEditView> {
  bool gotData = false;
  Product product = Product();
  TextEditingController titleController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController monthPriceController = TextEditingController();
  TextEditingController weekPriceController = TextEditingController();
  TextEditingController dayPriceController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController specificationsController = TextEditingController();

  Future saveInfo() async {
    product.name = titleController.text;
    product.brand = brandController.text;
    product.pricePerMonth = monthPriceController.text != null
        ? double.parse(monthPriceController.text)
        : 0.0;
    product.pricePerWeek = weekPriceController.text != null
        ? double.parse(weekPriceController.text)
        : 0.0;
    product.pricePerDay = dayPriceController.text != null
        ? double.parse(dayPriceController.text)
        : 0.0;
    product.stock =
        stockController.text != null ? int.parse(stockController.text) : 0.0;
    product.description = descriptionController.text;
    product.specifications = specificationsController.text.split('\n');
    await Request.deleteProductSpecifications(product.id);
    for (int i = 0; i < product.specifications.length; ++i) {
      await Request.insertProductSpecification(
          product.id, product.specifications[i]);
    }
    await Request.modifyProduct(product);
  }

  Future getData() async {
    QueryResult result;
    QueryOptions queryOption =
        QueryOptions(documentNode: gql(Queries.product(int.parse(widget.id))));
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
      titleController.text = product.name;
      brandController.text = product.brand;
      dayPriceController.text = product.pricePerDay.toString();
      weekPriceController.text = product.pricePerWeek.toString();
      monthPriceController.text = product.pricePerMonth.toString();
      stockController.text = product.stock.toString();
      descriptionController.text = product.description;
      for (int i = 0; i < product.specifications.length; ++i) {
        specificationsController.text += product.specifications[i]['name'];
        if (i + 1 < product.specifications.length)
          specificationsController.text += '\n';
      }
      gotData = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Édition produit'),
        centerTitle: true,
        backgroundColor: Color(0xff1F2C47),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Titre'),
                    controller: titleController,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Marque'),
                    controller: brandController,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Prix/Mois'),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp("[0-9.]"))
                    ],
                    controller: monthPriceController,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Prix/Semaine'),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
                    ],
                    controller: weekPriceController,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Prix/Jour'),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
                    ],
                    controller: dayPriceController,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Stock'),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: false),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                    ],
                    controller: stockController,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Description'),
                    maxLines: null,
                    controller: descriptionController,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Spécifications'),
                    maxLines: null,
                    controller: specificationsController,
                  ),
                ],
              ),
            ),
          ),
          if (gotData)
            Expanded(
              flex: 1,
              child: FlatButton(
                color: Color(0xff58c24c),
                onPressed: () => saveInfo().whenComplete(() =>
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'home', ModalRoute.withName('/'))),
                child: Text('Sauvegarder'),
              ),
            ),
        ],
      ),
    );
  }
}
