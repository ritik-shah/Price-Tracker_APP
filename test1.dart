import 'package:flutter/material.dart';

void main() => runApp(MyApp());

void tmpFunction() {
  print('Function Called.');

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: SafeArea(
                child: Center(
                    child: Column(children: [
                      GestureDetector(
                        onTap: tmpFunction,
                        child: Image.network(
                          'https://flutter-examples.com/wp-content/uploads/2019/09/image_button.png',
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      InkWell(
                        onTap: tmpFunction,
                        child: Image.network(
                          'https://flutter-examples.com/wp-content/uploads/2019/09/image_button.png',
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      )
                    ])))));
  }
}