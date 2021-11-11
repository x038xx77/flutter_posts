import 'package:flutter/material.dart';

class About extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Title of About Page"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Close'),
          onPressed: () {
            // Close page
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.cyan[100],
    );
  }
}