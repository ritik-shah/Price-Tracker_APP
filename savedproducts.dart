import 'package:aaa/mainmenu.dart';
import 'package:aaa/sg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'aa.dart';

void main() {
  runApp(savedproducts_a());
}

class savedproducts_a extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainList(),
    );
  }
}

class MainList extends StatefulWidget {
  @override
  _MainListState createState() => _MainListState();
}

class _MainListState extends State<MainList> {
  List<String> pr_image = <String>[];
  List<String> pr_name = <String>[];
  List<String> pr_tar_price = <String>[];
  List<String> pr_bid = <String>[];

  Future<void> fillList() async {


    pr_image = <String>[];
    pr_name = <String>[];
    pr_tar_price = <String>[];
    pr_bid = <String>[];
    // Fill the list with links
    // var json = jsonDecode(
    //     (await http.get(Uri.parse("https://picsum.photos/v2/list?limit=40"))).body);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? m  = prefs.getString("lid") ;
    final response = await http.post(
      Uri.parse('http://192.168.43.166:8000/viewmybudget'),
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
          pr_image.add(item['img_url'].toString());
          pr_name.add(item['pr_name'].toString());
          pr_tar_price.add(item['tar_price'].toString());
          pr_bid.add(item['bid'].toString());
        }
      });
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
                MaterialPageRoute(builder: (context) => mainmenu_a()),
              )
            },
          ),
          title: Text("View Saved Products"),

          centerTitle: true,
        ),
        body:
        ListView.builder(
          padding: EdgeInsets.only(top: 10),
        itemCount: pr_image.length,
        itemBuilder: (context, i){

          return Card(

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 10,
              margin: EdgeInsets.only(left: 15,right: 15,bottom: 7),
            child:Container(
            padding: EdgeInsets.only(top: 10,left: 10,bottom: 10,right: 10),
            child:Row(

            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,

            children:<Widget>[

              Flexible(


                child: Image.network(pr_image[i],width: 130,height: 130,fit: BoxFit.contain,),
              ),

              Column(


                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[



                  Container(

                    width: MediaQuery.of(context).size.width*0.6,


                    padding: EdgeInsets.only(left: 20.0,top: 20.0,),
                    child:Flexible(
                       child: Text(pr_name[i].toString(),softWrap: true,),
                    ),
                        ),





                  Container(
                  padding: EdgeInsets.only(left: 20.0,top: 20.0),
                    child:
                      Text(pr_tar_price[i]),
                  ),

                  Row(
                    children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 20,top: 15,),
                      child: ButtonTheme(
                        buttonColor: Color(0xff104a6b),
                        child: RaisedButton(
                          child: Text('Delete',style: TextStyle(color: Colors.white),),
                          onPressed: () async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            String? m  = prefs.getString("lid") ;

                            final response = await http.post(
                              Uri.parse('http://192.168.43.166:8000/and_deletemybudget'),
                              headers: <String, String>{
                                'Content-Type': 'application/json; charset=UTF-8',
                              },
                              body: jsonEncode(<String, String>{
                                'bid': pr_bid[i],

                              }),
                            );
                            if (response.statusCode == 200) {

                              fillList();
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => viewcomplaints_a()),
                              // );
                            } else {
                              throw Exception('Failed to create album.');
                            }

                          },
                        ),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(left: 20,top: 15,),
                      child: ButtonTheme(
                        buttonColor: Color(0xff104a6b),
                        child: RaisedButton(
                          child: Text('Graph',style: TextStyle(color: Colors.white),),
                          onPressed: () async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();


                            prefs.setString('selbid', pr_bid[i]);



                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => aa_a()),
                              );
                          },
                        ),
                      ),
                    ),


                  ]
                  ),

                ],
              ),

            ],
          ),
          ));

    },


    ));
  }

  @override
  void initState() {
    super.initState();
    fillList();
  }
}
