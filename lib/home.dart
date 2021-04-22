import 'package:expenses/widgets/about.dart';
import 'package:expenses/widgets/report.dart';
import 'package:expenses/widgets/setting.dart';
import 'package:flutter/material.dart';
import 'models/service.dart';
import 'my_home_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ignore: non_constant_identifier_names
  final dynamic page_list = [
    MyHomePage(),
    ReportPage(),
    Setting(),
    About(),
  ];
  //Variables
  int _selectedIndex = 0;
  // ignore: non_constant_identifier_names
  List<String> title_page = ['Home', 'Report', 'Setting', 'About'];
  String userName = 'Jackie Lenkhen';
  //Function
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Colors.pink,
      title: Text(
        title_page[_selectedIndex],
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      ),
      actions: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.search,
                size: 26.0,
              ),
            )),
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(Icons.more_vert),
            )),
      ],
    );
    final bottomNavigationBar = BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: Colors.pink,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.article_outlined),
          label: 'Report',
          backgroundColor: Colors.purple,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
          backgroundColor: Colors.red,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: 'About',
          backgroundColor: Colors.green,
        ),
      ],
      currentIndex: _selectedIndex,
      //selectedItemColor: Colors.amber[10],
      selectedItemColor: Colors.yellowAccent,
      onTap: _onItemTapped,
    );

    setState(() {
      Service.appBarHeight = appBar.preferredSize.height;
      Service.bottomNavigationBarHeight = appBar.preferredSize.height;
      Service.paddingTop = MediaQuery.of(context).padding.top;
    });

    return Scaffold(
        appBar: appBar,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.pink,
                ),
                child: ListView(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/profile.jpg'),
                        radius: 50,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            userName,
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                        )),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  _onItemTapped(0);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.article),
                title: Text('Reprot'),
                onTap: () {
                  _onItemTapped(1);
                  Navigator.of(context).pop();
                },
              ),
               ListTile(
                leading: Icon(Icons.settings),
                title: Text('Setting'),
                onTap: () {
                  _onItemTapped(2);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About'),
                onTap: () {
                  _onItemTapped(3);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
        body: Center(child: page_list[_selectedIndex]
            // _widgetOptions.elementAt(_selectedIndex),
            ),
        bottomNavigationBar: bottomNavigationBar);
  }
}
