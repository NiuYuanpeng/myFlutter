
import 'package:flutter/cupertino.dart';
import 'package:one_android_flutter/api/one_api.dart';

import '../../api/model/common_website_model.dart';
import '../../api/model/hot_key_model.dart';

class HotKeyViewModel with ChangeNotifier {
  List<CommonWebsiteModel>? websiteList = [];
  List<HotKeyModel>? hotKeyList = [];

  Future getData({VoidCallback? complete}) async {
    getHotKeyData(complete: () {
      getCommonWebsiteData(complete: () {
        complete?.call();
      });
    });
  }

  /// 搜索热词
  Future getHotKeyData({VoidCallback? complete}) async {
    HotKeyListModel rsp = await OneApi.instance().hotKeyList();
    if (rsp.hotKeyList != null) {
      hotKeyList = rsp.hotKeyList;
      notifyListeners();
    }
    complete?.call();
  }

  /// 获取常用网站
  Future getCommonWebsiteData({VoidCallback? complete}) async {
    CommonWebsiteListModel rsp = await OneApi.instance().commonWebsite();
    if (rsp.websiteList != null) {
      websiteList = rsp.websiteList;
      notifyListeners();
    }
    complete?.call();
  }


}