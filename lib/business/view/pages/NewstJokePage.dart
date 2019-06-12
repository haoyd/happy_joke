import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:happy_joke/business/model/api/JokeServerApi.dart';
import 'package:happy_joke/business/model/entities/joke_list_info_entity.dart';
import 'package:happy_joke/common/utils/HudUtil.dart';
import 'package:happy_joke/common/utils/ToastUtil.dart';
import 'package:progress_hud/progress_hud.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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

  RefreshController _refreshController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // initialRefresh可以在组件初始化时执行一次刷新操作
    _refreshController = RefreshController(initialRefresh:false);

    _getData(true, true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _refreshController.dispose();
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
          SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: ClassicHeader(),
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoadMore,
            child: ListView.builder(
                itemBuilder: _buildListItem,
                itemCount: _jokeList.data != null ? _jokeList.data.length : 0
            ),
          ),
          _hudUtil.hud
        ],
      ),
    );

    return widget;
  }

  _getData(bool isRefresh, bool showLoading) async {
    if (_isFinish) {
      ToastUtil.show('已到最后');
      return;
    }

    JokeListInfoEntity entity = await _api.getNewstJokes(_curPage, showLoading ? _hudUtil : null);

    if (_refreshController.isLoading) {
      _refreshController.loadComplete();
    }

    if (_refreshController.isRefresh) {
      _refreshController.refreshCompleted();
    }

    _hudUtil.hide();

    if (entity == null) {
      return;
    }

    if (entity.data.isEmpty) {
      _isFinish = true;
      ToastUtil.show('已到最后');
      return;
    }

    setState(() {
      if (isRefresh) {
        _jokeList.setDatas(entity.data);
      } else {
        _jokeList.addDatas(entity.data);
      }
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

  _onRefresh() {
    _curPage = 1;
    _getData(true, false);
  }

  _onLoadMore() {
    _getData(false, false);
  }
}
