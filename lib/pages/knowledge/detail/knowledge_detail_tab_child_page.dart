import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_android_flutter/commom_ui/common_styles.dart';
import 'package:one_android_flutter/commom_ui/smart_refresh/smart_refresh_widget.dart';
import 'package:one_android_flutter/commom_ui/web/webview_page.dart';
import 'package:one_android_flutter/pages/knowledge/detail/knowledge_detail_vm.dart';
import 'package:one_android_flutter/route/RouteUtils.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../api/model/knowledge_detail_model.dart';
import '../../../commom_ui/web/webview_widget.dart';

class KnowledgeDetailTabChildPage extends StatefulWidget {
  const KnowledgeDetailTabChildPage({super.key, this.id});

  final String? id;

  @override
  State<KnowledgeDetailTabChildPage> createState() =>
      _KnowledgeDetailTabChildPageState();
}

class _KnowledgeDetailTabChildPageState
    extends State<KnowledgeDetailTabChildPage> {
  KnowledgeDetailViewModel viewModel = KnowledgeDetailViewModel();

  late RefreshController _refreshController;
  @override
  void initState() {
    _refreshController = RefreshController();
    super.initState();
    loadDataOrMore(false);
  }

  void loadDataOrMore(bool isLoadMore) {

    viewModel.getKnowledgeDetailData(widget.id, isLoadMore).then((value) {
      if (isLoadMore) {
        print("isLoadMoreisLoadMoreisLoadMoreisLoadMoreisLoadMore");
        _refreshController.loadComplete();
      } else {
        _refreshController.refreshCompleted();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (ctx) => viewModel,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SmartRefreshWidget(
                onRefresh: () {
                  loadDataOrMore(false);
                },
                onLoading: () {
                  loadDataOrMore(true);
                },
                controller: _refreshController,
                child: _buildListView()),
          )
      ),

    );
  }


  Widget _buildListView() {
    return Consumer<KnowledgeDetailViewModel>(builder: (ctx, vm, child) {
      return ListView.builder(physics: NeverScrollableScrollPhysics(), shrinkWrap: true,
          itemCount: vm.datasList.length ?? 0, itemBuilder: (ctx, index) {
        return _buildItem(vm.datasList[index], onTap: () {
          // 进入网页
          RouteUtils.push(context, WebViewPage(
            loadResource: vm.datasList?[index].link ?? "",
            webViewType: WebViewType.URL,
            showTitle: true,
            title: vm.datasList?[index].title ?? "",));
        });
      });
    },);
  }

  Widget _buildItem(KnowledgeDetailItemData? item,
      {GestureTapCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 0.5.r)),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //第一部分
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              normalText(item?.superChapterName ?? ""),
              Text(item?.niceShareDate ?? ""),
            ],),
            SizedBox(height: 10.h,),
            //第二部分
            Text(item?.title ?? "", style: titleTextStyle15,),
            SizedBox(height: 10.h,),
            //第三部分
            Row(children: [
              normalText(item?.chapterName ?? ""),
              Expanded(child: SizedBox()),
              Text(item?.shareUser ?? ""),
            ],),
          ],
        ),
      ),
    );
  }
}
