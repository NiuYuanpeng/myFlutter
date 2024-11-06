
import 'package:flutter/foundation.dart';
import 'package:one_android_flutter/api/one_api.dart';

import '../../api/model/knowledge_item_model.dart';
import '../../commom_ui/loading.dart';

class KnowledgeViewModel with ChangeNotifier {
  List<KnowledgeItemModel>? dataList = [];

  /// 获取体系数据
  Future getKnowledgeData() async {
    Loading.showLoading();

    KnowledgeListModel rsp = await OneApi.instance().knowledgeData();
    if (rsp.list != null) {
      dataList = rsp.list;
      notifyListeners();
    }
    Loading.dismissAll();
  }

  String generalChildName(List<KnowledgeItemChildren>? children) {
    var names = StringBuffer();
    children?.forEach((element) {
      names.write('${element?.name} ');
    });
    return names.toString();
  }
}