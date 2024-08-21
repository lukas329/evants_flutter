import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Events"),
      ),
      body: Center(
        child: Text("Your registered events will be shown here."),
      ),
    );
  }
}
