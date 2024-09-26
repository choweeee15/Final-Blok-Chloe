import 'package:flutter/material.dart';

class KeranjangPage extends StatefulWidget {
  @override
  State<KeranjangPage> createState() => _KeranjangPage();
}

class _KeranjangPage extends State<KeranjangPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Keranjang'),
      ),
      body: Center(
        child: const Text(
          'KeranjangPage',
        ),
      ),
    );
  }
}