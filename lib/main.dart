import 'package:event_app/screens/agenda_page.dart';
import 'package:event_app/screens/askQues_page.dart';
import 'package:event_app/screens/badge_page.dart';
import 'package:event_app/screens/home_page.dart';
import 'package:event_app/screens/login_page.dart';
import 'package:event_app/screens/speakers_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(EventApp());
}

class EventApp extends StatelessWidget {
  const EventApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LDB ME',
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: {
        '/Agenda': (context) => AgendaPage(),
        '/Home':(context) => HomeScreen(),
        '/Speakers':(context) => SpeakersPage(),
        '/Badge': (context) => BadgePage(),
        '/AskQuestions': (context) => AskQuestionPage()
        // ... other routes
      },
      home: LoginScreen(),
    );
  }
}


