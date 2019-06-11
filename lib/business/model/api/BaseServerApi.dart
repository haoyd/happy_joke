import 'package:dio/dio.dart';
import 'package:happy_joke/business/model/entities/RoResp.dart';
import 'package:happy_joke/common/listeners/NetCallback.dart';
import 'package:happy_joke/constant/KeyOf3rdConstant.dart';
import 'package:happy_joke/constant/ServerApiConstant.dart';
import 'dart:convert';

import '../../../entity_factory.dart';

class BaseServerApi {
  Dio _net;

  BaseServerApi() {
    BaseOptions options = BaseOptions(
      baseUrl: ServerApiConstant.ServerHost,
      connectTimeout: 5000,
      receiveTimeout: 5000,
    );
    _net = Dio(options);
  }

  Map<String, String> buildCommonParams(Map<String, String> param) {
    if (param == null) {
      param = {};
    }
    param['key'] = KeyOf3rdConstant.JuheAppKey;
    return param;
  }

  Future<T> doGet<T extends RoResp>(String url, Map<String, String> param) async {
    T resp;

    try {
      Response response = await _net.get(url, queryParameters: buildCommonParams(param));
      if (response.statusCode == 200) {
        if (response.data['result'] != null) {
          resp = EntityFactory.generateOBJ<T>(response.data['result']);
        }

        resp.error_code = response.data['error_code'];
        resp.reason = response.data['reason'];
      } else {
        resp.netErrorCode = response.statusCode;
      }
      new Future.delayed(new Duration(seconds: 1), () {
        print('task delayed');
      });
    } catch (e) {
      print(e);
    }

    return resp;
  }
}
