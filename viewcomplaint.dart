import 'package:aaa/mainmenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(viewcomplaints_a());
}

class viewcomplaints_a extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainList(),
    );
  }
}

class MainList extends StatefulWidget {
  @override
  _MainListState createState() => _MainListState();
}

class _MainListState extends State<MainList> {
  List<String> u_complaint = <String>[];
  List<String> c_img = <String>[];
  List<String> reply = <String>[];
  List<String> c_status = <String>[];
  List<String> c_date = <String>[];
  List<String> r_date = <String>[];

  Future<void> fillList() async {
    // Fill the list with links
    // var json = jsonDecode(
    //     (await http.get(Uri.parse("https://picsum.photos/v2/list?limit=40"))).body);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? m  = prefs.getString("lid") ;
    final response = await http.post(
      Uri.parse('http://192.168.43.166:8000/and_viewcomplaint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{

        'lid':m.toString()
      }),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      setState(() {
        Map<String, dynamic> item;
        var data= json['data'];

        for (item in data) {
          u_complaint.add(item['u_complaint'].toString());
          c_img.add(item['c_img'].toString());
          reply.add(item['reply'].toString());
          c_status.add(item['status'].toString());
          c_date.add(item['cdate'].toString());
          r_date.add(item['rdate'].toString());
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => mainmenu_a()),
              )
            },
          ),
          title: Text("View Complaints"),
          centerTitle: true,
        ),
        body:
        ListView.builder(
          itemCount: u_complaint.length,
          itemBuilder: (context, i){

            return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                elevation: 10,
                margin: EdgeInsets.only(left: 15,right: 15,bottom: 3,top: 10,),
            child: Container(
              // height: 300,
              padding: EdgeInsets.only(bottom: 20),
              child:Row(

                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,

                children:<Widget>[

                  Container(
                    padding: EdgeInsets.only(top: 20,left: 10),
                    child:Image.network("http://192.168.43.166:8000"+c_img[i],width: 100,height: 130,fit: BoxFit.cover,),
                  ),

a(i)
                 ,
              ]),
            ));

          },
        )
    );
  }

  @override
  void initState() {
    super.initState();
    fillList();
  }

  a(int i) {

    if(c_status[i].toString().compareTo("PENDING")==1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 20.0, top: 20.0),
                  child: Text("Posted Date : "),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.0, top: 20.0),

                  child: Text(c_date[i].toString()),
                ),
              ]),

          Container(


            padding: EdgeInsets.only(left: 20, top: 20),
            // alignment: Alignment.center,
            child: Text("---------COMPLAINT-------------",softWrap: true,),

          ),
          Container(

            padding: EdgeInsets.only(left: 20.0, top: 20.0),
            child: (
                Text(u_complaint[i].toString(),)

            ),
          ),

          Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 20.0, top: 20.0),
                  child: Text("Status : "),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.0, top: 20.0),
                  child: Text(c_status[i].toString()),
                ),
              ]
          ),

          Container(
            padding: EdgeInsets.only(left: 20.0, top: 20.0),
            child: Text("REPLY"),
          ),
          Container(
            padding: EdgeInsets.only(left: 20.0, top: 20.0),
            child: Text(reply[i].toString()),
          ),
          Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 20.0, top: 20.0),
                  child: Text("Replied Date : "),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.0, top: 20.0),
                  child: Text(r_date[i].toString()),
                ),
              ]
          ),


        ],
      );
    }
    else
      {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 20.0, top: 20.0),
                    child: Text("Posted Date : "),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20.0, top: 20.0),

                    child: Text(c_date[i].toString()),
                  ),
                ]),

            Container(


              padding: EdgeInsets.only(left: 20, top: 20),
              // alignment: Alignment.center,
              child: Text("-------------COMPLAINT-------------",softWrap: true,),

            ),
            Container(

              padding: EdgeInsets.only(left: 20.0, top: 20.0),
              child: (
                  Text(u_complaint[i].toString(),)

              ),
            ),

            Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 20.0, top: 20.0),
                    child: Text("Status : "),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20.0, top: 20.0),
                    child: Text(c_status[i].toString()),
                  ),
                ]
            ),



          ],
        );
      }


  }
}
