import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import './app_bar.dart' as search_app_bar;
import './cards.dart';
import "package:experto/utils/bloc/reload.dart";

class SearchExpert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: <Widget>[
          search_app_bar.AppBar(),
          CupertinoSliverRefreshControl(
            onRefresh: () {
              userSearchExpert.updateStatus(true);
              return Future.delayed(
                Duration(seconds: 1),
              );
            },
          ),
          Cards(),
        ],
    );
  }
}
