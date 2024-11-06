import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_android_flutter/api/model/knowledge_item_model.dart';
import 'package:one_android_flutter/commom_ui/common_styles.dart';
import 'package:one_android_flutter/commom_ui/smart_refresh/smart_refresh_widget.dart';
import 'package:one_android_flutter/pages/knowledge/detail/knowledge_detail_tab_page.dart';
import 'package:one_android_flutter/pages/knowledge/knowledge_vm.dart';
import 'package:one_android_flutter/route/RouteUtils.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///知识体系页面
class KnowledgePage extends StatefulWidget {
  const KnowledgePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _KnowledgePageState();
  }
}

class _KnowledgePageState extends State<KnowledgePage> {
  var model = KnowledgeViewModel();
  late RefreshController _refreshController;

  @override
  void initState() {
    _refreshController = RefreshController();
    super.initState();
    model.getKnowledgeData();
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
                child: SmartRefreshWidget(
                    enablePullUp: false,
                    onRefresh: () {
                      model.getKnowledgeData().then((value) {
                        //关闭刷新
                        _refreshController.refreshCompleted();
                      });
                    },
                    controller: _refreshController,
                    child: knowledgeListview()))));
  }

  Widget knowledgeListview() {
    return Consumer<KnowledgeViewModel>(builder: (context, value, child) {
      return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: value.dataList?.length ?? 0,
          itemBuilder: (context, index) {
            return knowledgeItem(value.dataList?[index]);
          });
    });
  }

  Widget knowledgeItem(KnowledgeItemModel? item) {
    return GestureDetector(
        onTap: () {
          RouteUtils.push(context, KnowledgeDetailTabPage(params: item?.children ?? []));

        },
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black12, width: 0.5.r),
                borderRadius: BorderRadius.all(Radius.circular(5.r))),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(
                      item?.name ?? "",
                      style: titleTextStyle15,
                    ),
                    SizedBox(height: 10.h),
                    Text(model.generalChildName(item?.children)),
                  ])),
              Image.asset("assets/images/img_arrow_right.png", height: 24.r, width: 24.r)
            ])));
  }
}


/*
class KnowledgePage extends StatefulWidget {
  const KnowledgePage({super.key});

  @override
  State<KnowledgePage> createState() => _KnowledgePageState();
}

class _KnowledgePageState extends State<KnowledgePage> {
  KnowledgeViewModel viewModel = KnowledgeViewModel();
  late RefreshController _refreshController;
  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
    viewModel.getKnowledgeData();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => viewModel,
      child: Scaffold(
        backgroundColor: Colors.red,
        body: SafeArea(child: SmartRefreshWidget(
        controller: _refreshController,
        child: _knowledgeListView(),
        enablePullDown: false,
        onRefresh: () {
          viewModel.getKnowledgeData().then((value) {
            _refreshController.refreshCompleted();
          });
        },),
      )),
    );
  }

  Widget _knowledgeListView() {
    return Consumer<KnowledgeViewModel>(
      builder: (ctx, vm, child) {
        return ListView.builder(
          itemBuilder: (ctx, index) {
            return _buildItem(
                vm.dataList?[index], vm.dataList?[index].children ?? [], onTap: () {
              RouteUtils.push(context, KnowledgeDetailTabPage(params: vm.dataList?[index].children ?? []));
            });
          },
          itemCount: vm.dataList?.length ?? 0,
          // shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
        );
      },
    );
  }

  Widget _buildItem(
      KnowledgeItemModel? item, List<KnowledgeItemChildren> children, {GestureTapCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          // width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.black12, width: 0.5.r)),
          margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 8.h, bottom: 8.h),
          padding: EdgeInsets.all(8.r),
          child: Row(
            children: [
              // 左边内容
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(
                      item?.name ?? "",
                      style: titleTextStyle15,
                    ),
                    SizedBox(height: 10.h),
                    Text(viewModel.generalChildName(item?.children)),
                  ])),
              Image.asset('assets/images/img_arrow_right.png',
                  height: 24.r, width: 24.r)
            ],
          )),
    );
  }
}
 */
