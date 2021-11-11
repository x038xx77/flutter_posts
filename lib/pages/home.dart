import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            child: Text('Go to Details Page'),
            onPressed: () {
              Navigator.of(context).pushNamed('/details');
            },
          ),
          ElevatedButton(
            child: Text('Go to About Page'),
            onPressed: () {
              Navigator.of(context).pushNamed('/about');
            },
          ),
          ElevatedButton(
            child: Text('Go to Auth Login'),
            onPressed: () {
              Navigator.of(context).pushNamed('/auth');
            },
          ),
        ],
      )),
    );
  }
}
