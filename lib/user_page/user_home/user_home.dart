import 'package:experto/utils/floating_action_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './vertical_list.dart';
import './app_bar.dart';
import "package:experto/utils/bloc/reload.dart";

class UserHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FAB(color: Colors.green),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: <Widget>[
          Appbar(),
          CupertinoSliverRefreshControl(
            onRefresh: () {
              userInteractions.updateStatus(true);
              return Future.delayed(
                Duration(seconds: 1),
              );
            },
          ),
          VerticalList(),
        ],
      ),
    );
  }
}
