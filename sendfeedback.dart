import 'dart:convert';
import 'package:aaa/mainmenu.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:aaa/viewfeedback.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(sendfeedback_a());
}
class sendfeedback_a extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        debugShowCheckedModeBanner: false,
        home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController c_feedback = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        shadowColor: Color(0xffeef2ff),
        backgroundColor:Color(0xff0d3d59),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10.00,
        toolbarHeight: 60,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => mainmenu_a()),
            )
          },
        ),
        title: Text("Send Feedback"),
        centerTitle: true,
      ),
      body:
    SingleChildScrollView(
    child:Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 25,right: 25,top: 25),
            child: TextField(
              controller: c_feedback,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),),
                  labelText: "Enter your Feedback",
                labelStyle: TextStyle(
                    color: Color(0xff104a6b),letterSpacing: 2),

              ),

              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 15,
            ),
    ),

          Container(
            padding: EdgeInsets.only(left: 25,right: 25,top: 25),
            child: ButtonTheme(
              buttonColor: Colors.white,
              minWidth: double.infinity,
              height: 50.0,
              child: OutlineButton(
                borderSide: BorderSide(color: Color(0xff104a6b),width: 2),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                child: Text('Send Feedback',style: TextStyle(color: Color(0xff104a6b),fontWeight: FontWeight.w600,fontSize: 20,fontFamily: 'Montserrat',letterSpacing: 2),),

                onPressed: () async {

                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  String? m  = prefs.getString("lid") ;
                  // print('Pressed $counter times.');

                  var var_feedback=c_feedback.text.toString();

                  if(var_feedback.isEmpty)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Enter Feedback',style: TextStyle(color: Colors.black),),
                      behavior: SnackBarBehavior.floating,backgroundColor: Color(0xffEEF2FF),margin: EdgeInsets.all(20),elevation: 20,),

                    );
                  }
                  else {
                    final response = await http.post(
                      Uri.parse('http://192.168.43.166:8000/and_feedback'),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: jsonEncode(<String, String>{
                        'feedback': var_feedback,
                        'lid': prefs.getString("lid").toString()
                      }),
                    );

                    if (response.statusCode == 200) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => viewfeedback_a()),
                      );
                    } else {
                      throw Exception('Failed to create album.');
                    }
                  }
                },
              ),
            ),
          )
        ],
      ),
    ),
    );
  }
}