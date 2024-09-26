import 'package:flutter/material.dart';

class AkunPage extends StatefulWidget {
  @override
  State<AkunPage> createState() => _AkunPage();
}

class _AkunPage extends State<AkunPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Profil'),
      ),
      body: Center(
        child: const Text(
          'AkunPage',
        ),
      ),
    );
  }
}