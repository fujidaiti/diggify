import 'package:diggify/pages/listen_later/listen_later_pane.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

enum HomeTab {
  listenNow('Listen Now'),
  listenLater('Listen Later');

  const HomeTab(this.label);

  final String label;
}

class Home extends HookWidget {
  const Home({
    super.key,
    required this.tab,
  });

  final HomeTab tab;

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(
      initialLength: HomeTab.values.length,
      initialIndex: tab.index,
    );

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        bottom: TabBar(
          controller: tabController,
          tabs: [for (final tab in HomeTab.values) Tab(text: tab.label)],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          for (final tab in HomeTab.values)
            switch (tab) {
              HomeTab.listenNow => const Placeholder(),
              HomeTab.listenLater => const ListenLaterPane(),
            },
        ],
      ),
    );
  }
}
