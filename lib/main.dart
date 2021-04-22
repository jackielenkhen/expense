import 'package:flutter/material.dart';
import 'home.dart';
import 'login.dart';


void main(){
  return runApp(MaterialApp(
        routes: {
         'login' : (context) => Login(),
         'home' : (context) => Home(),
        },  
        home: App(),
  ));
}


class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {   
    super.initState();
   Future.delayed(Duration(seconds: 3), () {
      Navigator.pushNamed(context, 'login');
  
  }
  );  
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget> [
          Container(
            decoration: BoxDecoration(

            ),
           child : Image(image: AssetImage('assets/images/profile.jpg',),fit: BoxFit.cover,),
          )
        ],      
      ),
    );
  }
}