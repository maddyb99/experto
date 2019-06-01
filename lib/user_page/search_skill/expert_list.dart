import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";

import './expert_app_bar.dart';
import './expert_cards.dart';
import "package:experto/utils/bloc/reload.dart";

class ExpertList extends StatelessWidget {
  final String name;
  ExpertList({this.name});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(parent:AlwaysScrollableScrollPhysics()),
        slivers: <Widget>[
          Appbar(),
          CupertinoSliverRefreshControl(
            onRefresh: () {
              userSearchSkillExpertList.updateStatus(true);
              return Future.delayed(
                Duration(seconds: 1),
              );
            },
          ),
          Cards(name: name),
        ],
      ),
    );
  }
}
