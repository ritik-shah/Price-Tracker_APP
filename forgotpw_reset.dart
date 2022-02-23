import 'dart:convert';
import 'package:aaa/login.dart';
import 'package:aaa/mainmenu.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(forgotpw_reset_a());
}
class forgotpw_reset_a extends StatelessWidget {
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
  final TextEditingController c_newpw = TextEditingController();
  final TextEditingController c_confirmpw = TextEditingController();

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
        title: Text("Reset Password"),
        centerTitle: true,
      ),
      body:
    SingleChildScrollView(
    child:Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 100,right: 100,top: 15),
            child: TextField(
              controller: c_newpw,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "New Password"
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 100,right: 100,top: 15),
            child: TextField(
              controller: c_confirmpw,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Confirm Password"
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
                child: Text('RESET PASSWORD'),
                onPressed: () async {
                  var var_newpw=c_newpw.text.toString();
                  var var_confirmpw=c_confirmpw.text.toString();

                  if(var_newpw.isEmpty)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Enter New Password')),
                      );
                    }
                  else if(var_confirmpw.isEmpty)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Enter Confirm Password')),
                  );
                  }
                  else if(var_newpw!=var_confirmpw)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Password DoesNot Match')),
                      );
                    }
                  else {
                    final response = await http.post(
                      Uri.parse('http://0.0.0.0/resetpw'),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: jsonEncode(<String, String>{
                        'newpw': var_newpw,
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