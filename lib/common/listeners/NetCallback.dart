import 'package:happy_joke/business/model/entities/NetException.dart';
import 'package:happy_joke/common/utils/ToastUtil.dart';

abstract class NetCallback<T> {
  void onSuccess(T result);
  void onFail(NetException e) {
    if (e == null) {
      ToastUtil.show('网络错误');
      return;
    }

    if (e.msg != null && !e.msg.isEmpty) {
      ToastUtil.show(e.msg);
    }
  }
}