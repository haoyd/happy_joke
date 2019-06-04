
class ServerApiConstant {

  static const String ServerHost = 'http://v.juhe.cn';
  static const String NewstJoke = ServerHost + '/joke/content/text.php';    // 最新笑话
  static const String RandomJoke = ServerHost + '/joke/randJoke.php';       // 随机获取笑话
  static const String DateJoke = ServerHost + '/joke/content/list.php';     // 按日期查询笑话

}