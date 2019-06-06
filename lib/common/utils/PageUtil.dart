import 'package:flutter/material.dart';

class PageUtil {
  static setPage(String title, Widget body) {
    return Scaffold(
      appBar: AppBar(title: Text(title),),
      body: body,
    );
  }
}

