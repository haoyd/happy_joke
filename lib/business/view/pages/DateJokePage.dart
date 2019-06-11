import 'package:flutter/material.dart';
import 'package:happy_joke/business/model/api/JokeServerApi.dart';
import 'package:happy_joke/business/model/entities/joke_list_info_entity.dart';
import 'package:happy_joke/common/utils/HudUtil.dart';
import 'package:happy_joke/common/utils/ToastUtil.dart';
import 'package:happy_joke/constant/AppConstant.dart';
import 'package:incrementally_loading_listview/incrementally_loading_listview.dart';

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
  int _curPage = 1;
  bool _isFinish = false;

  DateTime _dateTime = DateTime.now();
  String showDate = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _setCurDate();

    _getData();
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
                          _getData();
                        }).catchError((err) {
                          print(err);
                        });
                      },
                    ),
                  ],
                )
              ),
              Expanded (
                child: IncrementallyLoadingListView(
                  hasMore: () => !_isFinish,
                  loadMore: () async {
                    await _getData();
                  },
                  itemBuilder: _buildListItem,
                  itemCount: () => _jokeList.data != null ? _jokeList.data.length : 0,
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

  _getData() async {
    if (_isFinish) {
      ToastUtil.show('已到最后');
      return;
    }

    JokeListInfoEntity entity = await _api.getDateJokes(_curPage, _dateTime.millisecondsSinceEpoch.toString(), _hudUtil);
//    JokeListInfoEntity entity = await _api.getNewstJokes(_curPage, _hudUtil);

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

  _setCurDate() {
    int year = _dateTime.year;
    int month = _dateTime.month;
    int day = _dateTime.day;

    setState(() {
      showDate = '$year年$month月$day日';
    });
  }
}
