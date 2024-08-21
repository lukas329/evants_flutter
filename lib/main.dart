import 'package:evants_flutter/screens/messages_page.dart';
import 'package:evants_flutter/screens/my_events_page.dart';
import 'package:evants_flutter/screens/profile_page.dart';
import 'package:evants_flutter/screens/search_page.dart';
import 'package:flutter/material.dart';
import 'package:evants_flutter/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Evants Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      routes: {
        '/myEvents': (context) => MyEventsPage(),
        '/messages': (context) => MessagesPage(),
        '/profile': (context) => ProfilePage(),
      },// Set the initial screen directly here
    );
  }
}
