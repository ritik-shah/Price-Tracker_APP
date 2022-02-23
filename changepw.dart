import 'dart:convert';
// import 'package:aaa/login.dart';
import 'package:aaa/main.dart';
import 'package:aaa/mainmenu.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(changepw_a());
}
class changepw_a extends StatelessWidget {
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
  final TextEditingController c_oldpw = TextEditingController();
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
              MaterialPageRoute(builder: (context) => mainmenu_a()),
            ),
          },
        ),
        title: Text("Change Password"),
        centerTitle: true,
      ),
      body:

        SingleChildScrollView(

        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[



          Container(

              padding: EdgeInsets.only(left: 25,right: 25,top: 15),
              child:TextField(
                controller: c_oldpw,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Old Password"
                ),
              )
          ),
          Container(
            padding: EdgeInsets.only(left: 25,right: 25,top: 15),
            child: TextField(
              controller: c_newpw,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "New Password"
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 25,right: 25,top: 15),
            child: TextField(
              controller: c_confirmpw,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Confirm Passowrd"
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 25,right:25,top: 15),
            child: ButtonTheme(
              buttonColor: Color(0xff104a6b),
              minWidth: double.infinity,
              height: 50.0,
              child: RaisedButton(
                child: Text('SAVE CHANGES',style: TextStyle(color: Colors.white),),
                onPressed: () async {
                  var var_oldpw=c_oldpw.text.toString();
                  var var_newpw=c_newpw.text.toString();
                  var var_confirmpw=c_confirmpw.text.toString();

                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  String? m  = prefs.getString("lid") ;


                  if (var_oldpw.isEmpty)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Enter Old Password')),
                      );
                    }
                  else if(var_newpw.isEmpty)
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

                  else if(var_newpw!=var_confirmpw){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Password DoesNot Match')),
                    );
                  }

                  else{




                  final response = await http.post(
                    Uri.parse('http://192.168.43.166:8000/changepw'),
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode(<String, String>{
                      'oldpw': var_oldpw,
                      'newpw': var_newpw,
                      'lid':m.toString(),
                    }),
                  );

                  if (response.statusCode == 200) {
                    Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyApp()),
                            );
                  } else {

                    throw Exception('Failed to create album.');
                  }}
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