import 'package:flutter/material.dart';
import '../../base_url.dart';
import '../../models//products_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ProductPage extends StatefulWidget {
  ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<ProductsModel> productList = []; // datanya masih kosong
  String url = "${BaseUrl.BASE_URL}/models/products/products_list.php";

  Future<List<ProductsModel>> getProductsList() async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print (response.body);

        List<ProductsModel> products = parseJson(response.body);
        return products;
      } else {
        throw Exception("Error while getting products...");
      }
    } catch(errorMsg) {
      throw Exception(errorMsg.toString());

    }
  }

  static List<ProductsModel> parseJson(String responseBody) {
    final parsedJson = convert.json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsedJson.map<ProductsModel>((json) => ProductsModel.fromJson(json)).toList();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Container();
  // }

@override
  void initState() {
    super.initState();
    getProductsList().then((objectProducts) {
      setState(() {
        // productList diisi
        productList = objectProducts;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(4),
              child: const TextField(
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: "Search product name",
                  suffixIcon: InkWell(
                    child: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(4),
                itemCount: productList.length,
                itemBuilder: (BuildContext context, int position) {
                  return Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(productList[position].product_name.toString()),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}