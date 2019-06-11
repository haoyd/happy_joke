import 'package:happy_joke/business/model/entities/joke_list_info_entity.dart';
import 'package:happy_joke/common/utils/HudUtil.dart';
import 'package:happy_joke/constant/ServerApiConstant.dart';

import 'BaseServerApi.dart';

class JokeServerApi extends BaseServerApi {

  Future<JokeListInfoEntity> getNewstJokes(int page, HudUtil hud) async {
    Map<String, String> param = {
      'page': page.toString(),
      'pagesize': 10.toString(),
    };

    return await doGet<JokeListInfoEntity>(ServerApiConstant.NewstJoke, param, hud);
  }
}