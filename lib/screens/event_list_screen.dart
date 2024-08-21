import 'package:flutter/material.dart';
import 'package:evants_flutter/services/api_service.dart';
import 'package:evants_flutter/services/event.dart';

class EventListScreen extends StatelessWidget {
  final String token;
  final ApiService apiService = ApiService();

  EventListScreen({required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Events')),
      body: FutureBuilder<List<Event>>(
        future: apiService.fetchEvents(token),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final events = snapshot.data!;
            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return ListTile(
                  title: Text(event.title),
                  subtitle: Text(event.description),
                  onTap: () {
                    // Handle event tap, maybe navigate to a detail screen
                  },
                );
              },
            );
          } else {
            return Center(child: Text('No events found'));
          }
        },
      ),
    );
  }
}
