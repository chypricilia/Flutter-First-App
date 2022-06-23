import 'package:flutter/material.dart';
import '../../models/products_model.dart';
import '../../base_url.dart';
import 'package:http/http.dart' as http;

class ProductDetail extends StatefulWidget {
  final ProductsModel productsModel;

  ProductDetail({required this.productsModel});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Product ID: ${widget.productsModel.product_id.toString()}"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                "Product name: ${widget.productsModel.product_name.toString()}"),
            Padding(padding: EdgeInsets.all(8)),
            Text(
                "Product price: ${widget.productsModel.product_price.toString()}"),
            Padding(padding: EdgeInsets.all(8)),
            Text("Created at: ${widget.productsModel.created_at.toString()}"),
            Padding(padding: EdgeInsets.all(8)),
          ],
        ),
      ),
    );
  }
}