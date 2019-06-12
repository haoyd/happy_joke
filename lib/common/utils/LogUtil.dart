
import 'package:happy_joke/constant/AppConstant.dart';

class LogUtil {
  static bool isOpen = true;

  static void print(String msg) {
    if (!isOpen) {
      return;
    }

    print('------------------------------------------------------------------');
    print(msg);
    print('------------------------------------------------------------------');
  }
}