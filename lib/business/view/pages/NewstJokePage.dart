import 'package:flutter/material.dart';
import 'package:happy_joke/business/model/api/JokeServerApi.dart';
import 'package:happy_joke/business/model/entities/joke_list_info_entity.dart';
import 'package:happy_joke/common/utils/HudUtil.dart';
import 'package:happy_joke/common/utils/ToastUtil.dart';
import 'package:incrementally_loading_listview/incrementally_loading_listview.dart';
import 'package:progress_hud/progress_hud.dart';

class NewstJokePage extends StatefulWidget {
  @override
  _NewstJokePageState createState() {
    return _NewstJokePageState();
  }
}

class _NewstJokePageState extends State<NewstJokePage> {
  HudUtil _hudUtil = HudUtil();
  JokeServerApi _api = JokeServerApi();
  JokeListInfoEntity _jokeList = JokeListInfoEntity();
  int _curPage = 1;
  bool _isFinish = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {

    Widget widget = Scaffold(
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

      body: Stack(
        children: <Widget>[
          IncrementallyLoadingListView(
              hasMore: () => !_isFinish,
              loadMore: () async {
                await _getData();
              },
              itemBuilder: _buildListItem,
              itemCount: () => _jokeList.data != null ? _jokeList.data.length : 0
          ),
          _hudUtil.hud
        ],
      ),
    );

    return widget;
  }

  _getData() async {
    if (_isFinish) {
      ToastUtil.show('已到最后');
      return;
    }

    JokeListInfoEntity entity = await _api.getNewstJokes(_curPage, _hudUtil);

    if (entity == null) {
      return;
    }

    if (entity.data.isEmpty) {
      _isFinish = true;
      ToastUtil.show('已到最后');
      return;
    }

    setState(() {
      _jokeList.addDatas(entity.data);
    });

    _curPage++;
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
              _jokeList.data[index].content,
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                _jokeList.data[index].updatetime,
                style: TextStyle(color: Colors.grey, fontSize: 12.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
