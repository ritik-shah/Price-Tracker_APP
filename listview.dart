import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'View Saved Products',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> images = [
    "assets/images/scenary.jpg",
    "assets/images/scenary_red.jpg",
    "assets/images/waterfall.jpg",
    "assets/images/tree.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Saved Products"),
        ),
        body: ListView.separated(
          itemBuilder: (BuildContext, index){
            return ListTile(
              leading: CircleAvatar(backgroundImage: AssetImage(images[index]),),
              title: Text("This is title"),
              subtitle: Text("Title 2"),
              // subtitle: Text("This is subtitle"),
            );
          },
          separatorBuilder: (BuildContext,index)
          {
            return Divider(height: 20);
          },
          itemCount: images.length,
          shrinkWrap: true,
          padding: EdgeInsets.all(5),
          scrollDirection: Axis.vertical,
        )
    );
  }
}