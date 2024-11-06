import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:oktoast/oktoast.dart';
import 'package:one_android_flutter/api/model/user_info_model.dart';
import 'package:one_android_flutter/api/one_api.dart';
import 'package:one_android_flutter/constants.dart';

import '../../utils/sp_utils.dart';

class AuthViewModel with ChangeNotifier {
  LoginInfo loginInfo = LoginInfo();
  RegisterInfo registerInfo = RegisterInfo();

  Future login() async {
    if (loginInfo.username?.trim().isEmpty == true) {
      showToast('请输入账号');
      return false;
    }
    if (loginInfo.password?.trim().isEmpty == true) {
      showToast("请输入密码");
      return false;
    }

    UserInfoModel infoModel = await OneApi.instance()
        .login(username: loginInfo.username, password: loginInfo.password);
    if (infoModel.username != null) {
      SpUtils.saveString(Constants.SP_USER_NAME, infoModel?.username ??"");
      return true;
    }
    showToast("登录异常");
    return false;
  }

  Future<bool> register() async {
    if (registerInfo.username?.trim().isEmpty == true) {
      showToast('请输入账号');
      return false;
    }
    if (registerInfo.password?.trim().isEmpty == true) {
      showToast("请输入密码");
      return false;
    }
    if (registerInfo.repassword?.trim().isEmpty == true) {
      showToast("请再次输入密码");
      return false;
    }
    if ((registerInfo.password?.length??0) < 6) {
      showToast("密码长度不能小于6位");
      return false;
    }
    if (registerInfo.password! != registerInfo.repassword!) {
      showToast('两次输入密码不一致');
      return false;
    }

    UserInfoModel infoModel = await OneApi.instance().register(
        username: registerInfo.username,
        password: registerInfo.password,
        repassword: registerInfo.repassword);
    if (infoModel.username != null) {
      return true;
    }
    showToast("注册异常");
    return false;
  }

  void setLoginInfo({String? username, String? password}) {
    loginInfo.username = username;
    loginInfo.password = password;
  }
}

class LoginInfo {
  String? username;
  String? password;
}

class RegisterInfo {
  String? username;
  String? password;
  String? repassword;
}
