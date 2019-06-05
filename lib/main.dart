import 'package:flutter/material.dart';

import 'package:happy_joke/business/view/pages/DateJokePage.dart';
import 'package:happy_joke/business/view/pages/NewstJokePage.dart';
import 'package:happy_joke/business/view/pages/RandomJokePage.dart';
import 'constant/AppConstant.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(AppConstant.ThemeColor),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          NewstJokePage(),
          RandomJokePage(),
          DateJokePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _getBottomNaviItems(),
        currentIndex: _selectedIndex,
        fixedColor: Color(AppConstant.ThemeColor),
        onTap: _onItemTaped,
      ),
    );
  }

  _getBottomNaviItems() {
    List<BottomNavigationBarItem> items = [];

    for (int i = 0; i < AppConstant.mainPageTabList.length; i++) {
      items.add(BottomNavigationBarItem(
          icon: AppConstant.mainPageTabList[i]['icon'],
          title: Text(AppConstant.mainPageTabList[i]['text'])));
    }

    return items;
  }

  // 点击底部Tab
  _onItemTaped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
