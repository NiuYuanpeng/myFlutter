/// id : 6
/// link : ""
/// name : "面试"
/// order : 1
/// visible : 1

class HotKeyListModel {
  List<HotKeyModel>? hotKeyList;

  HotKeyListModel.fromJson(dynamic json) {
    hotKeyList = [];
    for (var item in json) {
      hotKeyList?.add(HotKeyModel.fromJson(item));
    }
  }
}

class HotKeyModel {
  HotKeyModel({
      this.id, 
      this.link, 
      this.name, 
      this.order, 
      this.visible,});

  HotKeyModel.fromJson(dynamic json) {
    id = json['id'];
    link = json['link'];
    name = json['name'];
    order = json['order'];
    visible = json['visible'];
  }
  num? id;
  String? link;
  String? name;
  num? order;
  num? visible;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['link'] = link;
    map['name'] = name;
    map['order'] = order;
    map['visible'] = visible;
    return map;
  }

}