
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:one_android_flutter/app.dart';
import 'package:one_android_flutter/commom_ui/common_styles.dart';
import 'package:one_android_flutter/pages/auth/auth_vm.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthViewModel viewModel = AuthViewModel();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (ctx) => viewModel,
      child: Scaffold(
        backgroundColor: Colors.redAccent,
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.all(20.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                commonInputText(labelText: "输入账号", onChanged: (value) {
                  viewModel.registerInfo.username = value;
                }),
                SizedBox(height: 20,),
                commonInputText(labelText: "输入密码", obscureText: true, onChanged: (value) {
                  viewModel.registerInfo.password = value;
                }),
                SizedBox(height: 20,),
                commonInputText(labelText: "再次输入密码", obscureText: true, onChanged: (value) {
                  viewModel.registerInfo.repassword = value;
                }),
                SizedBox(height: 50,),
                outlineWhiteButton('点我注册', onTap: () {
                  print("zhive");
                  viewModel.register().then((value) {
                    if (value) {
                      //注册成功
                      Navigator.pop(context);
                      showToast('注册成功');
                    } else {
                      showToast('注册失败');
                    }
                  });
                }),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
