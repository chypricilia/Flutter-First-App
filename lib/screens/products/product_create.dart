import 'package:flutter/material.dart';
import '../../base_url.dart';
import '../../forms/form_page.dart';
import 'package:http/http.dart' as http;

class ProductCreate extends StatefulWidget {
  ProductCreate({Key? key}) : super(key: key);

  @override
  State<ProductCreate> createState() => _ProductCreateState();
}

class _ProductCreateState extends State<ProductCreate> {
  final formKey = GlobalKey<FormState>();

  TextEditingController productNameCtrl = TextEditingController();
  TextEditingController productPriceCtrl = TextEditingController();

  Future createProduct() async {
    final url = "${BaseUrl.BASE_URL}/models/products/product_create.php";

    return await http.post(Uri.parse(url), body: {
      "product_name" : productNameCtrl.text,
      "product_price" : productPriceCtrl.text,
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Create")
      ),
      body: Center(child: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(8),
        child: FormPage(
          formKey: formKey,
          productNameCtrl: productNameCtrl,
          productPriceCtrl: productPriceCtrl,
        ), 
        )
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: (){
            if (formKey.currentState!.validate()) {
              onCreateProduct(context);
            }
          },
          child: const Text("Save"),
        )
      ),
    );
  }

  void onCreateProduct(context) async {
    await createProduct();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }
}