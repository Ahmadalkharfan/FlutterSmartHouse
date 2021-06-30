import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth.dart';

class Album {
  final int userId;
  final int id;
  final String title;

  Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'My Home';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final AuthService _auth = AuthService();
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Scene',
      style: optionStyle,
    ),
    Text(
      'Index 2: Add',
      style: optionStyle,
    ),
    Text(
      'Index 3: Messages',
      style: optionStyle,
    ),
    Text(
      'Index 4: Profile',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  bool _iswifiOn = true;
  bool _islightOn = true;
  bool _isfridgeOn = true;
  bool _isacOn = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('My Home'),
                centerTitle: false,
                bottom: TabBar(
                  tabs: [
                    Tab(
                      text: "All",
                    ),
                    Tab(text: "Livingroom"),
                    Tab(text: "Kitchen"),
                  ],
                ),
              ),
              body: (GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: Image.network(
                          'https://i3.wp.com/tridenstechnology.com/wp-content/uploads/2019/07/Smart-home.png')),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: RaisedButton(
                      child: Text('Sign in'),
                      onPressed: () async {
                        dynamic result = await _auth.signInAnon();
                        if (result == null) {
                          print('error');
                        } else {
                          print('signed in');
                          print(result);
                        }
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      // add Column
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('WIFI',
                            style: TextStyle(
                                // your text
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        Icon(
                          _iswifiOn == true
                              ? Icons.settings_power_sharp
                              : Icons.signal_wifi_4_bar,
                          size: 50,
                        ),
                        RaisedButton(
                          onPressed: () {
                            setState(() {
                              _iswifiOn = !_iswifiOn;
                            });
                          },
                          child: Text(
                            _iswifiOn == true ? "OFF" : "ON",
                          ),
                        ), // your button beneath text
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      // add Column
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Lights',
                            style: TextStyle(
                                // your text
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        Icon(
                          _islightOn == true
                              ? Icons.settings_power_sharp
                              : Icons.light,
                          size: 50,
                        ),
                        RaisedButton(
                          onPressed: () {
                            setState(() {
                              _islightOn = !_islightOn;
                            });
                          },
                          child: Text(
                            _islightOn == true ? "OFF" : "ON",
                          ),
                        ), // your button beneath text
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      // add Column
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Fridge',
                            style: TextStyle(
                                // your text
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        Icon(
                          _isfridgeOn == true
                              ? Icons.settings_power_sharp
                              : Icons.kitchen,
                          size: 50,
                        ),
                        RaisedButton(
                          onPressed: () {
                            setState(() {
                              _isfridgeOn = !_isfridgeOn;
                            });
                          },
                          child: Text(
                            _isfridgeOn == true ? "OFF" : "ON",
                          ),
                        ), // your button beneath text
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      // add Column
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('AC',
                            style: TextStyle(
                                // your text
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        Icon(
                          _isacOn == true
                              ? Icons.settings_power_sharp
                              : Icons.ac_unit,
                          size: 50,
                        ),
                        RaisedButton(
                          onPressed: () {
                            setState(() {
                              _isacOn = !_isacOn;
                            });
                          },
                          child: Text(
                            _isacOn == true ? "OFF" : "ON",
                          ),
                        ), // your button beneath text
                      ],
                    ),
                  ),
                ],
              )),
              bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                    backgroundColor: Colors.red,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.auto_awesome_motion_outlined),
                    label: 'Scene',
                    backgroundColor: Colors.green,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.local_hospital),
                    label: 'Add',
                    backgroundColor: Colors.green,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.message),
                    label: 'Messages',
                    backgroundColor: Colors.purple,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                    backgroundColor: Colors.pink,
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.amber[800],
                onTap: _onItemTapped,
              ),
            )));
  }
}
