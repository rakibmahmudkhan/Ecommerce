import 'package:ecommerce/services/apiServices.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  final int id;

  ProductDetail(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Detail"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: FutureBuilder(
        future: ApiService().getSingleProduct(id),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Image.network(
                      snapshot.data["image"],
                      height: 200,
                      width: double.infinity,
                    ),
                    SizedBox(
                      height: 9.0,
                    ),
                    Center(
                      child: Text(
                        "Price -" + snapshot.data["price"].toString(),
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                      child: Text(
                        snapshot.data["title"],
                        style: TextStyle(fontSize: 14.0),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Chip(
                        label: Padding(
                          padding: const EdgeInsets.only(bottom: 3.0),
                          child: Text(
                            snapshot.data['category'].toString(),
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                        backgroundColor: Colors.blueGrey,
                      ),
                    ),
                    SizedBox(
                      height: 19.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                      child: Text(
                        snapshot.data["description"],
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_shopping_cart_outlined),
        onPressed: () async {
          await ApiService().updateCart(1, id);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Product added to cart")));
        },
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
