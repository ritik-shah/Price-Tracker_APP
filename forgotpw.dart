import 'dart:convert';
import 'package:aaa/login.dart';
import 'package:aaa/mainmenu.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(forgotpw_a());
}
class forgotpw_a extends StatelessWidget {
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
  final TextEditingController c_emailid = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff104a6b),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => login_a()),
            )
          },
        ),
        title: Text("Forgot Password"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
    child:Column(
        children: <Widget>[
          Container(
            child: Text("Reset Password"),


          ),
          Container(
            padding: EdgeInsets.only(left: 100,right: 100,top: 25),
            child: TextField(
              controller: c_emailid,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter your Email ID:"
              ),
            ),
          ),





          Container(
            padding: EdgeInsets.only(left: 100,top: 15,right: 100),
            child:    ButtonTheme(
              buttonColor: Colors.green,
              minWidth: double.infinity,
              height: 50.0,
              child: RaisedButton (
                child: Text('Next'),
                onPressed: () async {
                  var var_emailid=c_emailid.text.toString();

                  if(var_emailid.isEmpty)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Enter Email ID')),
                      );
                    }
                  else {
                    final response = await http.post(
                      Uri.parse('http://0.0.0.0/forgotpw'),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: jsonEncode(<String, String>{
                        'emailid': var_emailid,
                      }),
                    );

                    if (response.statusCode == 201) {

                    } else {
                      throw Exception('Failed to create album.');
                    }
                  }
                },
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }
}