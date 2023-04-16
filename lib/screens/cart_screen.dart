import 'package:ecommerce/services/apiServices.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: FutureBuilder(
        future: ApiService().getCart("1"),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List products = snapshot.data['products'];
            return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return FutureBuilder(
                    future: ApiService()
                        .getSingleProduct(products[index]["productId"]),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListTile(
                          title: Text(snapshot.data['title']),
                          leading: Image.network(
                            snapshot.data['image'],
                            height: 40,
                          ),
                          subtitle: Text("Quantity -" +
                              products[index]['quantity'].toString()),
                          trailing: IconButton(onPressed: () async {
                            await ApiService().deleteCart("1");
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Item Deleted successfully" ),
                              backgroundColor: Colors.amberAccent,
                            ));

                          },
                            icon: Icon(
                              Icons.delete_forever, color: Colors.red,),),
                        );
                      }
                      return LinearProgressIndicator();
                    },
                  );
                });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 60,
        width: double.infinity,
        color: Colors.tealAccent,
        child: Center(child: Text("Order Now", style: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 25.0, color: Colors.white
        ),),),
      ),
    );
  }
}
