import 'RoResp.dart';

class JokeListInfoEntity extends RoResp {
  List<JokeItemInfo> data;

  JokeListInfoEntity({this.data});

  JokeListInfoEntity.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<JokeItemInfo>();
      (json['data'] as List).forEach((v) {
        data.add(new JokeItemInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }

  addDatas(List<JokeItemInfo> data) {
    if (data == null) {
      return;
    }

    if (this.data == null) {
      this.data = [];
    }

    this.data.addAll(data);
  }

}

class JokeItemInfo {
  int unixtime;
  String updatetime;
  String hashId;
  String content;

  JokeItemInfo({this.unixtime, this.updatetime, this.hashId, this.content});

  JokeItemInfo.fromJson(Map<String, dynamic> json) {
    unixtime = json['unixtime'];
    updatetime = json['updatetime'];
    hashId = json['hashId'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unixtime'] = this.unixtime;
    data['updatetime'] = this.updatetime;
    data['hashId'] = this.hashId;
    data['content'] = this.content;
    return data;
  }
}

class aaa extends JokeItemInfo {
  aaa.fromJson(Map<String, dynamic> json) {

  }
}
