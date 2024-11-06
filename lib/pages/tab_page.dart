

import 'package:flutter/material.dart';
import 'package:one_android_flutter/pages/home/home_page.dart';
import 'package:one_android_flutter/pages/hot_key_page/hot_key_page.dart';
import 'package:one_android_flutter/pages/knowledge/knowledge_page.dart';
import 'package:one_android_flutter/pages/mine/mine_page.dart';

import '../commom_ui/navigation/navigation_bar_widget.dart';

class TabPage extends StatefulWidget {
  const TabPage({super.key});

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  ///tab界面集合
  final List<Widget> tabItems = [];
  final List<String> tabLabels = ['首页', '热点', "体系", "我的"];
  final List<String> tabIcons = [
    "assets/images/icon_home_grey.png",
    "assets/images/icon_hot_key_grey.png",
    "assets/images/icon_knowledge_grey.png",
    "assets/images/icon_personal_grey.png"
  ];
  final List<String> tabActiveIcons = [
    "assets/images/icon_home_selected.png",
    "assets/images/icon_hot_key_selected.png",
    "assets/images/icon_knowledge_selected.png",
    "assets/images/icon_personal_selected.png"
  ];
  @override
  void initState() {
    super.initState();
    initTabPage();
  }

  void initTabPage() {
    tabItems.add(HomePage());
    tabItems.add(HotKeyPage());
    tabItems.add(KnowledgePage());
    tabItems.add(MinePage());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NavigationBarWidget(
        tabItems: tabItems,
        tabLabels: tabLabels,
        tabActiveIcons: tabActiveIcons,
        tabIcons: tabIcons,
      ),
    );
  }
}
