import 'dart:async';

import 'package:flutter/material.dart';
import '../../base_url.dart';
import '../../models/products_model.dart';
import 'product_detail.dart';
import 'product_create.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class Debouncer {
  int? milliseconds;
  VoidCallback? action;
  Timer? timer;

  run(VoidCallback action) {
    if(null != timer) {
      timer!.cancel();
    }

    timer = Timer(
      const Duration (milliseconds:Duration.millisecondsPerSecond),
      action,
    );
  }
}

class _ProductPageState extends State<ProductPage> {
  // text style
  static const TextStyle appBarStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle productNameStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(70, 132, 153, 1),
  );

  static const TextStyle productPriceStyle = TextStyle(
    fontSize: 14,
    color: Color.fromRGBO(70, 132, 153, 1),
  );

  final debouncer = Debouncer();
  List<ProductsModel> prodList = [];
  List<ProductsModel> productList = []; // datanya masih kosong

  String url = "${BaseUrl.BASE_URL}/models/products/products_list.php";

  Future<List<ProductsModel>> getProductsList() async {
    try {
      final response = await http.get(Uri.parse(url));
      // cek jika response berhasil
      if (response.statusCode == 200) {
        // print("DATA JSON: " + response.body); // cek isi data json
        List<ProductsModel> products = parseJson(response.body);
        return products;
      } else {
        // jika response gagal
        throw Exception("Error while getting products...");
      }
    } catch (errorMsg) {
      throw Exception(errorMsg.toString());
    }
  }

  static List<ProductsModel> parseJson(String responseBody) {
    final parsedJson =
        convert.json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsedJson
        .map<ProductsModel>((json) => ProductsModel.fromJson(json))
        .toList();
  }

  // ketika ProductPage terbuka, maka otomatis initState dijalankan
  @override
  void initState() {
    super.initState();
    getProductsList().then((objectProducts) {
      setState(() {
        // productList diisi
        // productList = objectProducts;
          prodList = objectProducts; // hasil pencarian productlist
          productList = prodList; // ditimpa ke productList
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Page',
          style: appBarStyle,
        ),
        backgroundColor: const Color.fromRGBO(70, 132, 153, 1),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              child: TextField(
                textInputAction: TextInputAction.search,
                decoration: const InputDecoration(
                  hintText: "Search product name",
                  suffixIcon: InkWell(
                    child: Icon(Icons.search),
                  ),
                ),
                onChanged: (keyword) {
                  debouncer.run(() {
                    setState(() {
                      productList = prodList.where((product) => (product.product_name.toLowerCase().contains(keyword.toLowerCase()))).toList();
                    });
                  });
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: productList.length,
                itemBuilder: (BuildContext context, int position) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          ListTile(
                            leading: const Icon(Icons.list),
                            title: Text(
                              productList[position].product_name.toString(),
                              style: productNameStyle,
                            ),
                            subtitle: Text(
                              "IDR ${productList[position].product_price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},")}",
                              style: productPriceStyle,
                            ),
                            onTap: () {
                                // membuka detail produk
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetail(
                                      productsModel: productList[position],
                                    ),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // membuka form tambah produk baru
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductCreate(),
            ),
          );
        },
        backgroundColor: Color.fromRGBO(70, 132, 153, 1),
        child: Icon(Icons.add),
      ),
    );
  }
}