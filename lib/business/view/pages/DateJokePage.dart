import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:happy_joke/business/model/api/JokeServerApi.dart';
import 'package:happy_joke/business/model/entities/joke_list_info_entity.dart';
import 'package:happy_joke/common/utils/HudUtil.dart';
import 'package:happy_joke/common/utils/ToastUtil.dart';
import 'package:happy_joke/constant/AppConstant.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DateJokePage extends StatefulWidget {
  @override
  _DateJokePageState createState() {
    return _DateJokePageState();
  }
}

class _DateJokePageState extends State<DateJokePage> {
  HudUtil _hudUtil = HudUtil();
  JokeServerApi _api = JokeServerApi();
  JokeListInfoEntity _jokeList = JokeListInfoEntity();
  RefreshController _refreshController;

  int _curPage = 1;
  bool _isFinish = false;

  DateTime _dateTime;
  String showDate = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _dateTime = DateTime.now();

    _refreshController = RefreshController(initialRefresh:false);

    _setCurDate();

    _getData(true, true);
  }

  @override
  Widget build(BuildContext context) {
    Widget widget = Scaffold(
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
      body: Stack(
        children: <Widget>[
          Column (
            children: <Widget>[
              Container (
                padding: EdgeInsets.all(10.0),
                color: Colors.grey[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.calendar_today, color: Color(AppConstant.ThemeColor),),
                        Text('  '),
                        Text(showDate)
                      ],
                    ),
                    RaisedButton (
                      child: Text(
                        '选择日期',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Color(AppConstant.ThemeColor),
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: _dateTime,
                          firstDate: new DateTime.now().subtract(new Duration(days: 365)), // 向前推1年
                          lastDate: new DateTime.now().add(new Duration(days: 365)),       // 向后推1年
                        ).then((DateTime val) {
                          _dateTime = val;
                          _setCurDate();
                          _getData(true, true);
                        }).catchError((err) {
                          print(err);
                        });
                      },
                    ),
                  ],
                )
              ),
              Expanded (
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
//                  header: defaultTargetPlatform == TargetPlatform.iOS ? WaterDropHeader() : WaterDropMaterialHeader(),
                  header: ClassicHeader(),
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  onLoading: _onLoadMore,
                  child: ListView.builder(
                      itemBuilder: _buildListItem,
                      itemCount: _jokeList.data != null ? _jokeList.data.length : 0
                  ),
                ),
              ),

            ],
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

    JokeListInfoEntity entity = await _api.getDateJokes(_curPage, _dateTime.millisecondsSinceEpoch.toString(), showLoading ? _hudUtil : null);

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

  _setCurDate() {
    int year = _dateTime.year;
    int month = _dateTime.month;
    int day = _dateTime.day;

    setState(() {
      showDate = '$year年$month月$day日';
    });
  }

  _onRefresh() {
    _curPage = 1;
    _getData(true, false);
  }

  _onLoadMore() {
    _getData(false, false);
  }
}
