import 'package:flutter/material.dart';
import 'package:happy_joke/business/model/api/JokeServerApi.dart';
import 'package:happy_joke/business/model/entities/random_joke_list_entity.dart';
import 'package:happy_joke/common/utils/HudUtil.dart';

class RandomJokePage extends StatefulWidget {
  @override
  _RandomJokePageState createState() {
    return _RandomJokePageState();
  }
}

class _RandomJokePageState extends State<RandomJokePage> {
  HudUtil _hudUtil = HudUtil();
  JokeServerApi _api = JokeServerApi();
  RandomJokeListEntity _jokeList = RandomJokeListEntity();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

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
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: _getItemCount(),
            itemBuilder: _buildListItem,
          ),
          _hudUtil.hud,
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.autorenew),
        onPressed: () {
          _getData();
        },
      ),
    );
  }

  Widget _buildListItem(context, index) {
    return Card(
      margin: EdgeInsets.all(10.0),
      elevation: 5.0,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Text(
              _jokeList.result[index].content,
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }

  _getData() async {
    RandomJokeListEntity entity = await _api.getRandomJokes(_hudUtil);

    if (entity == null) {
      return;
    }

    setState(() {
      _jokeList.setDatas(entity.result);
    });
  }

  int _getItemCount() {
    if (_jokeList == null || _jokeList.result == null) {
      return 0;
    }

    if (_jokeList.result.length > 2) {
      return 2;
    } else {
      return _jokeList.result.length;
    }
  }
}
