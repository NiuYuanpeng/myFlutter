import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:one_android_flutter/app.dart';
import 'package:one_android_flutter/pages/auth/login_page.dart';
import 'package:one_android_flutter/pages/mine/about/about_us_page.dart';
import 'package:one_android_flutter/pages/mine/mine_vm.dart';
import 'package:one_android_flutter/pages/mine/my_collects/my_collects_page.dart';
import 'package:one_android_flutter/route/RouteUtils.dart';
import 'package:provider/provider.dart';

import '../../commom_ui/dialog/dialog_factory.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  MineViewModel viewModel = MineViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.initData();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (ctx) => viewModel,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(
          children: [
            // 用户信息
            _buildHeader(child: _buildHeaderInfo(() {
              RouteUtils.push(context, LoginPage());
            })),
            // 我的收藏、检查更新、关于我们
            _buildItem('我的收藏', onTap: () {
              // 判断是否登录
              if (viewModel.shouldLogin == true) {
                RouteUtils.push(context, LoginPage());
              } else {
                RouteUtils.push(context, MyCollectsPage());
              }
            }),
            /***
             * Selector监听数据变化，当已有数据是，改变数据的值不会引起改变，因为初始化时内存地址已确定
             * 建议使用Consumer
             */
            // Selector<MineViewModel, bool>(builder: (ctx, showDot, child) {
            //   return  _buildItem('检查更新', onTap: () {
            //     checkAppUpdate();
            //   }, showRedDot: showDot);
            // }, selector: (ctx, vm) {
            //   return vm.needUpdate;
            // }),
            Consumer<MineViewModel>(builder: (ctx, vm, child) {
              return _buildItem('检查更新', onTap: () {
                    checkAppUpdate();
                  }, showRedDot: vm.needUpdate);
            }),
            _buildItem('关于我们', onTap: () {
              RouteUtils.push(context, AboutUsPage());
            }),

            Consumer<MineViewModel>(builder: (ctx, vm, child) {
              return (vm.shouldLogin ??true) ? SizedBox() : _buildItem('退出登录', onTap: () {
                viewModel.logout();
              });
            })
          ],
        )),
      ),
    );
  }

  Widget _buildHeader({required Widget child}) {
    return Container(
      color: Colors.redAccent,
      height: 200.h,
      width: double.infinity,
      child: child
    );
  }

  Widget _buildHeaderInfo(GestureTapCallback? onTap) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(40.r)),
            child: Image.asset(
              'assets/images/logo.png',
              height: 80.r,
              width: 80.r,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Consumer<MineViewModel>(builder: (ctx, vm, child) {
          return GestureDetector(
            onTap: onTap,
            child: Text(
              vm.userName??'未登录',
              style: TextStyle(color: Colors.white, fontSize: 13.sp),
            ),
          );
        },
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Widget _buildItem(String name,  {GestureTapCallback? onTap, bool? showRedDot}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
        padding: EdgeInsets.only(left: 10.w),
        width: double.infinity,
        height: 45.h,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black38, width: 0.5.r),
            borderRadius: BorderRadius.all(Radius.circular(8.r))),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (showRedDot != true) SizedBox(width: 10.w,),
            if (showRedDot == true)
              Container(
                margin: EdgeInsets.only(left: 3.w, right: 4.w),
                width: 3.r,
                height: 4.r,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(1.5.r),
                ),
              ),
            Expanded(
              child: Text(
                name,
                style: TextStyle(color: Colors.black, fontSize: 13.sp),
              ),
            ),
            Image.asset('assets/images/img_arrow_right.png',height: 20.r, width: 20.r,),
          ],
        ),
      ),
    );
  }

  //
  void checkAppUpdate() {

    viewModel.checkUpdate().then((url) {
      if (url != null && url.isNotEmpty == true) {
        DialogFactory.instance.showNeedUpdateDialog(
          context: context,
          dismissClick: () {
            //是否显示更新红点
            viewModel.shouldShowUpdataDot();
          },
          confirmClick: () {
            //跳转到外部浏览器打开
            viewModel.jumpToOutLink(url);
          }
        );
      } else {
        showToast('已是最新版本');
      }
    });
  }
}
