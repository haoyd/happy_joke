import 'RoResp.dart';

class RandomJokeListEntity extends RoResp {
	List<RandomJokeItem> result;

	RandomJokeListEntity({this.result});

	RandomJokeListEntity.fromJson(Map<String, dynamic> json) {
		if (json['result'] != null) {
			result = new List<RandomJokeItem>();(json['result'] as List).forEach((v) { result.add(new RandomJokeItem.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.result != null) {
      data['result'] =  this.result.map((v) => v.toJson()).toList();
    }
		return data;
	}

	setDatas(List<RandomJokeItem> data) {
		if (data == null) {
			return;
		}

		if (this.result == null) {
			this.result = [];
		}

		this.result = data;
	}
}

class RandomJokeItem {
	int unixtime;
	String hashId;
	String content;

	RandomJokeItem({this.unixtime, this.hashId, this.content});

	RandomJokeItem.fromJson(Map<String, dynamic> json) {
		unixtime = json['unixtime'];
		hashId = json['hashId'];
		content = json['content'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['unixtime'] = this.unixtime;
		data['hashId'] = this.hashId;
		data['content'] = this.content;
		return data;
	}
}
