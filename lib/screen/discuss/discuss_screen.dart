
import 'package:flutter/material.dart';

class DiscussScreen extends StatelessWidget {
  const DiscussScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discuss'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'Discuss Screen',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
