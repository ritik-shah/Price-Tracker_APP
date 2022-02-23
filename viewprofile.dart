import 'dart:convert';

import 'package:aaa/mainmenu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aaa/editprofile.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(viewprofile_a());
}
class viewprofile_a extends StatelessWidget {
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
  var pr_img="";
  var name="";
  var email_id="";
  var ph_no="";
  var dob="";
  var country="";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 0), () => loadprofile());
    });
  }


  // @override
  //   initState()  async {
  //   super.initState();
  //   print('hello girl');
  //
  //
  //
  //     final response = await http.post(
  //       Uri.parse('http://192.168.43.166:8000/viewmyprofile'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(<String, String>{
  //
  //         'lid':'1',
  //
  //       }),
  //     );
  //
  //     if (response.statusCode == 200)
  //     {
  //
  //       final parsed = jsonDecode(response.body);
  //       if(parsed['status']=="ok") {
  //
  //
  //
  //         setState(() {
  //
  //
  //         });
  //
  //
  //
  //
  //
  //
  //       }}
  //
  //
  //
  //
  //
  //   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => mainmenu_a()),
              )
            },
          ),
          title: Text("View Profile"),
          backgroundColor: Colors.orangeAccent,
          centerTitle: true,
        ),
      body:
    SingleChildScrollView(
    child:Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.only(right: 15,top: 10),
            child: ButtonTheme(
              buttonColor: Colors.cyan,
              //minWidth: double.infinity,
              height: 35.0,
              child: RaisedButton(
                child: Text('Edit'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => editprofile_a()),
                  );
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5,bottom: 25),
            child:
              CircleAvatar(
                radius: 80,
                backgroundColor: Colors.blueGrey,

                child: CircleAvatar(
                  radius: 75,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(pr_img,),
                ),

              ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.values.first,
              children:<Widget>[

                // new Container(child: new Text("Name"),width: 100,),
                // new Container(child: new Text(name),)

          Container(
            width: 150,
            padding: EdgeInsets.only(left: 70),
            child: Text("Name",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.blueGrey)),
          ),]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:<Widget>[
                Container(
            padding: EdgeInsets.only(top: 5,bottom: 5,left: 85),
            child: Text(name,style: TextStyle( fontSize: 20,color: Colors.blue)),
    ),]),
      Row(
        mainAxisAlignment: MainAxisAlignment.values.first,
        children:<Widget>[
          Container(
            width: 150,
            padding: EdgeInsets.only(top: 10,left: 70),
            child: Text("Email ID",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.blueGrey)),
          ),]),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children:<Widget>[
          Container(
            padding: EdgeInsets.only(top: 5,bottom: 5,left: 85),
            child: Text(email_id,style: TextStyle( fontSize: 20,color: Colors.blue)),
          ),]),
      Row(
        mainAxisAlignment: MainAxisAlignment.values.first,
        children:<Widget>[
          Container(
            width: 150,
            padding: EdgeInsets.only(top: 10,left: 70),
            child: Text("Ph. No.",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.blueGrey)),
          ),]),

      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children:<Widget>[
          Container(
            padding: EdgeInsets.only(top: 5,bottom: 5,left: 85),
            child: Text(ph_no,style: TextStyle( fontSize: 20,color: Colors.blue)),
          ),]),

      Row(
        mainAxisAlignment: MainAxisAlignment.values.first,
        children:<Widget>[
          Container(
            width: 150,
            padding: EdgeInsets.only(top: 10,left: 70),
            child: Text("D.O.B",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.blueGrey)),
          ),]),

      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children:<Widget>[
          Container(
            padding: EdgeInsets.only(top: 5,bottom: 5,left: 85),
            child: Text(dob,style: TextStyle(fontSize: 20,color: Colors.blue)),
          ),]),
      Row(
        mainAxisAlignment: MainAxisAlignment.values.first,
        children:<Widget>[
          Container(
            width: 150,
            padding: EdgeInsets.only(top: 10,left: 70),
            child: Text("Country",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.blueGrey)),
          ),]),


      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children:<Widget>[
          Container(
            padding: EdgeInsets.only(top: 5,bottom: 5,left: 85),
            child: Text(country,style: TextStyle( fontSize: 20,color: Colors.blue),),
          ),]),



        ],
      ),
    ),
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

        'lid':m.toString()
      }),
    );

    if (response.statusCode == 200)
    {




      final parsed = jsonDecode(response.body);
      if(parsed['status']=="ok") {



        setState(() {
          pr_img="http://192.168.43.166:8000"+parsed['prpic'];
          name=parsed['fname'].toString()+parsed['lname'].toString();
          email_id=parsed['emailid'].toString();
          ph_no=parsed['phno'].toString();
          dob=parsed['dob'].toString();
          country=parsed['country'].toString();

        });

      }}


  }
}








