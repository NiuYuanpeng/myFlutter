
import 'package:flutter/cupertino.dart';
import 'package:one_android_flutter/api/model/home_banner_model.dart';
import 'package:one_android_flutter/api/model/home_list_model.dart';
import 'package:one_android_flutter/api/one_api.dart';

class HomeViewModel with ChangeNotifier {

  List<HomeListItemModel>? homeList = [];
  List<HomeBannerModel>? bannerList;
  bool? isCollect;
  int _pageNumber = 0;
  /// 首页数据初始化，complete是为了监听数据是否处理完成，停止loading动画
  Future initHomeData(bool isLoadMore, {ValueChanged<bool>? complete}) async {
    // 加载更多
    if (isLoadMore) {
      _pageNumber++;
    } else {
      // 重置页码
      _pageNumber = 0;
      // 清空数据
      homeList?.clear();
    }

    // 先获取置顶数据
    _getHomeTopList(isLoadMore).then((topList) {
      if (!isLoadMore) {
        homeList?.addAll(topList ?? []);
      }

      _getHomeList(isLoadMore).then((list) {
        homeList?.addAll(list ?? []);
        notifyListeners();
        // 完成后抛出回调
        complete?.call(isLoadMore);
      });
    });
  }
  ///获取数据
  Future<List<HomeListItemModel>?> _getHomeList(bool isLoadMore) async {
    HomeListModel? data = await OneApi.instance().homeList("$_pageNumber");
    if (data != null && data.datas?.isNotEmpty == true) {
      return data.datas;
    } else {
      // 加载更多场景，拿不到数据，页码-1
      if (isLoadMore && _pageNumber > 0) {
        _pageNumber--;
      }
      return [];
    }
  }
  ///获取置顶文章列表
  Future<List<HomeListItemModel>?> _getHomeTopList(bool isLoadMore) async {
    //加载更多场景不需要获取置顶数据
    if (isLoadMore) {
      return [];
    }
    HomeTopListModel? data = await OneApi.instance().topHomeList();
    return data?.dataList;
  }

  Future getBannerList() async {
    bannerList = await OneApi.instance().bannerList();
    // bannerList = homeBannerListModel.bannerList;
    notifyListeners();
  }

  Future collectOrNot(String? id ,bool isCollect, int index) async {
    bool success = isCollect ? await OneApi.instance().collect(id ?? "") : await OneApi.instance().uncollect(id ?? "");
    if (success) {
      homeList?[index].collect =  isCollect;
      notifyListeners();
    }
  }
}