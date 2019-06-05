import 'package:flutter/material.dart';

class NewstJokePage extends StatefulWidget {
  @override
  _NewstJokePageState createState() {
    return _NewstJokePageState();
  }
}

class _NewstJokePageState extends State<NewstJokePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '最新笑话',
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
