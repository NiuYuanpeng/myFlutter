
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_android_flutter/api/model/search_list_model.dart';
import 'package:one_android_flutter/app.dart';
import 'package:one_android_flutter/commom_ui/smart_refresh/smart_refresh_widget.dart';
import 'package:one_android_flutter/commom_ui/web/webview_page.dart';
import 'package:one_android_flutter/pages/hot_key_page/search/search_vm.dart';
import 'package:one_android_flutter/route/RouteUtils.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../commom_ui/common_styles.dart';
import '../../../commom_ui/web/webview_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, this.keyword});

  final String? keyword;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchViewModel _viewModel = SearchViewModel();
  late TextEditingController _textEditingController;
  late RefreshController _refreshController;

  @override
  void initState() {
    _textEditingController = TextEditingController(text: widget.keyword);
    _refreshController = RefreshController();
    super.initState();

    loadDataOrMore(false);
  }

  void loadDataOrMore(bool isloadMore) {
    _viewModel.getSearchData(_textEditingController.text, isloadMore).then((value) {
      if (isloadMore) {
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
        backgroundColor: Colors.white,
        body: SafeArea(child: SmartRefreshWidget(
          controller: _refreshController,
          onLoading: () {
            loadDataOrMore(true);
          },
          onRefresh: () {
            loadDataOrMore(false);

          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildSearchHeader(
                    onTapBack: () {
                      RouteUtils.pop(context);
                    }, onSubmitted: (text) {
                  loadDataOrMore(false);
                }, onTapCancel: () {
                  // 键盘失去响应，清空数据
                  _textEditingController.text = '';
                  FocusScope.of(context).unfocus();
                  _viewModel.clearList();
                }
                ),

                _buildList(onItemTap: (item) {
                  RouteUtils.push(context, WebViewPage(loadResource: item?.link ?? "",
                    webViewType: WebViewType.URL,
                    title: item?.title,
                    showTitle: true,
                  ));
                }),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Widget _buildSearchHeader(
      {GestureTapCallback? onTapBack,
        GestureTapCallback? onTapCancel,
        ValueChanged<String>? onSubmitted}) {
    return Container(
        color: Colors.teal,
        height: 50.h,
        child: Row(
          children: [
            GestureDetector(onTap:onTapBack ,child: Image.asset('assets/images/icon_back.png', width: 30.r, height: 30.r,)),
            Expanded(child: Container(
              padding: EdgeInsets.symmetric(vertical: 6.h),
              child: TextField(
                textAlign: TextAlign.justify,
                controller: _textEditingController,
                decoration: _inputDecoration(),
                keyboardType: TextInputType.text,
                style: titleTextStyle15,
                textInputAction: TextInputAction.search,
                onSubmitted: onSubmitted,
              ),
            )),
            SizedBox(width: 10.w,),
            GestureDetector(onTap: onTapCancel, child: Text("取消", style: whiteTextStyle15)),
            SizedBox(width: 10.w,),
          ],
        )
    );
  }

  OutlineInputBorder _inputBorder() {
    return OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(15.r)));
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
        contentPadding: EdgeInsets.only(left: 10.w),
        fillColor: Colors.white,
        filled: true,
        enabledBorder: _inputBorder(),
        focusedBorder: _inputBorder(),
        border: _inputBorder());
  }

  Widget _buildList({ValueChanged<SearchItemModel?>? onItemTap}) {
    return Consumer<SearchViewModel>(builder: (ctx, vm, child) {
      return ListView.builder(itemCount: vm.searchList.length ?? 0,itemBuilder: (ctx, index) {
        SearchItemModel item = vm.searchList[index];
        return _buildItem(item, onTap: () {
          onItemTap?.call(item);
        });
      }, shrinkWrap: true, physics: NeverScrollableScrollPhysics(),);
    });
  }

  Widget _buildItem(SearchItemModel? item, {GestureTapCallback? onTap}) {
    return GestureDetector(onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(left: 15.w, top: 10.h, bottom: 10.h),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black12, width: 0.8.h))
          ),
          width: double.infinity,
          child: Html(data:item?.title ?? "" ,style: {
            //整体样式使用 html
            "html":Style(fontSize: FontSize(15.sp))
          }),
        ));
  }

}
/**
class SearchPage extends StatefulWidget {
  const SearchPage({super.key, this.keyword});

  final String? keyword;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchViewModel _viewModel = SearchViewModel();
  late TextEditingController _textEditingController;
  late RefreshController _refreshController;

  @override
  void initState() {
    _textEditingController = TextEditingController(text: widget.keyword);
    _refreshController = RefreshController();
    super.initState();

    loadDataOrMore(false);
  }

  void loadDataOrMore(bool isloadMore) {
    _viewModel.getSearchData(_textEditingController.text, isloadMore).then((value) {
      if (isloadMore) {
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
        backgroundColor: Colors.white,
        body: SafeArea(child: SmartRefreshWidget(
          controller: _refreshController,
          onLoading: () {
            loadDataOrMore(true);
          },
          onRefresh: () {
            loadDataOrMore(false);

          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildSearchHeader(
                  onTapBack: () {
                    RouteUtils.pop(context);
                  }, onSubmitted: (text) {
                    loadDataOrMore(false);
                  }, onTapCancel: () {
                    // 键盘失去响应，清空数据
                   _textEditingController.text = '';
                    FocusScope.of(context).unfocus();
                    _viewModel.clearList();
                  }
                ),

                _buildList(onItemTap: (item) {
                  RouteUtils.push(context, WebViewPage(loadResource: item?.link ?? "",
                      webViewType: WebViewType.URL,
                      title: item?.title,
                      showTitle: true,
                  ));
                }),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Widget _buildSearchHeader(
      {GestureTapCallback? onTapBack,
        GestureTapCallback? onTapCancel,
        ValueChanged<String>? onSubmitted}) {
    return Container(
        color: Colors.teal,
        height: 50.h,
        child: Row(
          children: [
            GestureDetector(onTap:onTapBack ,child: Image.asset('assets/images/icon_back.png', width: 30.r, height: 30.r,)),
            Expanded(child: Container(
              padding: EdgeInsets.symmetric(vertical: 6.h),
              child: TextField(
                textAlign: TextAlign.justify,
                controller: _textEditingController,
                decoration: _inputDecoration(),
                keyboardType: TextInputType.text,
                style: titleTextStyle15,
                textInputAction: TextInputAction.search,
                onSubmitted: onSubmitted,
              ),
            )),
            SizedBox(width: 10.w,),
            GestureDetector(onTap: onTapCancel, child: Text("取消", style: whiteTextStyle15)),
            SizedBox(width: 10.w,),
          ],
        )
    );
  }

  OutlineInputBorder _inputBorder() {
    return OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(15.r)));
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
        contentPadding: EdgeInsets.only(left: 10.w),
        fillColor: Colors.white,
        filled: true,
        enabledBorder: _inputBorder(),
        focusedBorder: _inputBorder(),
        border: _inputBorder());
  }

  Widget _buildList({ValueChanged<SearchItemModel?>? onItemTap}) {
    return Consumer<SearchViewModel>(builder: (ctx, vm, child) {
      return ListView.builder(itemCount: vm.searchList.length ?? 0,itemBuilder: (ctx, index) {
        SearchItemModel item = vm.searchList[index];
        return _buildItem(item, onTap: () {
          onItemTap?.call(item);
        });
      }, shrinkWrap: true, physics: NeverScrollableScrollPhysics(),);
    });
  }

  Widget _buildItem(SearchItemModel? item, {GestureTapCallback? onTap}) {
    return GestureDetector(onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 15.w, top: 10.h, bottom: 10.h),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12, width: 0.8.h))
        ),
        width: double.infinity,
        child: Html(data:item?.title ?? "" ,style: {
          //整体样式使用 html
          "html":Style(fontSize: FontSize(15.sp))
        }),
      ));
  }

}
*/
