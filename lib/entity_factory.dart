import 'package:happy_joke/business/model/entities/joke_list_info_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "JokeListInfoEntity") {
      return JokeListInfoEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}