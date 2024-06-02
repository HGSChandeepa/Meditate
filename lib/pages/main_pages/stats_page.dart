import 'package:flutter/material.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stats Page'),
      ),
      body: Center(
        child: Text('This is the Stats Page!'),
      ),
    );
  }
}
