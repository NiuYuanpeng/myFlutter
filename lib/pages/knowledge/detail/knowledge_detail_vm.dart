
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:one_android_flutter/api/model/knowledge_detail_model.dart';
import 'package:one_android_flutter/api/model/knowledge_item_model.dart';
import 'package:one_android_flutter/api/one_api.dart';
import 'package:one_android_flutter/commom_ui/loading.dart';

class KnowledgeDetailViewModel with ChangeNotifier {
  List<Tab> tabs = [];
  List<KnowledgeDetailItemData> datasList = [];
  // 页码
  int _pageCount = 0;

  /// 初始化tabs
  void initTabs(List<KnowledgeItemChildren>? children) {
    if (children?.isNotEmpty == true) {
      children?.forEach((element) {
        tabs.add(Tab(text: element.name ?? "",));
      });
    }
  }

  //
  Future getKnowledgeDetailData(String? id, bool isLoadMore) async {

    print("getKnowledgeDetailData id:$id, $_pageCount");
    Loading.showLoading();
    if (!isLoadMore) {
      _pageCount = 0;
      datasList.clear();
    } else {
      _pageCount++;
    }
    var list = await OneApi.instance().knowledgeDetailList(id ?? "", "$_pageCount");
    if (list != null && list.isNotEmpty == true) {
      datasList.addAll(list);
      notifyListeners();
    } else {
      if (isLoadMore && _pageCount > 0) {
        // 没有加载到更多数据 也要通知数据没有了
        _pageCount--;
        notifyListeners();
      }
    }
    Loading.dismissAll();
  }
}