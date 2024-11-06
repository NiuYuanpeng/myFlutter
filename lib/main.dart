import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_android_flutter/http/dio_instance.dart';

import 'app.dart';

void main() async {
  DioInstance.instance().initDio(baseUrl: "https://www.wanandroid.com/");
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

