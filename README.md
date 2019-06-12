# happy_joke
用Flutter编写的一个笑话大全App，仅当学习练习用。
为了做练习开发，在“聚合数据”网站上找了一些免费的接口做作为网络请求的数据来源。但是由于一些接口不太规范，还有就是每天请求一些次数后就不让请求了，所以不能保证一直成功。

## 1、用到的技术点

1. ListView 展示 UI 列表。
2. Material Design
3. BottomNavigationBar + IndexedStack 搭建主页面（下面3个Tab，上面3个页面做相应切换），类似Android 底部 Tab 搭配 Fragment使用。
4. Card 展示 item 信息。
5. . Dio 处理网络请求。
4. 利用 FlutterJsonBeanFactory 生成 entity 类，可快速解析 Json。
5. 加载中
6. 下拉刷新、上拉加载
7. 日期选择
8. Toast 提示
9. App icon 替换
10. 启动图替换

## 2、用到的3方库

1. dio：强大的 Dart 网络请求库。
2. fluttertoast：仿 Android toast 。
3. progress_hud：加载中组件，类似 iOS 加载中 hud。
4. pull_to_refresh：下拉刷新和上拉加载组件，类似 Android 的 SmartRefresh 组件，功能非常强大。

## 3、应用截图

![最新](https://github.com/haoyd/happy_joke/blob/master/imgs/1.png?raw=true)

![随机](https://github.com/haoyd/happy_joke/blob/master/imgs/2.png?raw=true)

![日期搜索](https://github.com/haoyd/happy_joke/blob/master/imgs/3.png?raw=true)

![启动图](https://github.com/haoyd/happy_joke/blob/master/imgs/4.png?raw=true)





