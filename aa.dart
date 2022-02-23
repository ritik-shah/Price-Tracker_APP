import 'dart:convert';
import 'dart:ffi';
import 'package:aaa/savedproducts.dart';
import 'package:aaa/viewprofile.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:aaa/viewfeedback.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'next.dart';

void main() {
  runApp(aa_a());
}
class aa_a extends StatelessWidget {
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

  List<String> pr_date = <String>[];
  List<String> pr_amt = <String>[];
  late ZoomPanBehavior _zoomPanBehavior;

  List<SalesData> c = <SalesData>[];


  Future<void> fillList() async {

    print("hii");
    pr_date = <String>[];
    pr_amt = <String>[];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? m  = prefs.getString("selbid") ;
    final response = await http.post(
      Uri.parse('http://192.168.43.166:8000/viewprevprice'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{

        'bid':m.toString()
      }),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      setState(() {
        Map<String, dynamic> item;
        var data= json['data'];

        for (item in data) {
          print("hiiii");
          // pr_amt.add(item['pr_amt'].toString());
          // pr_date.add(item['pr_date'].toString());

          print(item['pr_amt'].toString());
          print(item['pr_date'].toString());

          SalesData a=new SalesData(item['pr_date'], item['pr_amt']);
          c.add(a);



        }

        print("hello");
      });
    }
  }

  @override
  void initState() {


    fillList();

    _zoomPanBehavior = ZoomPanBehavior(
      // Enables pinch zooming
      enablePinching: true,
      enablePanning: true,

    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

    appBar: AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => savedproducts_a()),
          )
        },
      ),
    backgroundColor: Color(0xff104a6b),
    title: Text("Price Graph"),
    centerTitle: true,
        actions:<Widget>[

          Container(
              padding: EdgeInsets.only(right: 5,),
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => next_a()),
                  ); },
                  child: Text("NEXT",style: TextStyle(color: Colors.white,fontSize:20),),

                // Image.asset("images/addprofile.png",height: 45,width: 45,),
              )
          )]
    ),
    body:




      Container(
        // color: Colors.black,
        child: SfCartesianChart(

            // enableAxisAnimation: true,
            zoomPanBehavior: _zoomPanBehavior,
            primaryXAxis: CategoryAxis(
              majorGridLines: MajorGridLines(width: 0),
              axisLine: AxisLine(width: 0,color: Colors.red),
              maximumLabelWidth: 80,
            ),
            primaryYAxis: NumericAxis(
              //Hide the gridlines of x-axis
              majorGridLines: MajorGridLines(width: 0),
              //Hide the axis line of x-axis
              axisLine: AxisLine(width: 0),
            ),

            series: <ChartSeries<SalesData, String>>[
              LineSeries<SalesData, String>(
                  dataSource: c,
                  xValueMapper: (SalesData sales, _) => sales.year,
                  yValueMapper: (SalesData sales, _) => sales.sales
              ),
            ]
        )
    ));
  }

}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
