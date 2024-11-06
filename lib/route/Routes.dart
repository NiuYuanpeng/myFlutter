import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../commom_ui/web/webview_page.dart';
import '../commom_ui/web/webview_widget.dart';
import '../pages/auth/login_page.dart';
import '../pages/auth/register_page.dart';
import '../pages/hot_key_page/search/search_page.dart';
import '../pages/knowledge/detail/knowledge_detail_tab_page.dart';
import '../pages/mine/about/about_us_page.dart';
import '../pages/mine/my_collects/my_collects_page.dart';
import '../pages/tab_page.dart';

///路由注册管理类
class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //首页tab
      case RoutePath.tab:
        return pageRoute(const TabPage(), settings: settings);
      // //知识体系明细页面
      case RoutePath.knowledge_details:
        return pageRoute(const KnowledgeDetailTabPage(), settings: settings);
      // //登录
      case RoutePath.login:
        return pageRoute(const LoginPage(), settings: settings);
      // //注册
      case RoutePath.register:
        return pageRoute(const RegisterPage(), settings: settings);
      // //我的收藏页面
      case RoutePath.my_collects:
        return pageRoute(const MyCollectsPage(), settings: settings);
      // //显示网页资源的页面
      case RoutePath.web_view:
        return pageRoute(WebViewPage(loadResource: "", webViewType: WebViewType.URL),
            settings: settings);
      // //关于我们
      case RoutePath.about_us:
        return pageRoute(const AboutUsPage(), settings: settings);
      // //搜索页
      case RoutePath.search:
        return pageRoute(const SearchPage(), settings: settings);
    }
    return MaterialPageRoute(
        builder: (context) =>
            Scaffold(body: Center(child: Text('No route defined for ${settings.name}'))));
  }

  static MaterialPageRoute pageRoute(
    Widget page, {
    RouteSettings? settings,
    bool? fullscreenDialog,
    bool? maintainState,
    bool? allowSnapshotting,
  }) {
    return MaterialPageRoute(
        builder: (context) => page,
        settings: settings,
        fullscreenDialog: fullscreenDialog ?? false,
        maintainState: maintainState ?? true,
        allowSnapshotting: allowSnapshotting ?? true);
  }
}

///路由地址
class RoutePath {
  //首页tab
  static const String tab = "/";

  //登录
  static const String login = "/login";

  //注册
  static const String register = "/register";

  //知识体系明细页面
  static const String knowledge_details = "/knowledge_details";

  //我的收藏页面
  static const String my_collects = "/my_collects";

  //显示网页资源的页面
  static const String web_view = "/web_view";

  //关于我们
  static const String about_us = "/about_us";

  //搜索页
  static const String search = "/search";

  //关于
  static const String about = "/about";
}
