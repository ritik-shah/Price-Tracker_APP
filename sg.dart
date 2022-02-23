import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:aaa/viewfeedback.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(sg_a());
}
class sg_a extends StatelessWidget {
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
  final TextEditingController c_feedback = TextEditingController();

  late ZoomPanBehavior _zoomPanBehavior;


  @override
  void initState(){
    _zoomPanBehavior = ZoomPanBehavior(
      // Enables pinch zooming
        enablePinching: true,
      enablePanning: true,

    ); fillList();
    super.initState();
  }
  final List<ChartData> chartData=<ChartData>[];
  List<String> pbid = <String>[];
  List<String> pr_date = <String>[];
  List<String> pr_amt = <String>[];
  List<String> pr_time = <String>[];

  Future<void> fillList() async {
    // Fill the list with links
    // var json = jsonDecode(
    //     (await http.get(Uri.parse("https://picsum.photos/v2/list?limit=40"))).body);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? m  = prefs.getString("lid") ;
    final response = await http.post(
      Uri.parse('http://192.168.43.166:8000/viewprevprice'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{

        'lid':'2'
      }),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      setState(() {
        Map<String, dynamic> item;
        var data= json['data'];

        //   ChartData(2010, 35),
        //   ChartData(2011, 28),
        //   ChartData(2012, 34),
        //   ChartData(2013, 32),
        //   ChartData(2014, 40),
        //   ChartData(2015, 11),
        //   ChartData(2016, 12),
        //   ChartData(2017, 12),
        //   ChartData(2018, 14),
        //   ChartData(2019, 15),
        //   ChartData(2020, 16),
        //   ChartData(2021, 17),
        //   ChartData(2022, 18),
        //   ChartData(2023, 19),
        //   ChartData(2024, 20),
        //   ChartData(2025,22),
        //   ChartData(2026, 24),
        //
        // ];

        int aa=1;
        int m=1;

        for (item in data) {
         var a= item['pbid'].toString();
         var b= item['pr_date'];
         int c=  int.parse(item['pr_amt'].toString());
         var d= item['pr_time'].toString();

         print(b);
          print(c);
          chartData.add(ChartData(m,c));
          m=m+1;
          aa++;
        }
      });
    }
  }







  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        body: Center(
            child: Container(
                child:


                Container(
                  // height: 300,
                  // width: 300,
                  child:SfCartesianChart(
                    zoomPanBehavior: _zoomPanBehavior,
                      enableAxisAnimation: true,

                    series: <ChartSeries>[
                      // Renders line chart
                      LineSeries<ChartData, int>(
                          dataSource: chartData,
                          xValueMapper: (ChartData sales, _) => sales.year,
                          yValueMapper: (ChartData sales, _) => sales.sales
                      )
                    ]
                )
            )
        )
        ));
  }


}
class ChartData {
  ChartData(this.year, this.sales);
  final int year;
  final int sales;
}