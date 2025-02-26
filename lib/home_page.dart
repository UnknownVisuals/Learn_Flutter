import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: const Text('Nama: Reynaldhi'),
              subtitle: const Text('Hobi: Membaca'),
              tileColor: Colors.deepPurpleAccent.withValues(alpha: 0.1),
            ),
          ],
        ),
      ),
    );
  }
}
