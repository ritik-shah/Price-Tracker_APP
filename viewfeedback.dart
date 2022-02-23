import 'package:aaa/mainmenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(viewfeedback_a());
}

class viewfeedback_a extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Feedbacks',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.comfortable,
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
  List<String> feedback = <String>[];
  List<String> fdate = <String>[];


  Future<void> fillList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? m  = prefs.getString("lid") ;
    final response = await http.post(
      Uri.parse('http://192.168.43.166:8000/and_viewfeedback'),
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
          feedback.add(item['feedback'].toString());
          fdate.add(item['fdate'].toString());
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
          title: Text("View Feedbacks"),
          centerTitle: true,
        ),
        body:
        ListView.builder(
          itemCount: feedback.length,
          itemBuilder: (context, i){

            return
              Container(
                height: 300,
                child:Row(

                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,

                    children:<Widget>[
                      // Image.network(c_img[i],width: 100,height: 130,fit: BoxFit.contain,),


                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 20.0,top: 20.0),
                                  child:Text("Posted Date : "),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 20.0,top: 20.0),

                                  child:Text(fdate[i].toString()),
                                ),
                              ]),

                          Container(

                            color: Colors.black12,

                            padding: EdgeInsets.only(left: 20,top: 20),
                            alignment: Alignment.center,
                            // alignment: Alignment.center,
                            child: (
                                Text("FEEDBACK")
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20.0,top: 20.0),
                            child:Text(feedback[i].toString()),
                          ),
                          // Row(
                          //
                          //     children: <Widget>[
                          //       Container(
                          //         padding: EdgeInsets.only(left: 20.0,top: 20.0),
                          //         child:Text("Status : "),
                          //       ),
                          //       Container(
                          //         padding: EdgeInsets.only(left: 20.0,top: 20.0),
                          //         child:Text(c_status[i].toString()),
                          //       ),
                          //     ]
                          // ),
                          // Container(
                          //   padding: EdgeInsets.only(left: 20.0,top: 20.0),
                          //   child: Text("REPLY"),
                          // ),
                          // Container(
                          //   padding: EdgeInsets.only(left: 20.0,top: 20.0),
                          //   child: Text(reply[i].toString()),
                          // ),
                          // Row(
                          //     children: <Widget>[
                          //       Container(
                          //         padding: EdgeInsets.only(left: 20.0,top: 20.0),
                          //         child:Text("Replied Date : "),
                          //       ),
                          //       Container(
                          //         padding: EdgeInsets.only(left: 20.0,top: 20.0),
                          //         child:Text(r_date[i].toString()),
                          //       ),
                          //     ]
                          // ),
                        ],
                      ),
                    ]),
              );

          },
        )
    );
  }

  @override
  void initState() {
    super.initState();
    fillList();
  }
}
