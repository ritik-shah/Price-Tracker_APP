import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:aaa/viewprofile.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(editprofile_a());
}
class editprofile_a extends StatelessWidget {
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
 String  imgname="";
class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController c_fname = TextEditingController();
  final TextEditingController c_lname = TextEditingController();

  final TextEditingController c_phno = TextEditingController();
  final TextEditingController c_dob = TextEditingController();
  final TextEditingController c_country = TextEditingController();

  String img64="";

  String flag="1";
  int imgcheck=0;
  loada() {
    if (flag == "1") {




      return
        Container(
          padding: EdgeInsets.only(top: 25),
          child:CircleAvatar(
            radius: 80,
            backgroundColor: Colors.blueGrey,
          child:CircleAvatar(
            radius: 75,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(imgname,)
          ),
        )
        );
    }

    else
      {
        return
          Container(
            padding: EdgeInsets.only(top: 25),
            child: CircleAvatar(
              radius:80,
              backgroundColor: Colors.blueGrey,
              child: CircleAvatar(
                radius:75,
                backgroundColor: Colors.white,
                backgroundImage:Image.file(File(imgname),).image,

            ),),
        );

      }
  }



  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File("");
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds:0), () => loadprofile());
    });
  }




  Future<void> loadimage() async {

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      print("ok");
      print(result.files.single.path);
      final bytes = File(result.files.single.path.toString()).readAsBytesSync();
      img64 = base64Encode(bytes);
      flag="2";
      imgcheck=1;
      setState(() {
        imgname=result.files.single.path.toString();


      });
      // File file = File(result.files.single.path);
    } else {
      print("failed");
      // User canceled the picker
    }

  }


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
              MaterialPageRoute(builder: (context) => viewprofile_a()),
            )
          },
        ),
        title: Text("Edit Profile"),
        centerTitle: true,
      ),
      body:
        SingleChildScrollView(
        child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(

            padding: EdgeInsets.only(bottom: 35),
            child: GestureDetector(
              onTap: loadimage,
              child:
                  loada()
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
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        labelText: "First Name"
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
                        labelText: "Last Name"
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

          // ),
          Container(
            padding: EdgeInsets.only(left: 25,right: 25,top: 15),
            child: TextField(
              controller: c_phno,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  labelText: "Phone Number"
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 25,right: 25,top: 15),
            child: TextField(
              controller: c_dob,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  labelText: "D.O.B."
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 25,right: 25,top: 15),
            child: TextField(
              controller: c_country,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  labelText: "Country"
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.only(left: 25,right: 25,top: 15),
            child: ButtonTheme(
              buttonColor: Colors.orangeAccent,
              minWidth: double.infinity,
              height: 50.0,
              child: RaisedButton(
                child: Text('SAVE CHANGES'),
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  String? m  = prefs.getString("lid") ;
                  var var_fname=c_fname.text.toString();
                  var var_lname=c_lname.text.toString();

                  var var_phno=c_phno.text.toString();
                  var var_dob=c_dob.text.toString();
                  var var_country=c_country.text.toString();


                  if(var_fname.isEmpty)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Enter First Name')),
                      );
                    }
                  else if(var_lname.isEmpty)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Enter Last Name')),
                    );
                  }
                  else if(var_phno.isEmpty)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Enter Phone Number')),
                    );
                  }
                  else if(var_dob.isEmpty)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Enter Date of Birth')),
                    );
                  }
                  else if(var_country.isEmpty)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Enter Country')),
                    );
                  }
                  else {
                    final response = await http.post(
                      Uri.parse('http://192.168.43.166:8000/editprofile'),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: jsonEncode(<String, String>{
                        'fname': var_fname,
                        'lname': var_lname,

                        'phno': var_phno,
                        'dob': var_dob,
                        'country': var_country,
                        'lid': m.toString(),
                        'img': img64,
                        'flag': imgcheck.toString(),
                      }),
                    );

                    if (response.statusCode == 200) {
                      final parsed = jsonDecode(response.body);
                      if (parsed['status'] == "ok") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => viewprofile_a()),
                        );
                      }
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
        )
    );
  }

  loadprofile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? m  = prefs.getString("lid") ;
    final response = await http.post(
      Uri.parse('http://192.168.43.166:8000/viewmyprofile'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{

        'lid':m.toString(),
      }),
    );

    if (response.statusCode == 200)
    {

      final parsed = jsonDecode(response.body);
      if(parsed['status']=="ok") {




        imgname="http://192.168.43.166:8000"+parsed['prpic'];
        print(imgname);


        setState(() {


          imgname=imgname.toString();

        });






        c_fname.text=parsed['fname'].toString();
        c_lname.text=parsed['lname'].toString();

        c_phno.text=parsed['phno'].toString();
        c_dob.text=parsed['dob'].toString();
        c_country.text=parsed['country'].toString();

      }}
  }
}



