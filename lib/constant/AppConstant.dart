import 'package:flutter/material.dart';

class AppConstant {
  static const int ThemeColor = 0xFF33C298;
  static const String AppName = '笑话大全';
  static const bool isDebug = true;

  static List mainPageTabList = [
    {'text': '最新', 'icon': Icon(Icons.access_alarm)},
    {'text': '随机', 'icon': Icon(Icons.all_inclusive)},
    {'text': '日期搜索', 'icon': Icon(Icons.calendar_today)},
  ];
}
