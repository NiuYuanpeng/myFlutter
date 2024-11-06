import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_android_flutter/app.dart';
import 'package:one_android_flutter/commom_ui/common_styles.dart';
import 'package:one_android_flutter/pages/auth/auth_vm.dart';
import 'package:one_android_flutter/pages/auth/register_page.dart';
import 'package:one_android_flutter/pages/tab_page.dart';
import 'package:one_android_flutter/route/RouteUtils.dart';
import 'package:one_android_flutter/route/Routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthViewModel viewModel = AuthViewModel();
  TextEditingController? nameController;
  TextEditingController? pswController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    pswController = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15.w),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              commonInputText(labelText: '输入账号', controller: nameController),
              SizedBox(
                height: 20,
              ),
              commonInputText(labelText: '输入密码', obscureText: true, controller: pswController),
              SizedBox(
                height: 40,
              ),
              outlineWhiteButton('开始登录', onTap: () {
                viewModel.setLoginInfo(username: nameController?.text ?? "", password: pswController?.text ?? "");
                  viewModel.login().then((value) {
                    if (value) {
                      RouteUtils.pushAndRemoveUntil(context, TabPage());
                    }
                  });
              }),

              SizedBox(
                height: 15.h,
              ),
              _buildRegisterButton(onTap: () {
                RouteUtils.push(context, RegisterPage());
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton({GestureTapCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Text(
          '注册',
          style: whiteTextStyle14,
        ),
        width: 100,
        height: 30,
        alignment: Alignment.center,
      ),
    );
  }


}
