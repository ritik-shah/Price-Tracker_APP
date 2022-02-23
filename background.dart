import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:aaa/mainmenu.dart';
import 'package:aaa/newuser_reg.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController c_username = TextEditingController();
  final TextEditingController c_password = TextEditingController();
  var message="";

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(

      decoration: BoxDecoration(

        image: DecorationImage(
            image: AssetImage("assets/Screenshot (483).png"), fit: BoxFit.cover),
      ),

      child: a(),



    );
  }

  a() {

    return    Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[



    Container(
    padding: EdgeInsets.only(left: 50,right: 50),
    child: TextField(

    controller: c_username,
    decoration: InputDecoration(

    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: BorderSide(color: Colors.orangeAccent,width: 2.0),
    ),
    labelText: "Username",
    labelStyle: TextStyle(
    color: Colors.orangeAccent),
    suffixIcon: Icon(
    Icons.account_circle_outlined,
    color: Colors.black,
    size: 35),
    ),
    ),
    ),


    Container(
    padding: EdgeInsets.only(left: 50,right: 50,top: 15),
    child: TextField(
    controller: c_password,
    decoration: InputDecoration(
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: BorderSide(color: Colors.orangeAccent,width: 2.0),
    ),
    labelText: "Password",
    labelStyle: TextStyle(
    color: Colors.orangeAccent),
    suffixIcon: Icon(

    Icons.visibility_outlined,
    color: Colors.black,
    size: 35),
    ),
    ),
    ),
    Container(
    padding: EdgeInsets.only(left: 50,right: 50,top: 15),
    child: ButtonTheme(
    buttonColor: Colors.orangeAccent,
    minWidth: double.infinity,
    height: 50.0,
    child: RaisedButton(
    child: Text('Login'),
    onPressed: () async {
    var var_username=c_username.text.toString();
    var var_password=c_password.text.toString();

    final response = await http.post(
    Uri.parse('http://192.168.43.166:8000/androidlogin'),
    headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
    'username': var_username,
    'password': var_password,
    }),
    );

    if (response.statusCode == 200)
    {

    final parsed = jsonDecode(response.body);
    if(parsed['status']=="ok") {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // int counter = (prefs.getInt('counter') ?? 0) + 1;
    // print('Pressed $counter times.');
    print(parsed['lid'].toString());
    prefs.setString('lid', parsed['lid'].toString());
    prefs.commit();

    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => mainmenu_a()),
    );
    }
    else
    {
    setState(() {
    message="Invalid username or password";
    });

    }
    } else {

    throw Exception('Failed to create album.');
    }



    },
    ),
    ),
    ),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children:<Widget>[
    Container(
    padding: EdgeInsets.only(top: 15),
    child:RaisedButton(
    child: Text('New User?'),
    onPressed:()  {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => newuser_reg_a()),
    );
    },
    )



    ),
    Container(
    padding: EdgeInsets.only(top: 15),
    child: Text('Forgot PW'),
    ),
    ],
    ),

    Container(
    padding: EdgeInsets.only(left: 15,right: 15,top: 15),
    child: Text(message),
    )


    ],
    );



  }
}