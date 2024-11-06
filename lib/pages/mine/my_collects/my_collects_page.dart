import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_android_flutter/commom_ui/smart_refresh/smart_refresh_widget.dart';
import 'package:one_android_flutter/pages/mine/my_collects/my_collects_vm.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../api/model/my_collects_model.dart';
import '../../../commom_ui/common_styles.dart';
import '../../../commom_ui/web/webview_page.dart';
import '../../../commom_ui/web/webview_widget.dart';
import '../../../route/RouteUtils.dart';

///我的收藏页面
/**
class MyCollectsPage extends StatefulWidget {
  const MyCollectsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyCollectsPageState();
  }
}

class _MyCollectsPageState extends State<MyCollectsPage> {
  var model = MyCollectsViewModel();
  late RefreshController _refreshController;

  @override
  void initState() {
    _refreshController = RefreshController();
    super.initState();
    refreshOrLoad(false);
  }

  void refreshOrLoad(bool loadMore) {
    model.getCollectsData(loadMore).then((value) {
      if (loadMore) {
        _refreshController.loadComplete();
      } else {
        _refreshController.refreshCompleted();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) {
          return model;
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
                child: Consumer<MyCollectsViewModel>(
                  builder: (ctx, vm, child) {
                    return SmartRefreshWidget(
                        controller: _refreshController,
                        onRefresh: () {
                          refreshOrLoad(false);
                        },
                        onLoading: () {
                          refreshOrLoad(true);
                        },
                        child: ListView.builder(
                            itemCount: vm.dataList?.length ?? 0,
                            itemBuilder: (context, index) {
                              return _collectItem(vm.dataList?[index], onTap: () {
                                //取消收藏
                                model.cancelCollect("${vm.dataList?[index].id}", index,);
                              }, itemClick: () {
                                //进入网页
                                RouteUtils.push(
                                    context,
                                    WebViewPage(
                                        loadResource: vm.dataList?[index].link ?? "",
                                        webViewType: WebViewType.URL,
                                        showTitle: true,
                                        title: vm.dataList?[index].title));
                              });
                            }));
                  },
                ))));
  }

  Widget _collectItem(MyCollectItemModel? item,
      {GestureTapCallback? onTap, GestureTapCallback? itemClick}) {
    return GestureDetector(
        onTap: itemClick,
        child: Container(
            margin: EdgeInsets.all(10.r),
            padding: EdgeInsets.all(15.r),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black38),
                borderRadius: BorderRadius.all(Radius.circular(10.r))),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(
                  child: Text("作者: ${item?.author}"),
                ),
                Text("时间: ${item?.niceDate}")
              ]),
              SizedBox(height: 6.h),
              Text("${item?.title}", style: titleTextStyle15),
              Row(children: [
                Expanded(child: Text("分类: ${item?.chapterName}")),
                collectImage(true, onTap: onTap)
              ]),
            ])));
  }
}
*/

class MyCollectsPage extends StatefulWidget {
  const MyCollectsPage({super.key});

  @override
  State<MyCollectsPage> createState() => _MyCollectsPageState();
}

class _MyCollectsPageState extends State<MyCollectsPage> {
  MyCollectsViewModel _viewModel = MyCollectsViewModel();

  late RefreshController _refreshController;

  @override
  void initState() {
    _refreshController = RefreshController();
    super.initState();
    loadDataOrNot(false);
  }

  void loadDataOrNot(bool isLoadMore) {
    _viewModel.getCollectsData(isLoadMore).then((value) {
      if (isLoadMore) {
        _refreshController.loadComplete();
      } else {
        _refreshController.refreshCompleted();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (ctx) => _viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text('我的收藏'),
        ),
        body: SafeArea(
            child: Consumer<MyCollectsViewModel>(
              builder: (ctx, vm, child) {
                return SmartRefreshWidget(
                    onRefresh: () {
                      loadDataOrNot(false);
                    },
                    controller: _refreshController,
                    onLoading: () {
                      loadDataOrNot(true);
                    },
                    child: ListView.builder(itemCount:vm.dataList?.length ?? 0 ,itemBuilder: (ctx, index) {
                      return _collectItem(vm.dataList?[index], onTap: () {
                        _viewModel.cancelCollect('${vm.dataList?[index].id}', index);
                      }, itemClick: () {
                        //进入网页
                        RouteUtils.push(
                            context,
                            WebViewPage(
                                loadResource: vm.dataList?[index].link ?? "",
                                webViewType: WebViewType.URL,
                                showTitle: true,
                                title: vm.dataList?[index].title));
                      });
                    }));
              },

            )),
      ),
    );
  }

  Widget _buildListView() {
    return Consumer<MyCollectsViewModel>(
      builder: (ctx, vm, child) {
        return ListView.builder(itemCount:vm.dataList?.length ?? 0 ,itemBuilder: (ctx, index) {
          return _collectItem(vm.dataList?[index], onTap: () {

          }, itemClick: () {

          });
        });
      },
    );
  }

  Widget _collectItem(MyCollectItemModel? item,
      {GestureTapCallback? onTap, GestureTapCallback? itemClick}) {
    return GestureDetector(
        onTap: itemClick,
        child: Container(
            margin: EdgeInsets.all(10.r),
            padding: EdgeInsets.all(15.r),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black38),
                borderRadius: BorderRadius.all(Radius.circular(10.r))),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(
                  child: Text("作者: ${item?.author}"),
                ),
                Text("时间: ${item?.niceDate}")
              ]),
              SizedBox(height: 6.h),
              Text("${item?.title}", style: titleTextStyle15),
              Row(children: [
                Expanded(child: Text("分类: ${item?.chapterName}")),
                collectImage(true, onTap: onTap)
              ]),
            ])));
  }
}
