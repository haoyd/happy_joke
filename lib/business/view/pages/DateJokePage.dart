import 'package:flutter/material.dart';

class DateJokePage extends StatefulWidget {
  @override
  _DateJokePageState createState() {
    return _DateJokePageState();
  }
}

class _DateJokePageState extends State<DateJokePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '按日期搜索',
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