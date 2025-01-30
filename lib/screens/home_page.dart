import 'package:flutter/material.dart';
import 'agenda_page.dart';
import 'badge_page.dart';
import 'speakers_page.dart';

class HomeScreen extends StatelessWidget {

  final List<Map<String, dynamic>> menuItems = [
    {'title': 'Agenda', 'icon': Icons.calendar_today_outlined, 'color': Colors.blue.shade400, 'image': 'assets/agenda.png'},
    {'title': 'Speakers', 'icon': Icons.person_outline, 'color': Colors.teal.shade200, 'image': 'assets/speakers.png'},
    {'title': 'Badge', 'icon': Icons.star_border, 'color': Colors.blueGrey.shade700, 'image': 'assets/badge.png'},
    {'title': 'Venue', 'icon': Icons.location_on_outlined, 'color': Colors.blue.shade400, 'image': 'assets/venue.png'},
    {'title': 'Brand Innovation', 'icon': Icons.image_outlined, 'color': Colors.teal.shade200, 'image': 'assets/venue.png'},
    {'title': 'Brand Videos', 'icon': Icons.play_circle_outline, 'color': Colors.blueGrey.shade700, 'image': 'assets/videos.png'},
    {'title': 'AskQuestions', 'icon': Icons.question_answer_outlined, 'color': Colors.blue.shade400, 'image': 'assets/questions.png'},
    {'title': 'Voting', 'icon': Icons.poll_outlined, 'color':  Colors.teal.shade200, 'image': 'assets/voting.png'},
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: menuItems.map((item) {
            return _buildMenuItem(context, item['title'], item['image'], item['color']);
          }).toList(),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.home,color: Colors.grey),
              title: Text('Home'),
              onTap: () {
                // Navigate to the home screen
                Navigator.pop(context); // Close the drawer
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Agenda'),
              onTap: () {
                // Navigate to the agenda screen
                Navigator.pop(context);
                Navigator.pushNamed(context, '/Agenda');
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Speakers'),
              onTap: () {
                // Navigate to the speakers screen
                Navigator.pop(context);
                Navigator.pushNamed(context, '/Speakers');
              },
            ),
            ListTile(
              leading: Icon(Icons.qr_code),
              title: Text('Badge'),
              onTap: () {
                // Navigate to the badge screen
                Navigator.pop(context);
                Navigator.pushNamed(context, '/Badge');
              },
            ),
            ListTile(
              leading: Icon(Icons.map),
              title: Text('Venue'),
              onTap: () {
                // Navigate to the venue screen
                Navigator.pop(context);
                Navigator.pushNamed(context, '/Venue');
              },
            ),
            ListTile(
              leading: Icon(Icons.image),
              title: Text('Brand Innovation'),
              onTap: () {
                // Navigate to the brand innovation screen
                Navigator.pop(context);
                Navigator.pushNamed(context, '/BrandInnovation');
              },
            ),
            ListTile(
              leading: Icon(Icons.play_circle_fill),
              title: Text('Brand Videos'),
              onTap: () {
                // Navigate to the brand videos screen
                Navigator.pop(context);
                Navigator.pushNamed(context, '/BrandVideos');
              },
            ),
            ListTile(
              leading: Icon(Icons.question_answer),
              title: Text('Ask Questions'),
              onTap: () {
                // Navigate to the ask questions screen
                Navigator.pop(context);
                Navigator.pushNamed(context, '/AskQuestions');
              },
            ),
            ListTile(
              leading: Icon(Icons.poll),
              title: Text('Voting'),
              onTap: () {
                // Navigate to the voting screen
                Navigator.pop(context);
                Navigator.pushNamed(context, '/Voting');
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Social Media'),
              onTap: () {
                // Navigate to the social media screen
                Navigator.pop(context);
                Navigator.pushNamed(context, '/SocialMedia');
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Survey'),
              onTap: () {
                // Navigate to the survey screen
                Navigator.pop(context);
                Navigator.pushNamed(context, '/Survey');
              },
            ),
            ListTile(
              leading: Icon(Icons.school),
              title: Text('CME'),
              onTap: () {
                // Navigate to the CME screen
                Navigator.pop(context);
                Navigator.pushNamed(context, '/CME');
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildMenuItem(BuildContext context, String title, String imagePath, Color color) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Card(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
      ),
      child: InkWell(
        onTap: () {
          // Navigate to the corresponding screen
          Navigator.pushNamed(context, '/$title');
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, width: 160, height: 160), // Use Image.asset to display the image
            //SizedBox(height: 10.0),
            /*Text(
              title,
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),*/
          ],
        ),
      ),
    ),
  );
}
