import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'aa.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(next_a());
}
class next_a extends StatelessWidget {
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

  String ma="";

  @override
   initState()  {
    super.initState();
    fillist();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
          onPressed: () =>
          {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => aa_a()),
            )
          },
        ),
        title: Text("Next Day Prediction"),
        backgroundColor: Color(0xff104a6b),
        centerTitle: true,
      ),
      body:
      SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 150,
                padding: EdgeInsets.only(left: 70),
                child: Text("Next Day Price", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blueGrey)),
              ),
              Container(
                padding: EdgeInsets.only(top: 5, bottom: 5, left: 85),
                child: Text("PRICE :"+ma.toString(),
                    style: TextStyle(fontSize: 20, color: Colors.blue)),
              ),
            ]),


      ),
    );
  }



Future<void> fillist() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? m  = prefs.getString("selbid") ;
  final response = await http.post(
    Uri.parse('http://192.168.43.166:8000/prediction'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'bid': m.toString(),

    }),
  );

  if (response.statusCode == 200) {
    final parsed = jsonDecode(response.body);
    if (parsed['status'] == "ok") {

      setState(() {
        ma=parsed['newprice'].toString();

        print(ma);
      });

    }
  }
}
}