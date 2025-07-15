import 'package:flutter/material.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rewards'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Text(
          'Rewards Screen UI will come here!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
