
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:one_android_flutter/api/one_api.dart';

import '../../../api/model/my_collects_model.dart';

class MyCollectsViewModel with ChangeNotifier {
  List<MyCollectItemModel>? dataList = [];
  int _pageCount = 0;

  Future getCollectsData(bool isLoadMore) async {
    if (isLoadMore) {
      _pageCount++;
    } else {
      _pageCount = 0;
      dataList?.clear();
    }
    var list = await OneApi.instance().getMyCollects("$_pageCount");

    if (list != null && list.isNotEmpty == true) {
      dataList?.addAll(list);
      notifyListeners();
    } else {
      if (isLoadMore && _pageCount > 0) {
        _pageCount--;
      }
    }
  }

  // 取消文章收藏
  Future cancelCollect(String? id, int index) async {

    bool success = await OneApi.instance().uncollect(id ??"");
    if (success) {
      try {
        dataList?.remove(dataList?[index]);
        notifyListeners();
      } catch (e) {
        log("cancelCollect error=$e");
      }
    }
  }

}