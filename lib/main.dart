import 'package:flutter/material.dart';
import 'package:tokoonline/launcher.dart';
import 'package:tokoonline/users/landing.dart' as users; // Ensure the import path is correct

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // If your Flutter version does not support `useMaterial3`, you can remove it.
        // useMaterial3: true, 
      ),
      home: LauncherPage(),
      routes: <String, WidgetBuilder>{ // Correct routes declaration
        '/keranjangusers': (BuildContext context) => users.LandingPage(nav:'2'),
      },
    );
  }
}
