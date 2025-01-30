import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../services/api_service.dart';

class SpeakersPage extends StatefulWidget {
  @override
  _SpeakersPageState createState() => _SpeakersPageState();
}

class _SpeakersPageState extends State<SpeakersPage> {
  List<dynamic> speakers = [];
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    fetchSpeakers();
  }

  Future<void> fetchSpeakers() async {
    final Map<String, dynamic> jsonResponse = await apiService.fetchSpeakers();
    if (jsonResponse.isNotEmpty) {
      setState(() {
        speakers = jsonResponse['Data']['Result'];
      });
    } else {
      throw Exception('Failed to load speakers');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Speakers"),
          backgroundColor: Colors.blueGrey.shade400
      ),
      body: Column(
        children: [
          // Event Image at the top
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
                  'SPEAKERS',
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

          // Speaker List
          Expanded(
            child: speakers.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.separated(
              itemCount: speakers.length,
              itemBuilder: (context, index) {
                final speaker = speakers[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(speaker['speaker_image']),
                  ),
                  title: Text(speaker['speaker_name']),
                  subtitle: Text(speaker['speaker_designation']),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SpeakerDetailsPage(speaker: speaker),
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 10), // Space between ListTiles
            )
          ),
        ],
      ),
    );
  }
}

class SpeakerDetailsPage extends StatelessWidget {
  final dynamic speaker;

  SpeakerDetailsPage({required this.speaker});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(speaker['speaker_name']),
          backgroundColor: Colors.blueGrey.shade400
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/riyadh-loreal.png', // Replace with your image path
                  height: 150,
                ),
                SizedBox(height: 16.0),
                const Divider(
                  color: Colors.grey,
                  thickness: 2.0,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Shadow color
                      spreadRadius: 2,
                      blurRadius: 5, // Adjust blur radius as needed
                      offset: Offset(0, 3), // Offset in x and y directions
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(speaker['speaker_image']),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(speaker['speaker_designation'].replaceAll(RegExp(r'<[^>]*>'), '')),
                      SizedBox(height: 20),
                      Text(
                        speaker['speaker_name'],
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),// Replace with the content you want to have a shadow
              ),

            ),
          ),
        ],
      ),
    );
  }
}
