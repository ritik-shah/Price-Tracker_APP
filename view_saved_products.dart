import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(view_saved_products_a());
}
class view_saved_products_a extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();


}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 0), () => viewsavedproducts());
    });


  }

  viewsavedproducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? m = prefs.getString("lid");
    final response = await http.post(
      Uri.parse('http://192.168.43.166:8000/viewmybudget'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{

        'lid': m.toString()
      }),
    );

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);

      print(parsed);



    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text("View Saved Products"),
      ),

    );
  }
}