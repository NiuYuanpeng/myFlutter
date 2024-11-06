/// category : "源码"
/// icon : ""
/// id : 22
/// link : "https://www.androidos.net.cn/sourcecode"
/// name : "androidos"
/// order : 11
/// visible : 1

class CommonWebsiteListModel {
  List<CommonWebsiteModel> websiteList = [];

  CommonWebsiteListModel.fromJson(dynamic json) {
    websiteList = [];
    if (json is List) {
      for (var element in json) {
        websiteList.add(CommonWebsiteModel.fromJson(element));
      }
    }
  }

}

class CommonWebsiteModel {
  CommonWebsiteModel({
      this.category, 
      this.icon, 
      this.id, 
      this.link, 
      this.name, 
      this.order, 
      this.visible,});

  CommonWebsiteModel.fromJson(dynamic json) {
    category = json['category'];
    icon = json['icon'];
    id = json['id'];
    link = json['link'];
    name = json['name'];
    order = json['order'];
    visible = json['visible'];
  }
  String? category;
  String? icon;
  num? id;
  String? link;
  String? name;
  num? order;
  num? visible;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category'] = category;
    map['icon'] = icon;
    map['id'] = id;
    map['link'] = link;
    map['name'] = name;
    map['order'] = order;
    map['visible'] = visible;
    return map;
  }

}