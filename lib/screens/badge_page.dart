import 'package:flutter/material.dart';

class BadgePage extends StatelessWidget {

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.blueGrey.shade400,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/Home');
          // Implement back button functionality here
        },
      ),
      title: Text('Badge'),
    ),
    body: Column(
      children: [
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
                'BADGE',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color:Colors.blueGrey.shade700,
                ),
              ),

            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Shadow color
                  spreadRadius: 2,
                  blurRadius: 5, // Adjust blur radius as needed
                  offset: Offset(0, 3), // Offset in x and y directions
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                   'https://ldb-me.ve-live.com//QRUploader/70f20b1d-10ca-40a5-a002-b3bad864fae3_QRcode.png',// Replace with actual QR code image URL
                    width: 200,
                    height: 200,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'RIYADH 2024',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'SCAN THIS QR CODE FOR ATTENDANCE',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '"Abdul Muheeth"',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
}