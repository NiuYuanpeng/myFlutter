import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_android_flutter/api/model/common_website_model.dart';
import 'package:one_android_flutter/api/model/hot_key_model.dart';
import 'package:one_android_flutter/app.dart';
import 'package:one_android_flutter/commom_ui/common_styles.dart';
import 'package:one_android_flutter/commom_ui/smart_refresh/smart_refresh_widget.dart';
import 'package:one_android_flutter/commom_ui/web/webview_page.dart';
import 'package:one_android_flutter/commom_ui/web/webview_widget.dart';
import 'package:one_android_flutter/pages/hot_key_page/hot_key_vm.dart';
import 'package:one_android_flutter/pages/hot_key_page/search/search_page.dart';
import 'package:one_android_flutter/route/RouteUtils.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HotKeyPage extends StatefulWidget {
  const HotKeyPage({super.key});

  @override
  State<HotKeyPage> createState() => _HotKeyPageState();
}

class _HotKeyPageState extends State<HotKeyPage> {
  HotKeyViewModel _hotKeyViewModel = HotKeyViewModel();

  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
    _hotKeyViewModel.getData();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (ctx) => _hotKeyViewModel,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: SmartRefreshWidget(onRefresh: () {
          _hotKeyViewModel.getData(complete: () {
            _refreshController.refreshCompleted();
          });
        },      //禁止上拉
            enablePullUp: false,
            controller: _refreshController, child: SingleChildScrollView(child: Column(children: [
          // 顶部搜索热词
          _titleWidget('搜索热词', true, onTap: () {
            // 跳转搜索页面
            RouteUtils.push(context, SearchPage(keyword: "",));
          }),
          SizedBox(height: 20.h,),
          // 搜索热词列表
          _buildHotkeyList(),
          SizedBox(height: 20.h,),
          // 常用网站
          _titleWidget('常用网站', false),
          SizedBox(height: 20.h,),
          // 常用网站列表
          _buildCommonWebsite(),
        ],),))),
      ),
    );
  }

  Widget _titleWidget(String name, bool isSearch, {GestureTapCallback? onTap}) {
    return Column(children: [
      Container(width: double.infinity, height: 0.5.h, color: Colors.black12,),
      Container(
        padding: EdgeInsets.only(left: 15.w, right: 10.w),
        width: double.infinity,
        height: 45.h,
        alignment: Alignment.centerLeft,
        child: isSearch ? Row(
          children: [
            normalText(name),
            Expanded(child: SizedBox()),
            GestureDetector(onTap: onTap,
              child: Image.asset(
                'assets/images/icon_search.png', width: 30.r, height: 30.r,),
            ),
          ],
        ) : normalText(name),
      ),
      Container(width: double.infinity, height: 0.5.h, color: Colors.black12,),
    ],);
  }

  Widget _buildHotkeyList() {
    return Consumer<HotKeyViewModel>(builder: (ctx, vm, child) {
      return _buildGrideView(itemBuilder: (ctx, index) {
        var name = vm.hotKeyList?[index].name;
        return _buildItem(name, () {
          RouteUtils.push(context, SearchPage(keyword: name,));
        });
      }, itemCount: vm.hotKeyList?.length ?? 0);
    });
  }

  Widget _buildCommonWebsite() {
    return Consumer<HotKeyViewModel>(builder: (ctx, vm, child) {
      return _buildGrideView(itemBuilder: (ctx, index) {
        CommonWebsiteModel? model = vm.websiteList?[index];
        return _buildItem(vm.websiteList?[index].name, () {
          // 进入网页
          RouteUtils.push(context, WebViewPage(
              loadResource: model?.link ?? "",
              webViewType: WebViewType.URL,
          showTitle: true,
          title: model?.name,));
        });
      }, itemCount: vm.websiteList?.length ?? 0);
    });
  }

  Widget _buildGrideView(
      {required NullableIndexedWidgetBuilder itemBuilder, int? itemCount}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            mainAxisSpacing: 10.r,
            crossAxisSpacing: 10.r,
            maxCrossAxisExtent: 120.r,
            childAspectRatio: 2.r
        ),
        itemBuilder: itemBuilder,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: itemCount ?? 0,),
    );
  }

  Widget _buildItem(String? name, GestureTapCallback? onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(5.r),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 0.5),
            borderRadius: BorderRadius.circular(15.r)
        ),
        child: Text(name ?? "", style: blackTextStyle13, textAlign: TextAlign.center,),
      ),
    );
  }
}
