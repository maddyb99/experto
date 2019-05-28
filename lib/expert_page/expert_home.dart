import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";

//import "./search_skill/search_skill.dart";
//import "./search_expert/search_expert.dart";
import "./expert_home/expert_home.dart";
import "./navigation_bar_items.dart";

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final List<Widget> pages = [
    ExpertHome(),
    //SearchSkill(),
    //SearchExpert(),
    //FeedBack(),
  ];

  final List<GlobalKey<NavigatorState>> keys = [
    GlobalKey(debugLabel: 'expert home page'),
    //GlobalKey(debugLabel: 'expert skill page'),
    //GlobalKey(debugLabel: 'expert page'),
    //GlobalKey(debugLabel: 'feedback page'),
  ];

  Future<bool> overrideBack(index) {
    NavigatorState navigator = keys[index].currentState;
    bool canPop = navigator.canPop();
    if (canPop) {
      navigator.pop();
    }
    return Future.value(!canPop);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: navigationBarItems(),
      ),
      tabBuilder: (BuildContext context, int index) {
        return WillPopScope(
          onWillPop: () => overrideBack(index),
          child: CupertinoTabView(
            navigatorKey: keys[index],
            builder: (BuildContext context) {
              return pages[index];
            },
          ),
        );
      },
    );
  }
}