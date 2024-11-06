
import 'package:dio/dio.dart';
import 'package:one_android_flutter/api/model/app_check_update_model.dart';
import 'package:one_android_flutter/api/model/common_website_model.dart';
import 'package:one_android_flutter/api/model/home_banner_model.dart';
import 'package:one_android_flutter/api/model/home_list_model.dart';
import 'package:one_android_flutter/api/model/hot_key_model.dart';
import 'package:one_android_flutter/api/model/knowledge_detail_model.dart';
import 'package:one_android_flutter/api/model/search_list_model.dart';
import 'package:one_android_flutter/api/model/user_info_model.dart';
import 'package:one_android_flutter/http/dio_instance.dart';

import 'model/knowledge_item_model.dart';
import 'model/my_collects_model.dart';

class OneApi {

  OneApi._();

  static OneApi? _instance;

  static OneApi instance() {
    return _instance ??= OneApi._();
  }

  ///获取首页文章列表
  Future<HomeListModel?> homeList(String pageCount) async {

    Response response = await DioInstance.instance().get(path: "article/list/$pageCount/json");

    return HomeListModel.fromJson(response.data);
  }

  ///获取置顶文章列表
  Future<HomeTopListModel?> topHomeList() async {

    Response response = await DioInstance.instance().get(path: "article/top/json");

    return HomeTopListModel.fromJson(response.data);
    // return null;
  }

  /// 获取首页banner列表
  Future<List<HomeBannerModel>?> bannerList() async {
    Response rsp = await DioInstance.instance().get(path: 'banner/json');
    var listModel = HomeBannerListModel.fromJson(rsp.data);
    return listModel.bannerList;
  }

  ///获取搜索热词
  Future<HotKeyListModel> hotKeyList() async {
    Response rsp = await DioInstance.instance().get(path: 'hotkey/json');
    return HotKeyListModel.fromJson(rsp.data);
  }
  ///获取常用网站
  Future<CommonWebsiteListModel> commonWebsite() async {
    Response rsp = await DioInstance.instance().get(path: 'friend/json');
    return CommonWebsiteListModel.fromJson(rsp.data);
  }
  ///知识体系列表
  Future<KnowledgeListModel> knowledgeData() async {
    Response rsp = await DioInstance.instance().get(path: 'tree/json');
    return KnowledgeListModel.fromJson(rsp.data);
  }
  ///知识体系明细列表数据
  Future<List<KnowledgeDetailItemData>?> knowledgeDetailList(String id, String pageCount) async {
    Response rsp = await DioInstance.instance().get(path: 'article/list/$pageCount/json', param: {"cid" : id});
    KnowledgeDetailModel model = KnowledgeDetailModel.fromJson(rsp.data);
    return model.datas;
  }

  ///收藏文章 collect/1165/json
  Future<bool> collect(String id) async {
    Response rsp = await DioInstance.instance().post(path: "lg/collect/$id/json");
    if (rsp.data != null && rsp.data is bool) {
      return rsp.data;
    }
    return false;
  }

  ///根据关键字搜索搜索
  Future<List<SearchItemModel>?> search(String? keyword, String pageCount) async {
    Response rsp = await DioInstance.instance().post(path: "article/query/$pageCount/json", queryParameters: {"k": keyword??""});
    SearchListModel model = SearchListModel.fromJson(rsp.data);

    return model.datas;
  }

  ///取消收藏文章 collect/list/0/json
  Future<bool> uncollect(String id) async {

    Response rsp = await DioInstance.instance().post(path: 'lg/uncollect_originId/$id/json');
    if (rsp.data != null && rsp.data is bool) {
      return rsp.data;
    }
    return false;
  }

  ///获取我的收藏列表
  Future<List<MyCollectItemModel>?> getMyCollects(String pageCount) async {
    Response rsp = await DioInstance.instance().get(path: "lg/collect/list/$pageCount/json");
    MyCollectsModel? model = MyCollectsModel.fromJson(rsp.data);
    if (model.datas != null && model.datas?.isNotEmpty == true) {
      return model.datas;
    }
    return [];
  }

  ///登录
  Future<UserInfoModel> login({String? username, String? password}) async {
    Response rsp = await DioInstance.instance().post(path: 'user/login', queryParameters: {
      "username" : username,
      "password" : password,
    });
    return UserInfoModel.fromJson(rsp.data);
  }

  ///注册 username,password,repassword
  Future<UserInfoModel> register({String? username, String? password, String? repassword}) async {
    Response rsp = await DioInstance.instance().post(path: 'user/register', queryParameters: {
      "username" : username,
      "password" : password,
      "repassword": repassword
    });
    return UserInfoModel.fromJson(rsp.data);
  }

  ///退出登录
  Future<bool> logout() async {
    Response rsp = await DioInstance.instance().get(path: 'user/logout/json');
    if (rsp.data != null && rsp.data == true) {
      return true;
    }
    return false;
  }

  Future<AppCheckUpdateModel> checkUpdate() async {
    DioInstance.instance().changeBaseUrl('https://www.pgyer.com/');
    Response rsp = await DioInstance.instance().post(path: 'apiv2/app/check', queryParameters: {
      // 自己上传的版本信息1.0.0，不会提示更新
      "_api_key" : "d591254c043b9236d27c5010f8e1b858",
      "appKey" : "3e53023467f75205dac2faeb2ffc5e47"
    // "_api_key": "57c543d258a34f8565748561de50b6e6",
    // "appKey": "2639f784ce9ee850532074b7b0534e62"
    });

    DioInstance.instance().changeBaseUrl("https://www.wanandroid.com/");

    return AppCheckUpdateModel.fromJson(rsp.data);
  }

}