import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AskQuestionPage extends StatefulWidget {
  @override
  _AskQuestionPageState createState() => _AskQuestionPageState();
}

class _AskQuestionPageState extends State<AskQuestionPage> {
  final TextEditingController _sessionController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _questionController = TextEditingController();
  String? selectedSpeaker;
  List<String> speakers = [];

  @override
  void initState() {
    super.initState();
    fetchSpeakers();
  }

  Future<void> fetchSpeakers() async {
    const String apiUrl = "https://ldb-me.ve-live.com/api/AdminApiProvider/LoadSpeakers?EventId=1";

    try {
      final response = await http.post(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        // Check if 'Data' and 'Result' keys exist
        if (data is Map<String, dynamic> &&
            data.containsKey("Data") &&
            data["Data"].containsKey("Result") &&
            data["Data"]["Result"] is List) {
          setState(() {
            speakers = (data["Data"]["Result"] as List<dynamic>)
                .map((speaker) => speaker["speaker_name"].toString())
                .toList();
          });
        } else {
          print("Unexpected response format");
        }
      } else {
        print("Failed to load speakers, status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching speakers: $e");
    }
  }

  Future<void> _submitQuestion() async {
    final String apiUrl = "https://ldb-me.event-loreal.com/api/AdminApiProvider/AskQuestion";

    Map<String, dynamic> requestBody = {
      "SpeakerName": _sessionController.text.trim(),
      "AskedBy": _nameController.text.trim(),
      "QuestionDetail": _questionController.text.trim(),
      "EventId": 1
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        _showDialog("Success", "Your question has been submitted.");
      } else {
        _showDialog("Error", "Failed to submit question. Please try again.");
      }
    } catch (e) {
      _showDialog("Error", "An error occurred: $e");
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade400,
        title: Text("Ask Question"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/riyadh-loreal.png', // Replace with your image path
                      height: 100,
                    ),
                    SizedBox(height: 10),
                    Text("ASK QUESTION",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color:Colors.blueGrey.shade700,
                        )
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 2.0,
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              _buildDropdown(),
              SizedBox(height: 10),
              _buildTextField("Your Name", _nameController),
              SizedBox(height: 10),
              _buildTextField("Ask Question", _questionController, maxLines: 3),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _submitQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade300,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.blue[50],
      ),
    );
  }

  Widget _buildDropdown() {
    return SizedBox(
      width: double.infinity, // Takes full width available
      child: DropdownButton<String>(
        isExpanded: true, // Prevents overflow
        value: selectedSpeaker,
        hint: Text("Select a speaker"),
        onChanged: (String? newValue) {
          setState(() {
            selectedSpeaker = newValue;
          });
        },
        items: speakers.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              overflow: TextOverflow.ellipsis, // Trims long names
            ),
          );
        }).toList(),
      ),
    );
  }

}