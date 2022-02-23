import 'dart:convert';
import 'dart:ui';
import 'package:aaa/savedproducts.dart';
import 'package:aaa/view_saved_products.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:aaa/pr_search_results.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mainmenu.dart';

void main() {
  runApp(pr_search_a());
}
class pr_search_a extends StatelessWidget {
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
  final TextEditingController c_url = TextEditingController();
  final TextEditingController c_target = TextEditingController();
  int  flag=0;
  int flg1=0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {


      flag=0;

      // a();


      Future.delayed(Duration(seconds: 0), () => loadurl());
    });
  }

  var pr_name="";
  var pr_price="";
  var pr_image="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        backgroundColor:Color(0xff0d3d59),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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
        title: Text("Search"),
        centerTitle: true,
      ),
      body:
      SingleChildScrollView(
          child:
          Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 25,right: 25,top: 25),
            child: TextField(
              controller: c_url,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  labelText: "URL"
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 25,right: 25,top: 15),
            child: ButtonTheme(
              buttonColor: Colors.white,
              minWidth: double.infinity,
              height: 50.0,

              child: OutlineButton(

                // style: ButtonStyle(shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),),
                borderSide: BorderSide(color: Color(0xff104a6b),width: 2,),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),


                // visualDensity: VisualDensity.adaptivePlatformDensity,
                // textColor: Colors.orangeAccent,
                child: Text('Search',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 20,fontFamily: 'Montserrat',letterSpacing: 1.5),),
                onPressed: () async {

                  setState(() {
                    flg1=2;
                  });
                  var var_url=c_url.text.toString();

                  if(var_url.isEmpty || var_url==" ")
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Enter URL',style: TextStyle(color: Colors.white),),
                          behavior: SnackBarBehavior.floating,backgroundColor: Color(0xff114c6f),margin: EdgeInsets.all(20),elevation: 20,),

                      );
                    }
                  else {
                    final response = await http.post(
                      Uri.parse('http://192.168.43.166:8000/and_pr_scrap'),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: jsonEncode(<String, String>{
                        'prurl': var_url,

                      }),);
                    if (response.statusCode == 200) {
                      final parsed = jsonDecode(response.body);
                      if (parsed['status'] == "ok") {
                        setState(() {

                          flag=1;
                          pr_name = parsed['prname'];
                          pr_price = parsed['prprice'];
                          pr_image = parsed['primg'];
                        });
                      }
                      else {
                        print("error.");
                      }
                    }

                    else {
                      throw Exception('ERRor');
                    }
                  }
                },
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.only(left: 100,right: 100,top: 15),
            child: b(),
          ),
          Container(
            padding:EdgeInsets.only(left: 20,right: 20,top: 15,bottom: 15),
            child: Text(pr_name,  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.red),),
          ),
         c(),

          // Container(
          //   padding: EdgeInsets.only(left: 100,right: 100,top: 15),
          //   child: Text('GRAPH'),
          // ),
          Container(
            padding: EdgeInsets.only(left: 25,right: 25,top: 15),
            child: TextField(
              controller: c_target,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color: Colors.red),),
                  labelText: "Enter Target Price",labelStyle: TextStyle(letterSpacing: 1.5),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 25,right: 25,top: 15,bottom: 25),
            child: ButtonTheme(

              buttonColor: Colors.orangeAccent,
              minWidth: double.infinity,
              height: 50.0,
              child: OutlineButton(

                // style: ButtonStyle(shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),),
                borderSide: BorderSide(color: Color(0xff104a6b),width: 2,),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),


                // visualDensity: VisualDensity.adaptivePlatformDensity,
                // textColor: Colors.orangeAccent,
                child: Text('Set Target',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20,fontFamily: 'Montserrat',letterSpacing: 1.5),),
                onPressed: () async {
                  var var_target=c_target.text.toString();
                  var var_url=c_url.text.toString();

                  if(var_url.isEmpty || var_url==" ")
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Enter URL',style: TextStyle(color: Colors.white),),
                        behavior: SnackBarBehavior.floating,backgroundColor: Color(0xff114c6f),margin: EdgeInsets.all(20),elevation: 20,),

                    );
                  }
                  else if(var_target.isEmpty)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Enter Target Price',style: TextStyle(color: Colors.white),),
                          behavior: SnackBarBehavior.floating,backgroundColor: Color(0xff114c6f),margin: EdgeInsets.all(20),elevation: 20,),

                      );
                    }
                  else {
                    SharedPreferences prefs = await SharedPreferences
                        .getInstance();
                    String? m = prefs.getString("lid");
                    final response = await http.post(
                      Uri.parse('http://192.168.43.166:8000/insertintobudget'),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: jsonEncode(<String, String>{
                        'tarprice': var_target,
                        'buid': m.toString(),
                        'prurl': var_url,
                        'prname': pr_name,
                        'primg': pr_image,
                      }),
                    );

                    if (response.statusCode == 200) {
                      final parsed = jsonDecode(response.body);
                      if (parsed['status'] == "ok") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              savedproducts_a()),
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
          )
      ),
    );
  }

  loadurl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? m  = prefs.getString("url") ;
    c_url.text=m.toString();

    prefs.setString("url", " ");



  }

  a() {

    if(flag==1) {

      flag=0;

      return Container(
          height: 250.0,
          width: 250.0,
          child:Image.network(pr_image,width: 250.0,height: 250.0,fit: BoxFit.contain,),
      );
    }
    else
      {
        return Container(
            height: 250.0,
            width: 250.0,
         child:Image.asset("images/1488.gif",width: 250.0,height: 250.0,fit: BoxFit.contain),
        );
      }


  }

  b() {

    if(flg1==0)
      {
        return Text("");
      }
    else
      {
        return a();
      }

  }

  c() {

    if(flg1==0)
      {
        return Text("");
      }
else
{
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 15,top: 15,bottom: 15),
            child: Text("PRICE : ",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.red))
        ),
        Container(
            padding: EdgeInsets.only(right: 15,top: 15,bottom: 15),
            child: Text(pr_price, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.red))
        ),
      ],
    );

}



  }
}