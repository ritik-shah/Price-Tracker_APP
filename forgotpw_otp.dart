import 'package:aaa/login.dart';
import 'package:aaa/mainmenu.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(forgotpw_otp_a());
}
class forgotpw_otp_a extends StatelessWidget {
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
  final TextEditingController c_otp =  TextEditingController();
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
              MaterialPageRoute(builder: (context) => login_a()),
            )
          },
        ),
        title: Text("OTP VERIFICATION"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
    child:Column(
        children: <Widget>[
          Container(
            child: Text('We have sent you OTP in your mobile and Email'),
          ),
          Container(
            padding: EdgeInsets.only(left: 100,right: 100,top: 15),
            child: TextField(
              controller: c_otp,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter OTP"
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 100,right: 100,top: 15),
            child: ButtonTheme(
              buttonColor: Colors.orangeAccent,
              minWidth: double.infinity,
              height: 50.0,
              child: RaisedButton(
                child: Text('Validate'),
                onPressed: (){
                  var var_otp=c_otp.text.toString();

                },
              ),
            ),
          )
        ],
      ),
      ),
    );
  }
}