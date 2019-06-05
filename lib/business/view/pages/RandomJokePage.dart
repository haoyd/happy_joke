import 'package:flutter/material.dart';

class RandomJokePage extends StatefulWidget {
  @override
  _RandomJokePageState createState() {
    return _RandomJokePageState();
  }
}

class _RandomJokePageState extends State<RandomJokePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '随机选取',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: null,
        centerTitle: true,
      ),
    );
  }
}