import 'package:flutter/material.dart';
import 'package:one_android_flutter/api/model/knowledge_item_model.dart';
import 'package:one_android_flutter/pages/knowledge/detail/knowledge_detail_vm.dart';
import 'package:provider/provider.dart';

import 'knowledge_detail_tab_child_page.dart';

class KnowledgeDetailTabPage extends StatefulWidget {
  const KnowledgeDetailTabPage({super.key, this.params});

  final List<KnowledgeItemChildren>? params;
  @override
  State<KnowledgeDetailTabPage> createState() => _KnowledgeDetailTabPageState();
}

class _KnowledgeDetailTabPageState extends State<KnowledgeDetailTabPage> with SingleTickerProviderStateMixin {
  KnowledgeDetailViewModel viewModel = KnowledgeDetailViewModel();
  TabController? controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: widget.params?.length ??0, vsync: this);
    viewModel.initTabs(widget.params);
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (ctx) => viewModel,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: TabBar(
              tabs: viewModel.tabs,
              controller: controller,
              isScrollable: true,
              indicatorColor: Colors.orangeAccent,
              labelColor: Colors.orange,
          ),
        ),
        body: SafeArea(child: TabBarView(
            children: getChildren(),
          controller: controller,
        )),
      ),
    );
  }

  ///根据传进来的数据生成对应数量的tabPage
  List<Widget> getChildren() {
    return widget.params?.map((e) {
      return KnowledgeDetailTabChildPage(id: "${e.id}");
      ();
  }).toList() ??[];
}
}
