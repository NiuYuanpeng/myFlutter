/// code : 0
/// message : ""
/// data : {"buildBuildVersion":"1","forceUpdateVersion":"","forceUpdateVersionNo":"","needForceUpdate":false,"downloadURL":"https://www.pgyer.com/app/installUpdate/fbbe38f5f41dce1ff9d727a6f01d5a59?sig=nDkbFE7ZCMb%2BI8ZE6RvNb4TV%2BWuTT6Odw%2FXd9gS0VnPjEitTiD8tCg8ZsHm0IO7E&forceHttps=","buildHaveNewVersion":false,"buildVersionNo":"1","buildVersion":"1.0.0","buildDescription":"","buildUpdateDescription":"","appURl":"https://www.pgyer.com/fbbe38f5f41dce1ff9d727a6f01d5a59","appKey":"3e53023467f75205dac2faeb2ffc5e47","buildKey":"fbbe38f5f41dce1ff9d727a6f01d5a59","buildName":"one_android_flutter","buildIcon":"https://cdn-app-icon.pgyer.com/2/c/5/b/7/2c5b73eae5c57c589b8a5b87c61d73ae?x-oss-process=image/resize,m_lfit,h_120,w_120/format,jpg","buildFileKey":"e1d30cc64bffe5c953591a8cde4571b6.apk","buildFileSize":"94828997"}

class AppCheckUpdateModel {
  AppCheckUpdateModel({
      this.code, 
      this.message, 
      this.data,});

  AppCheckUpdateModel.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? UpdateInfoData.fromJson(json['data']) : null;
  }
  num? code;
  String? message;
  UpdateInfoData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// buildBuildVersion : "1"
/// forceUpdateVersion : ""
/// forceUpdateVersionNo : ""
/// needForceUpdate : false
/// downloadURL : "https://www.pgyer.com/app/installUpdate/fbbe38f5f41dce1ff9d727a6f01d5a59?sig=nDkbFE7ZCMb%2BI8ZE6RvNb4TV%2BWuTT6Odw%2FXd9gS0VnPjEitTiD8tCg8ZsHm0IO7E&forceHttps="
/// buildHaveNewVersion : false
/// buildVersionNo : "1"
/// buildVersion : "1.0.0"
/// buildDescription : ""
/// buildUpdateDescription : ""
/// appURl : "https://www.pgyer.com/fbbe38f5f41dce1ff9d727a6f01d5a59"
/// appKey : "3e53023467f75205dac2faeb2ffc5e47"
/// buildKey : "fbbe38f5f41dce1ff9d727a6f01d5a59"
/// buildName : "one_android_flutter"
/// buildIcon : "https://cdn-app-icon.pgyer.com/2/c/5/b/7/2c5b73eae5c57c589b8a5b87c61d73ae?x-oss-process=image/resize,m_lfit,h_120,w_120/format,jpg"
/// buildFileKey : "e1d30cc64bffe5c953591a8cde4571b6.apk"
/// buildFileSize : "94828997"

class UpdateInfoData {
  UpdateInfoData({
      this.buildBuildVersion, 
      this.forceUpdateVersion, 
      this.forceUpdateVersionNo, 
      this.needForceUpdate, 
      this.downloadURL, 
      this.buildHaveNewVersion, 
      this.buildVersionNo, 
      this.buildVersion, 
      this.buildDescription, 
      this.buildUpdateDescription, 
      this.appURl, 
      this.appKey, 
      this.buildKey, 
      this.buildName, 
      this.buildIcon, 
      this.buildFileKey, 
      this.buildFileSize,});

  UpdateInfoData.fromJson(dynamic json) {
    buildBuildVersion = json['buildBuildVersion'];
    forceUpdateVersion = json['forceUpdateVersion'];
    forceUpdateVersionNo = json['forceUpdateVersionNo'];
    needForceUpdate = json['needForceUpdate'];
    downloadURL = json['downloadURL'];
    buildHaveNewVersion = json['buildHaveNewVersion'];
    buildVersionNo = json['buildVersionNo'];
    buildVersion = json['buildVersion'];
    buildDescription = json['buildDescription'];
    buildUpdateDescription = json['buildUpdateDescription'];
    appURl = json['appURl'];
    appKey = json['appKey'];
    buildKey = json['buildKey'];
    buildName = json['buildName'];
    buildIcon = json['buildIcon'];
    buildFileKey = json['buildFileKey'];
    buildFileSize = json['buildFileSize'];
  }
  String? buildBuildVersion;
  String? forceUpdateVersion;
  String? forceUpdateVersionNo;
  bool? needForceUpdate;
  String? downloadURL;
  bool? buildHaveNewVersion;
  String? buildVersionNo;
  String? buildVersion;
  String? buildDescription;
  String? buildUpdateDescription;
  String? appURl;
  String? appKey;
  String? buildKey;
  String? buildName;
  String? buildIcon;
  String? buildFileKey;
  String? buildFileSize;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['buildBuildVersion'] = buildBuildVersion;
    map['forceUpdateVersion'] = forceUpdateVersion;
    map['forceUpdateVersionNo'] = forceUpdateVersionNo;
    map['needForceUpdate'] = needForceUpdate;
    map['downloadURL'] = downloadURL;
    map['buildHaveNewVersion'] = buildHaveNewVersion;
    map['buildVersionNo'] = buildVersionNo;
    map['buildVersion'] = buildVersion;
    map['buildDescription'] = buildDescription;
    map['buildUpdateDescription'] = buildUpdateDescription;
    map['appURl'] = appURl;
    map['appKey'] = appKey;
    map['buildKey'] = buildKey;
    map['buildName'] = buildName;
    map['buildIcon'] = buildIcon;
    map['buildFileKey'] = buildFileKey;
    map['buildFileSize'] = buildFileSize;
    return map;
  }

}