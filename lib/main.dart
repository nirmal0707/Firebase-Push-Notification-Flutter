import 'package:flutter/material.dart';

import 'myhomepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Push Notifications',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryTextTheme:
            TextTheme(headline6: TextStyle(fontWeight: FontWeight.bold)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Firebase Push Notifications'),
    );
  }
}
