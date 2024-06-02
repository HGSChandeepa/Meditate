import 'package:flutter/material.dart';

class CreateMeditationPage extends StatelessWidget {
  const CreateMeditationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Meditation Page'),
      ),
      body: Center(
        child: Text('This is the Create Meditation Page!'),
      ),
    );
  }
}
