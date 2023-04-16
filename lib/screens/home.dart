import 'package:ecommerce/screens/all_category.dart';
import 'package:ecommerce/screens/cart_screen.dart';
import 'package:ecommerce/screens/product_detail.dart';
import 'package:ecommerce/services/apiServices.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AllCategory();
                }));
              },
              icon: Icon(Icons.view_list)),
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CartScreen();
                }));
              },
              icon: Icon(Icons.shopping_cart)),
        ],
      ),
      body: FutureBuilder(
        future: ApiService().getAllPosts(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: ListView.builder(
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
                  }),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
