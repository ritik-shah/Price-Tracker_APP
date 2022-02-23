// import 'package:aaa/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aaa/changepw.dart';
import 'package:aaa/editprofile.dart';
import 'package:aaa/login.dart';
import 'package:aaa/pr_search.dart';
import 'package:aaa/savedproducts.dart';
import 'package:aaa/sendcomplaint.dart';
import 'package:aaa/sendfeedback.dart';
import 'package:aaa/view_saved_products.dart';
import 'package:aaa/viewcomplaint.dart';
import 'package:aaa/viewfeedback.dart';
import 'package:aaa/viewprofile.dart';

void main() {
  runApp(mainmenu_a());
}
class mainmenu_a extends StatelessWidget {
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
        backgroundColor: Color(0xff104a6b),
        title: Text("Price Tracker"),
        centerTitle: true,

        actions:<Widget>[

          Container(
            padding: EdgeInsets.only(right: 10,top: 5),
          child: GestureDetector(
          onTap: () {

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => viewprofile_a()),
            );

          },
          child: Icon(CupertinoIcons.profile_circled,color: Colors.white,size: 35.0,)

          // Image.asset("images/addprofile.png",height: 45,width: 45,),
          )
          )]

      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Image.asset("images/pt logo.jpg",height: 130,)
              ),
              decoration: BoxDecoration(
                color: Colors.black,
              ),
            ),
            ListTile(
              leading: Icon(Icons.search_sharp,color: Color(0xff104a6b),),
              title: Text('Search'),
              onTap: () => {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => pr_search_a()),
              )
              },
            ),

            ListTile(
              leading: Icon(Icons.folder_special_outlined,color: Color(0xff8B9A46),),
              title: Text('View Saved Products'),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => savedproducts_a()),
                )
              },
            ),

            // ListTile(
            //   leading: Icon(Icons.shopping_cart),
            //   title: Text('Edit Profile'),
            //   onTap: () => {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => editprofile_a()),
            //     )
            //   },
            // ),
            ListTile(
              leading: Icon(Icons.feedback_outlined,color: Color(0xffFFA41B),),
              title: Text('Send Feedback'),
              onTap: () => {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => sendfeedback_a()),
              )
              },
            ),
            ListTile(
              leading: Icon(Icons.report_problem_outlined,color: Color(0xff993D9A),),
              title: Text('Send Complaint'),
              onTap: () => {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => sendcomplaint_a()),
              )
              },
            ),

            ListTile(
              leading: Icon(Icons.account_circle_outlined,color: Color(0xff086E7D),),
              title: Text('View Profile'),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => viewprofile_a()),
                )
              },
            ),



            ListTile(
              leading: Icon(Icons.view_array_outlined,color: Color(0xffFF7315),),
              title: Text('View Feedback'),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => viewfeedback_a()),
                )
              },
            ),


            ListTile(
              leading: Icon(Icons.reviews_outlined,color: Color(0xff0B4619),),
              title: Text('View Complaints'),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => viewcomplaints_a()),
                )
              },
            ),

            ListTile(
              leading: Icon(Icons.password_outlined,color: Color(0xffA68DAD),),
              title: Text('Change Password'),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => changepw_a()),
                )
              },
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined,color: Color(0xffDA1212),),
              title: Text('Logout'),
              onTap: () => {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => login_a()),
              )
              },
            ),



          ],
        ),
      ),


      body:  GridView.count(
              primary: false,
              padding: const EdgeInsets.all(15),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[

                Card(

                  color: Color(0xff104a6b),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 10,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(8),
                        child:GestureDetector(
                          child: Image.asset("images/search1.png",height: 130,),
                          onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => pr_search_a()),
                    );
                  },),
                  

    ),
                  Text("Search",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),)
                  
                  
                  ],),),
                Card(
                  color: Color(0xff104a6b),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 10,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(8),
                        child:GestureDetector(
                          child: Image.asset("images/saved4.png",height: 130,),
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => savedproducts_a()),
                            );
                          },),


                      ),
                      Text("View Saved Products",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),)


                    ],),),
                Card(
                  color: Color(0xff104a6b),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 10,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(8),
                        child:GestureDetector(
                          child: Image.asset("images/complaint.png",height: 130,),
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => sendcomplaint_a() ),
                            );
                          },),


                      ),
                      Text("Send Complaint",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),)


                    ],),),
                Card(
                  color: Color(0xff104a6b),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 10,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(8),
                        child:GestureDetector(
                          child: Image.asset("images/feedback.png",height: 130,),
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => sendfeedback_a()),
                            );
                          },),


                      ),
                      Text("Send Feedback",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),)


                    ],),),
                Card(
                  color: Color(0xff104a6b),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 10,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(8),
                        child:GestureDetector(
                          child: Image.asset("images/viewcmp.png",height: 130,),
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => viewcomplaints_a()),
                            );
                          },),


                      ),
                      Text("View Complaint",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),)


                    ],),),
                Card(
                  color: Color(0xff104a6b),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 10,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(8),
                        child:GestureDetector(
                          child: Image.asset("images/fdbk.png",height: 130,),
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => viewfeedback_a()),
                            );
                          },),


                      ),
                      Text("View Feedback",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),)


                    ],),),
                Card(
                  color: Color(0xff104a6b),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 10,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(8),
                        child:GestureDetector(
                          child: Image.asset("images/changepw1.png",height: 130,),
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => changepw_a()),
                            );
                          },),


                      ),
                      Text("Change Password",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:Colors.white),)


                    ],),),
                Card(
                  color: Color(0xff104a6b),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 10,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(8),
                        child:GestureDetector(
                          child: Image.asset("images/logout1.png",height: 130,),
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => login_a()),
                            );
                          },),


                      ),
                      Text("Logout",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),)


                    ],),),
              ],
            ),


    );
  }
}