import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return 
          Center(child:Container(
            padding: EdgeInsets.all(16.0),
            child: ListView(
             children:<Widget> [
              Center(
                child:  CircleAvatar(
                          backgroundImage:
                          AssetImage('assets/images/profile.jpg'),
                          radius: 50.0,
                    ),
              ),

             Padding(padding: EdgeInsets.fromLTRB(0, 10,0 , 10),
             child: Text("I am Jackie", style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold, color: Colors.black,),textAlign: TextAlign.center),
             ),
             Padding(padding: EdgeInsets.fromLTRB(0, 10,0 , 10),
             child: Text("I created this project 'Expense' for share the knowledge ", style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold, color: Colors.black,),textAlign: TextAlign.center),
             ),
             ], 
            ),
          ));
    
  }
}