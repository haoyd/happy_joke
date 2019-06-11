import 'package:dio/dio.dart';
import 'package:happy_joke/business/model/entities/RoResp.dart';
import 'package:happy_joke/common/listeners/NetCallback.dart';
import 'package:happy_joke/common/utils/HudUtil.dart';
import 'package:happy_joke/common/utils/LogUtil.dart';
import 'package:happy_joke/common/utils/ToastUtil.dart';
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

  Future<T> doGet<T extends RoResp>(String url, Map<String, String> param, HudUtil hud) async {
    T resp;

    try {
      if (hud != null) {
        hud.show();
      }

      Response response = await _net.get(url, queryParameters: buildCommonParams(param));

      if (hud != null) {
        hud.hide();
      }

      if (response.statusCode == 200) {
        if (response.data['result'] != null) {
          resp = EntityFactory.generateOBJ<T>(response.data['result']);
        }
        resp.error_code = response.data['error_code'];
        resp.reason = response.data['reason'];
      } else {
        resp.netErrorCode = response.statusCode;
      }

      if (_hasError(resp)) {
        return null;
      }

    } catch (e) {
      print(e);
    }

    return resp;
  }

  // 由于结构变化太大，无法封装为一个
  Future<T> doGet2<T extends RoResp>(String url, Map<String, String> param, HudUtil hud) async {
    T resp;

    try {
      if (hud != null) {
        hud.show();
      }

      Response response = await _net.get(url, queryParameters: buildCommonParams(param));

      if (hud != null) {
        hud.hide();
      }

      if (response.statusCode == 200) {
        if (response.data != null) {
          resp = EntityFactory.generateOBJ<T>(response.data);
        }
        resp.error_code = response.data['error_code'];
        resp.reason = response.data['reason'];
      } else {
        resp.netErrorCode = response.statusCode;
      }

      if (_hasError(resp)) {
        return null;
      }

    } catch (e) {
      print(e);
    }

    return resp;
  }



  // 请求到的数据是否有异常
  bool _hasError(RoResp resp) {
    if (resp == null) {
      ToastUtil.show('网络错误');
      return true;
    }

    if (resp.isNetFail()) {
      ToastUtil.show('网络错误 - $resp.error_code');
      return true;
    }

    if (resp.isDataError()) {
      ToastUtil.show(resp.reason);
      return true;
    }

    return false;
  }
}
