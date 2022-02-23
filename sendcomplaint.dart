import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:aaa/login.dart';
import 'package:aaa/mainmenu.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:aaa/viewcomplaint.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(sendcomplaint_a());
}
class sendcomplaint_a extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.deepOrange,
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
  final TextEditingController c_complaint = TextEditingController();
  String img64="";

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File("");
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  String startup="1";

  loads() {


    if(startup=="1")
    {
      return Image.asset(
        "images/btn_addimage.png",
        width: 175,
        fit: BoxFit.cover,
        scale: .50
        ,
      );

    }
    else {
      return Image.file(
        new File(imgname),
        width: 200,
        fit: BoxFit.contain,
        scale: .50
        ,
      );
    }

  }
  Future<void> loadimage() async {

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      print("ok");
      print(result.files.single.path);
      final bytes = File(result.files.single.path.toString()).readAsBytesSync();
      img64 = base64Encode(bytes);
      startup="2";

      setState(() {
        imgname=result.files.single.path.toString();
      });
      // File file = File(result.files.single.path);
    } else {
      print("failed");
      // User canceled the picker
    }

  }
  var imgname="";


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
    onWillPop: _onBackPressed,
      child: new Scaffold(

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
        title: Text("Send Complaint"),
        centerTitle: true,
      ),
      body:
      SingleChildScrollView(
        child:Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 25,right: 25,top: 25),
            child: TextField(
              controller: c_complaint,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  labelText: "Enter your Complaint",
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
            child: GestureDetector(
              onTap: loadimage,
              child: loads()
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
                child: Text('Send',style: TextStyle(color: Color(0xff104a6b),fontWeight: FontWeight.w600,fontSize: 20,fontFamily: 'Montserrat',letterSpacing: 2),),

                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  String? m  = prefs.getString("lid") ;

                  var var_complaint=c_complaint.text.toString();

                  if(var_complaint.isEmpty)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Enter Complaint',style: TextStyle(color: Colors.black),),
                          behavior: SnackBarBehavior.floating,backgroundColor: Color(0xffEEF2FF),margin: EdgeInsets.all(20),elevation: 20,),

                      );
                    }
                  else {
                    final response = await http.post(
                      Uri.parse('http://192.168.43.166:8000/and_complaint'),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: jsonEncode(<String, String>{
                        'complaint': var_complaint,
                        'lid': m.toString(),
                        'img': img64
                      }),
                    );

                    if (response.statusCode == 200) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => viewcomplaints_a()),
                      );
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
    ));
  }



  Future <bool> _onBackPressed() {

    runApp(login_a());

    return Future.value(true);
  }
}