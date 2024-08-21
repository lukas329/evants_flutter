import 'package:evants_flutter/screens/results_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchPage extends StatefulWidget {
  final String token;

  SearchPage({required this.token});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<dynamic> sports = [];
  String? selectedSportId;
  TextEditingController cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchSports();
  }

  Future<void> fetchSports() async {
    final url = Uri.parse('http://192.168.1.15:8000/api/sports');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${widget.token}',  // Include the token in the Authorization header
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        sports = json.decode(response.body);
      });
    } else {
      print('Failed to load sports: ${response.statusCode}');
    }
  }

  void searchEvents() {
    if (selectedSportId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsPage(
            city: cityController.text,
            sportId: selectedSportId!,
            token: widget.token,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a sport')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Events')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: cityController,
              decoration: InputDecoration(labelText: 'City'),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedSportId,
              onChanged: (value) {
                setState(() {
                  selectedSportId = value;
                });
              },
              items: sports.map<DropdownMenuItem<String>>((sport) {
                return DropdownMenuItem<String>(
                  value: sport['id'].toString(),
                  child: Text(sport['name']),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Select Sport',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: searchEvents,
              child: Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}
