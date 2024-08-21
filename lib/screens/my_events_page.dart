import 'package:flutter/material.dart';

class MyEventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Events"),
      ),
      body: Center(
        child: Text("Your registered events will be shown here."),
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
