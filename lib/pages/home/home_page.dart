import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:one_android_flutter/api/model/home_banner_model.dart';
import 'package:one_android_flutter/api/model/home_list_model.dart';
import 'package:one_android_flutter/app.dart';
import 'package:one_android_flutter/commom_ui/smart_refresh/smart_refresh_widget.dart';
import 'package:one_android_flutter/commom_ui/web/webview_page.dart';
import 'package:one_android_flutter/commom_ui/web/webview_widget.dart';
import 'package:one_android_flutter/pages/home/home_vm.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../commom_ui/common_styles.dart';
import '../../route/RouteUtils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewModel _viewModel = HomeViewModel();
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
    _viewModel.getBannerList();
    _viewModel.initHomeData(false);
  }

  void loadData(bool isLoadMore) {
    _viewModel.initHomeData(isLoadMore, complete: (isLoadMore) {
      if (isLoadMore) {
        _refreshController.loadComplete();
      } else {
        _refreshController.refreshCompleted();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) {
        return _viewModel;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SmartRefreshWidget(
          controller: _refreshController,
          onLoading: () {
            loadData(true);
          },
          onRefresh: () {
            loadData(false);
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                // 顶部banner
                _buildBanner(),

                _buildListView(),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Widget _buildBanner() {
    return Consumer<HomeViewModel>(
      builder: (ctx, homeVM, child) {
        return Container(
          margin: EdgeInsets.only(left: 10.w, right: 10.w),
          width: double.infinity,
          height: 150.h,
          child: Swiper(
            autoplay: true,
            pagination: SwiperPagination(),
            onTap: (index) {
              // banner点击跳转webView
              HomeBannerModel? model = homeVM.bannerList?[index];
              WebViewPage(
                loadResource: model?.url ?? "",
                webViewType: WebViewType.URL,
                showTitle: true,
                title: model?.title ?? "",
              );
            },
            // control: SwiperControl(),
            itemCount: homeVM.bannerList?.length ?? 0,
            itemBuilder: (ctx, index) {
              String imageUrl = homeVM.bannerList?[index].imagePath ?? "";
              return Image.network(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.fill,
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildListView() {
    return Consumer<HomeViewModel>(builder: (ctx, homeVM, child) {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          HomeListItemModel? item = homeVM.homeList?[index];
          return _buildHomeItem(
              item: item,
              onItemClick: () {
                RouteUtils.push(
                    context,
                    WebViewPage(
                      loadResource: item?.link ?? "",
                      webViewType: WebViewType.URL,
                      showTitle: true,
                      title: item?.title ?? "",
                    ));
              },
              imageClick: () {
                var isCollect =
                    homeVM.homeList?[index].collect == false ? true : false;
                homeVM.collectOrNot(
                    "${homeVM.homeList?[index].id}", isCollect, index);
              });
        },
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: homeVM.homeList?.length ?? 0,
      );
    });
  }

  Widget _buildHomeItem(
      {HomeListItemModel? item,
      GestureTapCallback? onItemClick,
      GestureTapCallback? imageClick}) {
    return GestureDetector(
      onTap: onItemClick,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            border: Border.all(color: Colors.black26, width: 1)),
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
        padding: EdgeInsets.all(10.r),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 顶部头像和时间
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    'https://i1.hdslb.com/bfs/archive/f2e8ffda87ec8ca599540b0ff2bdf4607328053f.jpg',
                    height: 25.r,
                    width: 25.r,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                normalText(item?.author),
                const Expanded(child: SizedBox()),
                normalText(item?.niceShareDate),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  item?.type == 1 ? "置顶" : "",
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.greenAccent),
                )
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            // 中间content
            Text(item?.title ?? "", style: titleTextStyle15),
            SizedBox(
              height: 5.h,
            ),
            // 底部name 和 按钮
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item?.chapterName ?? "",
                  style: TextStyle(color: Colors.green, fontSize: 13.sp),
                ),
                collectImage(item?.collect, onTap: imageClick),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
