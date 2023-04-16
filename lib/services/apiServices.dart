import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  Future getAllPosts() async {
    final allProductUrl = Uri.parse("https://fakestoreapi.com/products");
    final response = await http.get(allProductUrl);
    return json.decode(response.body);
  }

  Future getSingleProduct(int id) async {
    final singleProductUrl = Uri.parse("https://fakestoreapi.com/products/$id");
    final response = await http.get(singleProductUrl);
    return json.decode(response.body);
  }

  Future getAllCategory() async {
    final allCategoryUrl =
        Uri.parse("https://fakestoreapi.com/products/categories");
    final response = await http.get(allCategoryUrl);
    return json.decode(response.body);
  }

  Future getProductByCategory(String catName) async {
    final fetchProductCategoryUrl =
        Uri.parse("https://fakestoreapi.com/products/category/$catName");
    final response = await http.get(fetchProductCategoryUrl);
    return json.decode(response.body);
  }

  Future getCart(String userId) async {
    final fetchCartProducts =
        Uri.parse("https://fakestoreapi.com/carts/$userId");
    final response = await http.get(fetchCartProducts);
    return json.decode(response.body);
  }

  //POST request
  Future userLogin(String username, String password) async {
    final loginUrl = Uri.parse("https://fakestoreapi.com/auth/login");
    final response = await http.post(loginUrl, body: {
      "username": username,
      "password": password,
    });
    print(response.body);
    print(response.statusCode);
    return json.decode(response.body);
  }

//put request
  Future updateCart(int userId, int productId) async {
    final updateCartUrl = Uri.parse("'https://fakestoreapi.com/carts/userId");
    final response = await http.put(updateCartUrl, body: {
      "userId": "$userId",
      "date": DateTime.now().toString(),
      "products": [
        {"productId": "$productId", "quality": "1"}
      ].toString()
    });
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

// DELETE Request
  Future deleteCart(String userId) async {
    final deleteCartUrl = Uri.parse("https://fakestoreapi.com/carts/$userId");
    final response = await http.delete(deleteCartUrl);
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }
//user authentication
  Future userAuthentication(String username, String password) async {
    final authUrl = Uri.parse("https://.... ");
    final response = await http
        .post(authUrl, body: {"username": username,
      "password": password});

    print(response.statusCode);
    print(response.body);
  }

  //Authorization header
  Future userAuthorization(String username, String password)async{
    final authUrl= Uri.parse("https:/....");
String basicAuth= "Basic"+base64Encode(utf8.encode("$username:$password"));

final accessToken= "some token value";
    final response= await http.get(authUrl,headers: {

      "content-Type":"application/json",
      "authorization": "Bearer $accessToken",
    });
    print(response.statusCode);
    print(response.body);
  }


}
