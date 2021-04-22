import 'package:flutter/material.dart';

// void main() {

//  return runApp(MaterialApp(  
//    home : Login(),  
//      routes: {
//        'login' : (context) => Login(),
//        'SecondRoute' : (context) =>SecondRoute(),
//      },
//  ));

//   // runApp(Login());
// }

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  
  final _username = TextEditingController();
  final _password = TextEditingController();

  bool _validateUsername = false;
  bool _validatePassword = false;


  // Function Alert Box
  Future<void> _showMyDialog(String titile ,String message) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Information'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(titile),
              Text(message),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,         
          title: Text("Login"),
          centerTitle: true,
          ),     
      
      body: ListView(
        
        children:<Widget> [
          Container(
           height: MediaQuery.of(context).size.height * 0.2,
           padding: const EdgeInsets.fromLTRB(100,20,100,10),
           child: Image(image: AssetImage('assets/images/profile.jpg'),),
          ),

          Container(
            padding: const EdgeInsets.fromLTRB(20,20,20,20),
            child: TextField(decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            labelText: 'Email',
            errorText: _validateUsername?'Email can not be null':null
              
            ),
             controller: _username,
            ),
          ),

           Container(
            padding: const EdgeInsets.fromLTRB(20,0,20,0),
            child: TextField(           
              obscureText: true,
              decoration: InputDecoration(                             
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              labelText: 'Password',  
              errorText: _validatePassword?'Password can not be null':null          
            ),
            controller: _password,
            ),
          ),

          Container(        
             // ignore: deprecated_member_use
             child: FlatButton(
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
             child: Text('Forget password',style: TextStyle(fontSize: 15,color: Colors.black),),          
             onPressed: (){},
            ),
          ),

          Container(
             height: 50,
             padding: const EdgeInsets.fromLTRB(20,0,20,0),
             child: ElevatedButton (       
                child: Text('Login',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),        
                onPressed: (){

               Navigator.pushNamed(context, 'home');

              //  setState(() {
              //    _username.text.isEmpty?_validateUsername = true: _validateUsername = false;
              //    _password.text.isEmpty?_validatePassword = true:_validatePassword = false;

              //    if(_validateUsername && _validatePassword){
              //      return;
              //    }
              //    else{
              //      if(_username.text == 'jackie' && _password.text == '123456'){
              //         Navigator.pushNamed(context, 'home');
              //      }
              //      else{
              //           _showMyDialog('','Username and Password is incorrect! Please try again');
              //      } // else
              //    }
              //  });

            

             },
            ),
          ),
        ],
      ) ,   
      ),
    );
  }
}
