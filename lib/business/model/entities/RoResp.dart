abstract class RoResp {

  int error_code = 0;
  String reason;

  int netErrorCode = 200;

  bool isNetFail() {
    return netErrorCode != 200;
  }

}