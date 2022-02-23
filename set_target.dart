import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';

void main() {
  runApp(set_target_a());
}
class set_target_a extends StatelessWidget {
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
  final TextEditingController c_target = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text("Set Target"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 100,right: 100,top: 15),
            child: Text('Image'),
          ),
          Container(
            padding:EdgeInsets.only(left: 100,right: 100,top: 15),
            child: Text('Product Name'),
          ),
          Container(
            padding: EdgeInsets.only(left: 100,right: 100,top: 15),
            child: Text('Product Price'),
          ),
          Container(
            padding: EdgeInsets.only(left: 100,right: 100,top: 15),
            child: Text('GRAPH'),
          ),
          Container(
            padding: EdgeInsets.only(left: 100,right: 100,top: 15),
            child: ButtonTheme(
              buttonColor: Colors.orangeAccent,
              minWidth: double.infinity,
              height: 50.0,
              child: RaisedButton(
                child: Text('SET TARGET'),
                onPressed: (){},
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 100,right: 100,top: 15),
            child: TextField(
              controller: c_target,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter Target Price"
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 100,right: 100,top: 15),
            child: ButtonTheme(
              buttonColor: Colors.orangeAccent,
              minWidth: double.infinity,
              height: 50.0,
              child: RaisedButton(
                child: Text('SET'),
                onPressed: () async {
                  var var_target=c_target.text.toString();
                  final response = await http.post(
                    Uri.parse('http://192.168.43.166:8000/insertintobudget'),
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode(<String, String>{
                      'tarprice': var_target,
                      'buid':'1',
                      'prurl':'',
                      'prname': '',
                    }),
                  );

                  if (response.statusCode == 201) {

                  } else {

                    throw Exception('Failed to create album.');
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}