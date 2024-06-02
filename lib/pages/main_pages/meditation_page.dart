import 'package:flutter/material.dart';

class MeditationPage extends StatelessWidget {
  const MeditationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meditation Page'),
      ),
      body: Center(
        child: Text('This is the Meditation Page!'),
      ),
    );
  }
}
