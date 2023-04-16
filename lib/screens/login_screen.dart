import 'package:ecommerce/screens/home.dart';
import 'package:ecommerce/services/apiServices.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  TextEditingController nameController =
      TextEditingController(text: "mor_2314");
  TextEditingController passController = TextEditingController(text: "83r5^_");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Text(
            "Online Shop",
            style: TextStyle(fontSize: 22.0, color: Colors.black87),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  labelText: "UserName", border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 30.0,
            ),
            TextField(
              controller: passController,
              obscureText: false,
              decoration: InputDecoration(
                  labelText: "Password", border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () async {
                  final getToken = await ApiService()
                      .userLogin(nameController.text, passController.text);
                  if (getToken["token"] != null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "Success ! your Token id is ${getToken["token"]}"),
                      backgroundColor: Colors.grey,
                    ));
                    Future.delayed(Duration(seconds: 2),(){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                        return HomePage();
                      }));
                    });
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "Username or Password Incorrect" ),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Background color
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
