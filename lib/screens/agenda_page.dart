import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

import '../services/api_service.dart';

class AgendaPage extends StatefulWidget {
  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  bool isDay1 = true;
  List<dynamic> agendaItems = [];
  bool isLoading = true;
  final ApiService apiService = ApiService();
  List<AgendaItem> agenda = [];
  bool isDay1Selected = true;

  @override
  void initState() {
    super.initState();
    fetchAgendaData();
  }

  Future<void> fetchAgendaData() async {
    setState(() {
      isLoading = true;
    });
    final Map<String, dynamic> jsonResponse = await apiService.fetchAgenda();
    await Future.delayed(Duration(seconds: 2));
    if (jsonResponse.isNotEmpty) {
      setState(() {
        agendaItems = jsonResponse['Data']['Result'] ?? [];
        agenda = agendaItems.map((item) => AgendaItem.fromJson(item)).toList();
       isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load agenda');
    }
  }


  String formatTime(String? time) {
    if (time == null || time.isEmpty) return "TBA";

    try {
      DateTime parsedTime = DateFormat("HH:mm:ss").parse(time);  // Example: "14:30:00"
      return DateFormat("hh:mm a").format(parsedTime);  // Converts to "02:30 PM"
    } catch (e) {
      return time; // If parsing fails, return the original time
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade400,
        title: Text("Agenda"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/Home');
          },
        ),
      ),
      body: SingleChildScrollView( // Add SingleChildScrollView for scrollable content
        child: Column(
          children: [
            // Add Image and Title
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/riyadh-loreal.png', // Replace with your image path
                    height: 100,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'AGENDA',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color:Colors.blueGrey.shade700,
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 2.0,
                  )
                ],
              ),
            ),

            ToggleButtons(
                selectedColor:Colors.blueGrey.shade700,
                borderRadius:BorderRadius.circular(8),
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Day 1 - Saturday'),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Day 2 - Sunday'),
                ),
              ],
              isSelected: [isDay1Selected, !isDay1Selected],
              onPressed: (int index) {
                setState(() {
                  isDay1Selected = index == 0;
                });
              },
            ),
            SizedBox( height: 10,),
            isLoading
                ? CircularProgressIndicator()
                :Container(
              color: Colors.grey,
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(28.0, 0, 28, 0),
                    child: Text(
                        'Time',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                    ),
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text(
                        'Details',textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.7, // Adjust height as needed
              child: ListView.builder(
                shrinkWrap: true, // Essential for proper layout
                itemCount: agenda.length,
                itemBuilder: (context, index) {
                  final item = agenda[index];
                  if ((isDay1Selected && item.day == '1') ||
                      (!isDay1Selected && item.day == '2')) {
                    return Container(
                      color: item.day == '1' ? Colors.green[50] : Colors.blue[50],
                      child: ListTile(
                        title: Row(
                          children: [
                            Text(item.time), // Title
                            SizedBox(width: 16.0),
                            SizedBox(
                              width: 200, // Set a maximum width for the Text
                              child: Text(item.topic, style: TextStyle(color: Colors.grey)),
                            ),// Spacing// Subtitle
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

  class AgendaItem {
  int id;
  String title;
  String date;
  String time;
  String topic;
  String speaker_name;
  String day;

  AgendaItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
  title = json['Title'],
  date = json['date'],
  time = json['time'],
  topic = json['topic'],
  speaker_name = json['speaker_name'],
  day = json['day'];
  }
