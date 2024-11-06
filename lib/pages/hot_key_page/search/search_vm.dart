
import 'package:flutter/material.dart';
import 'package:one_android_flutter/api/one_api.dart';

import '../../../api/model/search_list_model.dart';

class SearchViewModel with ChangeNotifier {

  List<SearchItemModel> searchList = [];

  int _pageCount = 0;

  Future getSearchData(String? keyword, bool isLoadMore) async {
    if (isLoadMore) {
      _pageCount++;
    } else {
      _pageCount = 0;
      searchList.clear();
    }

    var list = await OneApi.instance().search(keyword, '$_pageCount');
    if (list != null && list.isNotEmpty == true) {
      print("getSearchData ${searchList.length}");
      searchList.addAll(list ?? []);
      print("getSearchData ${searchList.length}");
    } else {
      if (isLoadMore && _pageCount > 0) {
        _pageCount--;
      }
    }
    notifyListeners();
  }

  void clearList() {
    searchList.clear();
    notifyListeners();
  }
}