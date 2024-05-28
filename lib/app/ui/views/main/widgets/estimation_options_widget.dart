import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide View;
import 'package:yaru/yaru.dart';

class EstimationOptionsTab {
  YaruTab tab;
  Widget child;

  EstimationOptionsTab({
    required String label,
    required this.child,
  }) : tab = YaruTab(label: label);
}

class EstimationOptionsWidget extends StatefulWidget {
  List<EstimationOptionsTab> tabs;
  EstimationOptionsWidget({super.key, required this.tabs});

  @override
  State<EstimationOptionsWidget> createState() => _EstimationOptionsWidgetState();
}

class _EstimationOptionsWidgetState extends State<EstimationOptionsWidget> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        YaruTabBar(tabController: tabController, tabs: widget.tabs.map((e) => e.tab).toList()),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: SizedBox(
            height: 450,
            child: YaruBorderContainer(
              child: TabBarView(
                controller: tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: widget.tabs.map((e) => e.child).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
