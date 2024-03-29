import 'package:happy_joke/business/model/entities/joke_list_info_entity.dart';
import 'package:happy_joke/business/model/entities/random_joke_list_entity.dart';
import 'package:happy_joke/common/utils/HudUtil.dart';
import 'package:happy_joke/constant/ServerApiConstant.dart';

import 'BaseServerApi.dart';

class JokeServerApi extends BaseServerApi {

  // 最新
  Future<JokeListInfoEntity> getNewstJokes(int page, HudUtil hud) async {
    Map<String, String> param = {
      'page': page.toString(),
      'pagesize': 10.toString(),
    };

    return await doGet<JokeListInfoEntity>(ServerApiConstant.NewstJoke, param, hud);
  }

  // 随机
  Future<RandomJokeListEntity> getRandomJokes(HudUtil hud) async {
    return await doGet2<RandomJokeListEntity>(ServerApiConstant.RandomJoke, null, hud);
  }

  // 按日期搜索
  Future<JokeListInfoEntity> getDateJokes(int page, String timeStamp, HudUtil hud) async {
    Map<String, String> param = {
      'page': page.toString(),
      'pagesize': 10.toString(),
      'sort': 'desc',
      'time': timeStamp.length > 10 ? timeStamp.substring(0, 10) : timeStamp,
    };

    return await doGet<JokeListInfoEntity>(ServerApiConstant.DateJoke, param, hud);
  }


}