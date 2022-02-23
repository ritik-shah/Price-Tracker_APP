import 'package:flutter/material.dart';

void main() {
  runApp(pr_search_results_a());
}
class pr_search_results_a extends StatelessWidget {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text("Search Results"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 100,right: 100,top: 15),
            child: Text('Image'),
          ),
          Container(
            padding:EdgeInsets.only(left: 100,right: 100,top: 15),
            child: Text('Product Name'),
          ),
          Container(
            padding: EdgeInsets.only(left: 100,right: 100,top: 15),
            child: Text('Product Price'),
          ),
          Container(
            padding: EdgeInsets.only(left: 100,right: 100,top: 15),
            child: Text('GRAPH'),
          ),
          Container(
            padding: EdgeInsets.only(left: 100,right: 100,top: 15),
            child: ButtonTheme(
              buttonColor: Colors.orangeAccent,
              minWidth: double.infinity,
              height: 50.0,
              child: RaisedButton(
                child: Text('SET TARGET'),
                onPressed: (){},
              ),
            ),
          ),
        ],
      ),
    );
  }
}