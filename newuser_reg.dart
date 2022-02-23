import 'dart:convert';
import 'dart:io';


import 'package:aaa/login.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(newuser_reg_a());
}
class newuser_reg_a extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.indigo,


        ),
        home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController c_fname = TextEditingController();
  final TextEditingController c_lname = TextEditingController();
  final TextEditingController c_emailid = TextEditingController();
  final TextEditingController c_phno = TextEditingController();
  final TextEditingController c_dob = TextEditingController();
  final TextEditingController c_country = TextEditingController();
  final TextEditingController c_pw = TextEditingController();
  final TextEditingController c_confirmpw = TextEditingController();

  int flag=0;
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
        return Container(
          padding: EdgeInsets.only(top: 20.0),
          child:CircleAvatar(
          radius: 80,
          backgroundColor: Color(0xff104a6b),
          child:CircleAvatar(
          radius: 75,
          backgroundColor: Colors.white,
            child: Image.asset("images/profile3.png",
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                    scale: .50,
        ),
          ),
          ),
        );

      }
     else {
      return
        Container(
          padding: EdgeInsets.only(top: 20.0),
          child:CircleAvatar(
          radius: 80,
          backgroundColor: Colors.blueGrey,
          child:CircleAvatar(
          radius: 75,
          backgroundColor: Colors.white,
          child: Image.file(new File(imgname),
            width: 200,
            height: 200,
            fit: BoxFit.contain,
            scale: .50,

          ),
    ),
          ),
        );
    }

  }
  Future<void> tmpFunction() async {

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      print("ok");
      print(result.files.single.path);
      final bytes = File(result.files.single.path.toString()).readAsBytesSync();
      img64 = base64Encode(bytes);
      startup="2";
      flag=1;
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
    return Scaffold(
      appBar: AppBar(
        shadowColor: Color(0xffeef2ff),
        backgroundColor:Color(0xff0d3d59),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 10.00,
        toolbarHeight: 60,

        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => login_a()),
            )
          },
        ),
        title: Text("New User Registration",style: TextStyle(color: Colors.white,letterSpacing: 1.5,fontSize: 18),),
        centerTitle: true,
      ),
      body:
       SingleChildScrollView(
       child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(

            padding: EdgeInsets.only(bottom: 25),
            child:  GestureDetector(
              onTap: tmpFunction,
              child: loads()
              ,
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:<Widget>[
                SizedBox(
                  width: 25.0,
                  height: 50.0,
                ),
                Flexible(
                  child: TextField(

                    controller: c_fname,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),),
                        labelText: "First Name",
                        labelStyle: TextStyle(
                        color: Color(0xff104a6b),letterSpacing: 1.5),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                  height: 50.0,
                ),
                Flexible(
                  child: TextField(
                    controller: c_lname,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        labelText: "Last Name",
                      labelStyle: TextStyle(
                          color: Color(0xff104a6b),letterSpacing: 1.5),
                    ),
                  ),
                ),
                SizedBox(
                  width: 25.0,
                  height: 50.0,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 25,right: 25,top: 15),
            child: TextField(
              controller: c_emailid,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  labelText: "Email ID",
                labelStyle: TextStyle(
                    color: Color(0xff104a6b),letterSpacing: 1.5),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 25,right: 25,top: 15),
            child: TextField(
              controller: c_phno,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  labelText: "Phone Number",
                labelStyle: TextStyle(
                    color: Color(0xff104a6b),letterSpacing: 1.5),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 25,right: 25,top: 15),
            child: TextField(
              controller: c_dob,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  labelText: "D.O.B.",
                labelStyle: TextStyle(
                    color: Color(0xff104a6b),letterSpacing: 1.5),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 25,right: 25,top: 15),
            child: TextField(
              controller: c_country,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  labelText: "Country",
                labelStyle: TextStyle(
                    color: Color(0xff104a6b),letterSpacing: 1.5),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 25,right: 25,top: 15),
            child: TextField(
              controller: c_pw,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  labelText: "Enter Password",
                labelStyle: TextStyle(
                    color: Color(0xff104a6b),letterSpacing: 1.5),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 25,right: 25,top: 15),
            child: TextField(
              controller: c_confirmpw,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  labelText: "Confirm Password",
                labelStyle: TextStyle(
                    color: Color(0xff104a6b),letterSpacing: 1.5),
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.only(left: 25,right: 25,top: 15,bottom: 20),
            child: ButtonTheme(
              buttonColor: Colors.orangeAccent,
              minWidth: double.infinity,
              height: 50.0,
              child: OutlineButton(
                borderSide: BorderSide(color: Color(0xff104a6b),width: 2,),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                child: Text('Login',style: TextStyle(color: Color(0xff104a6b),fontWeight: FontWeight.w900,fontSize: 20,fontFamily: 'Montserrat',letterSpacing: 1.5),),

                onPressed: () async {
                  var var_fname=c_fname.text.toString();
                  var var_lname=c_lname.text.toString();
                  var var_emailid=c_emailid.text.toString();
                  var var_phno=c_phno.text.toString();
                  var var_dob=c_dob.text.toString();
                  var var_country=c_country.text.toString();
                  var var_pw=c_pw.text.toString();
                  var var_confirmpw=c_confirmpw.text.toString();

                  if(flag==0)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Choose a Profile Picture',style: TextStyle(color: Colors.white,letterSpacing: 1.2),),
                      behavior: SnackBarBehavior.floating,backgroundColor: Color(0xff535c79),margin: EdgeInsets.all(20),elevation: 20,),
                    );
                  }

                  else if(var_fname.isEmpty)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Enter First Name',style: TextStyle(color: Colors.white,letterSpacing: 1.2),),
                        behavior: SnackBarBehavior.floating,backgroundColor: Color(0xff535c79),margin: EdgeInsets.all(20),elevation: 20,),
                    );
                  }
                  else if(var_lname.isEmpty)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Enter Last Name',style: TextStyle(color: Colors.white,letterSpacing: 1.2),),
                        behavior: SnackBarBehavior.floating,backgroundColor: Color(0xff535c79),margin: EdgeInsets.all(20),elevation: 20,),
                    );
                  }
                  else if(var_emailid.isEmpty)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Enter Email ID',style: TextStyle(color: Colors.white,letterSpacing: 1.2),),
                        behavior: SnackBarBehavior.floating,backgroundColor: Color(0xff535c79),margin: EdgeInsets.all(20),elevation: 20,),
                    );
                  }
                  else if(var_phno.isEmpty)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Enter Phone Number',style: TextStyle(color: Colors.white,letterSpacing: 1.2),),
                        behavior: SnackBarBehavior.floating,backgroundColor: Color(0xff535c79),margin: EdgeInsets.all(20),elevation: 20,),
                    );
                  }
                  else if(var_dob.isEmpty)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Enter Date of Birth',style: TextStyle(color: Colors.white,letterSpacing: 1.2),),
                        behavior: SnackBarBehavior.floating,backgroundColor: Color(0xff535c79),margin: EdgeInsets.all(20),elevation: 20,),
                    );
                  }
                  else if(var_country.isEmpty)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Enter Country',style: TextStyle(color: Colors.white,letterSpacing: 1.2),),
                        behavior: SnackBarBehavior.floating,backgroundColor: Color(0xff535c79),margin: EdgeInsets.all(20),elevation: 20,),
                    );
                  }
                  else if(var_pw.isEmpty)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Enter Password',style: TextStyle(color: Colors.white,letterSpacing: 1.2),),
                        behavior: SnackBarBehavior.floating,backgroundColor: Color(0xff535c79),margin: EdgeInsets.all(20),elevation: 20,),
                    );

                  }

                  else if(var_confirmpw.isEmpty)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Enter Confirm Password',style: TextStyle(color: Colors.white,letterSpacing: 1.2),),
                        behavior: SnackBarBehavior.floating,backgroundColor: Color(0xff535c79),margin: EdgeInsets.all(20),elevation: 20,),
                    );

                  }

                  else if(var_pw!=var_confirmpw){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Password Does Not Match',style: TextStyle(color: Colors.white,letterSpacing: 1.2),),
                        behavior: SnackBarBehavior.floating,backgroundColor: Color(0xff535c79),margin: EdgeInsets.all(20),elevation: 20,),
                    );
                  }
                  else {
                    final response = await http.post(
                      Uri.parse('http://192.168.43.166:8000/regusers'),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: jsonEncode(<String, String>{
                        'fname': var_fname,
                        'lname': var_lname,
                        'emailid': var_emailid,
                        'phno': var_phno,
                        'dob': var_dob,
                        'country': var_country,
                        'pw': var_pw,
                        'confirmpw': var_confirmpw,
                        'img': img64
                      }),
                    );

                    if (response.statusCode == 200) {

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
       )
    );
  }

}