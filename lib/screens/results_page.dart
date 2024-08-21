import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResultsPage extends StatefulWidget {
  final String city;
  final String sportId;
  final String token;

  ResultsPage({required this.city, required this.sportId, required this.token});

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  List<dynamic> events = [];

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    final url = Uri.parse('http://192.168.1.15:8000/api/events?location=${widget.city}&sport_id=${widget.sportId}');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${widget.token}',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        events = json.decode(response.body);
      });
    } else {
      print('Failed to load events: ${response.statusCode}');
      print('Response: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Results"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(events[index]['title'] ?? 'No Title'),
              subtitle: Text("${events[index]['location']} - ${events[index]['sport']['name']}"),
              onTap: () {
                // Handle event tap, navigate to event details if needed
              },
            ),
          );
        },
      ),
    bottomNavigationBar: BottomNavigationBar(
      backgroundColor: Colors.blueAccent, // Set a darker background color
      selectedItemColor: Colors.white10,  // Color for the selected item
      unselectedItemColor: Colors.white70, // Color for unselected items
      items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search', backgroundColor: Colors.blueAccent),
      BottomNavigationBarItem(icon: Icon(Icons.event), label: 'My Events', backgroundColor: Colors.blueAccent),
      BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages', backgroundColor: Colors.blueAccent),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile', backgroundColor: Colors.blueAccent),
      ],
      onTap: (index) {
      // Handle navigation based on index
      switch (index) {
      case 0:
      // Navigate to Search Page (current page)
      break;
      case 1:
      Navigator.pushNamed(context, '/myEvents');
      break;
      case 2:
      Navigator.pushNamed(context, '/messages');
      break;
      case 3:
      Navigator.pushNamed(context, '/profile');
      break;
      }
      }
      )
    );
  }
}
