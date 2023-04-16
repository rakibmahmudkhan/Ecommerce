import 'package:ecommerce/screens/category_product.dart';
import 'package:ecommerce/services/apiServices.dart';
import 'package:flutter/material.dart';

class AllCategory extends StatelessWidget {
  const AllCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: FutureBuilder(
        future: ApiService().getAllCategory(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (contrext){
                      return CategoryProductScreen(snapshot.data[index]);
                    }));
                  } ,
                  child: Card(
                    elevation: 2.0,
                    margin: EdgeInsets.all(5.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        snapshot.data[index].toString().toUpperCase(),
                        style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                );
              },
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
