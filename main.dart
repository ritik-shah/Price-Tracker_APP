import 'package:aaa/login.dart';
import 'package:aaa/pr_search.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:aaa/mainmenu.dart';
import 'package:aaa/newuser_reg.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();
  late StreamSubscription _intentDataStreamSubscription;

  final _inputKey = GlobalKey<FormState>();



  late List<SharedMediaFile> _sharedFiles;
  String _sharedText="";

  final TextEditingController c_username = TextEditingController();
  final TextEditingController c_password = TextEditingController();
  var message="";

  @override
  void initState() {
    super.initState();

    // For sharing images coming from outside the app while the app is in the memory
    _intentDataStreamSubscription =
        ReceiveSharingIntent.getMediaStream().listen((
            List<SharedMediaFile> value) {
          print("1");
          setState(() {
            // print("Shared:" + (_sharedFiles?.map((f)=> f.path)?.join(",") ?? ""));
            // _sharedFiles = value;
          });
        }, onError: (err) {
          print("getIntentDataStream error: $err");
        });

    // For sharing images coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialMedia().then((List<SharedMediaFile> value) async {
      print("2");
      //print(value.toString());
      SharedPreferences prefs = await SharedPreferences.getInstance();


      prefs.setString('a', value.toString());

    });

    // For sharing or opening urls/text coming from outside the app while the app is in the memory
    _intentDataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String value) {
          print("3");
          setState(() async {

            _sharedText = value;

          });
        }, onError: (err) {
          print("getLinkStream error: $err");
        });

    // For sharing or opening urls/text coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialText().then((String ? value) async {
      print("hello");
      print(value);
      print("hi");


      var s=value.toString().split("http");
      print("split:");
      print("after split");
      print(s[1].toString());



      print("Hello World");




      value="";
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString('url', "http"+s[1].toString());

      if(s.length==2) {
        runApp(pr_search_a());
      }
      else{

      }




    });
  }

  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const textStyleBold = const TextStyle(fontWeight: FontWeight.bold);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.amber
      ),
      scaffoldMessengerKey: _messangerKey,
      home: Scaffold(
        backgroundColor: Color(0xff0d3d59),
        appBar: AppBar(
          shadowColor: Color(0xffeef2ff),
          backgroundColor:Color(0xff0d3d59),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 10.00,
          toolbarHeight: 60,

          title: Text("Price Tracker",style: TextStyle(color: Colors.white,letterSpacing: 2,fontSize: 23),),
          centerTitle: true,
        ),
        body:
          Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[



              Container(
                padding: EdgeInsets.only(left: 50,right: 50),
                child: TextField(
                  style: TextStyle(color: Color(0xffEFEFEF),),
                  controller: c_username,
                  decoration: InputDecoration(

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.orangeAccent,width: 2.0),
                    ),
                    labelText: "Username",
                    labelStyle: TextStyle(
                        color: Colors.orangeAccent,letterSpacing: 2),
                    suffixIcon: Icon(
                        Icons.account_circle_outlined,
                        color: Colors.white,
                        size: 35),
                  ),
                ),
              ),


              Container(
                padding: EdgeInsets.only(left: 50,right: 50,top: 15),
                child: TextField(
                  style: TextStyle(color: Color(0xffEFEFEF),),
                  controller: c_password,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.orangeAccent,width: 2.0),
                    ),
                    labelText: "Password",
                    labelStyle: TextStyle(
                        color: Colors.orangeAccent,letterSpacing: 2),
                    suffixIcon: Icon(

                        Icons.visibility_outlined,
                        color: Colors.white,
                        size: 35),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 50,right: 50,top: 15,bottom: 5),
                child: ButtonTheme(
                  buttonColor: Colors.white,
                  minWidth: double.infinity,
                  height: 50.0,
                  child: OutlineButton(
                    borderSide: BorderSide(color: Color(0xffEEF2FF),width: 2),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                    child: Text('Login',style: TextStyle(color: Colors.orangeAccent,fontWeight: FontWeight.w600,fontSize: 20,fontFamily: 'Montserrat',letterSpacing: 2),),

                    onPressed: () async {
                      var var_username=c_username.text.toString();
                      var var_password=c_password.text.toString();

                      if(var_username.isEmpty)
                      {
                        _messangerKey.currentState!.showSnackBar(
                            SnackBar(content: Text('Enter Username',style: TextStyle(color: Colors.black),),
                              behavior: SnackBarBehavior.floating,backgroundColor: Color(0xffEEF2FF),margin: EdgeInsets.all(20),elevation: 20,),

                        );
                      }
                      else if(var_password.isEmpty)
                      {
                        _messangerKey.currentState!.showSnackBar(
                            SnackBar(content: Text('Enter Password',style: TextStyle(color: Colors.black),),
                              behavior: SnackBarBehavior.floating,backgroundColor: Color(0xffEEF2FF),margin: EdgeInsets.all(20),elevation: 20,),

                        );
                      }
                      else {
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

                        if (response.statusCode == 200) {
                          final parsed = jsonDecode(response.body);
                          if (parsed['status'] == "ok") {
                            SharedPreferences prefs = await SharedPreferences
                                .getInstance();
                            // int counter = (prefs.getInt('counter') ?? 0) + 1;
                            // print('Pressed $counter times.');
                            print(parsed['lid'].toString());
                            prefs.setString('lid', parsed['lid'].toString());
                            prefs.commit();

                            runApp(mainmenu_a());

                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (this.) => mainmenu_a()),
                            // );
                          }
                          else {
                            setState(() {
                              message = "Invalid username or password";
                            });
                          }
                        } else {
                          throw Exception('Failed to create album.');
                        }
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
                      child:OutlineButton(
                        borderSide: BorderSide(color: Colors.orangeAccent,width: 1),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),),
                        child: Text('New User?',style: TextStyle(color: Colors.orangeAccent,letterSpacing: 2),),

                        onPressed:()  {
                          runApp(newuser_reg_a());
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => newuser_reg_a()),
                          // );
                        },
                      )



                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    child:OutlineButton(
                      borderSide: BorderSide(color: Colors.orangeAccent,width: 1),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),),
                      onPressed: () {  },
                      child: Text('Forgot PW?',style: TextStyle(color: Colors.orangeAccent,letterSpacing: 2),),
                    ),
                    ),
                ],
              ),

              Container(
                padding: EdgeInsets.only(left: 15,right: 15,top: 15),
                child: Text(message,style: TextStyle(color: Color(0xffEEF2FF),fontSize: 17),),
              )

            ],
          ),
        ),

      ),
    );
  }







}