import 'package:ecommerce/screens/product_detail.dart';
import 'package:ecommerce/services/apiServices.dart';
import 'package:flutter/material.dart';

class CategoryProductScreen extends StatelessWidget {
  final String categoryName;

  CategoryProductScreen(this.categoryName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName.toUpperCase()),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: ApiService().getProductByCategory(categoryName),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data[index]["title"]),
                    subtitle: Text(
                        "Price- " + snapshot.data[index]["price"].toString()),
                    leading: Image.network(
                      snapshot.data[index]["image"],
                      height: 50,
                      width: 50,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetail(snapshot.data[index]["id"])));
                    },
                  );
                });

          }
          return Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}
