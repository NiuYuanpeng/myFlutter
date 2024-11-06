import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:oktoast/oktoast.dart';
import 'package:one_android_flutter/api/model/app_check_update_model.dart';
import 'package:one_android_flutter/api/one_api.dart';
import 'package:one_android_flutter/constants.dart';
import 'package:one_android_flutter/http/dio_instance.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/sp_utils.dart';

class MineViewModel with ChangeNotifier {
  String? userName;
  bool? shouldLogin;
  bool needUpdate = false;

  Future initData() async {
    String? name = await SpUtils.getString(Constants.SP_USER_NAME);
    if (name == null || name.isEmpty == true) {
      userName = "未登录";
      shouldLogin = true;
    } else {
      userName = name;
      shouldLogin = false;
    }

    //是否显示更新红点
    shouldShowUpdataDot();

    notifyListeners();
  }

  Future logout() async {
    var success = await OneApi.instance().logout();
    if (success) {
      shouldLogin = true;
      userName = "未登录";
      SpUtils.removeAll();
      notifyListeners();
    } else {
      showToast("网络异常");
    }
  }

  Future shouldShowUpdataDot() async {
    var packInfo = await PackageInfo.fromPlatform();
    //获取当前app的版本code
    String versionCode = packInfo.buildNumber;
    // 获取保存的版本号code
    String newVersionCode = await SpUtils.getString(Constants.SP_NEW_APP_VERSION);

    if ((int.tryParse(versionCode) ?? 0) >= (int.tryParse(newVersionCode) ?? 0)) {
      //当前已是最新版本
      needUpdate = false;
    } else {
      //有新版本，显示红点
      needUpdate = true;
    }
    // print("$versionCode, $newVersionCode, shouldShowUpdataDot: $needUpdate");
    // notifyListeners();
  }

  /// 检查更新
  Future<String?> checkUpdate() async {
    var packinfo = await PackageInfo.fromPlatform();
    // 获取当前app的版本code
    String versionCode = packinfo.buildNumber;

    AppCheckUpdateModel? model = await OneApi.instance().checkUpdate();
    // 获取线上的版本
    String onlineAppVersionCode = model.data?.buildVersionNo ?? "0";
    try {
      //如果当前版本小于线上版本，需要更新
      if ((int.tryParse(versionCode) ?? 0) < ((int.tryParse(onlineAppVersionCode) ?? 0)) ) {
        // 保存版本号
        SpUtils.saveString(Constants.SP_NEW_APP_VERSION, onlineAppVersionCode);
        return model.data?.downloadURL;
      } else {
        SpUtils.saveString(Constants.SP_NEW_APP_VERSION, versionCode);
        return null;
      }
    } catch (e) {
      log("checkUpdate error=$e");
      SpUtils.saveString(Constants.SP_NEW_APP_VERSION, versionCode);
      return null;
    }
  }

  Future jumpToOutLink(String? url) async {
    final uri = Uri.parse(url ?? "");
    if (await canLaunchUrl(uri)) {
      return launchUrl(uri);
    }
    return null;
  }
}