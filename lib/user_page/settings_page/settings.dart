import 'package:experto/user_page/settings_page/profilePic.dart';
import 'package:experto/utils/authentication_page_utils.dart';

import 'package:experto/user_page/settings_page/name.dart';
import "package:flutter/material.dart";


class SettingsTiles extends StatelessWidget {
  final List<List> tiles = [
    [Icons.image, "Profile Picture", ProfilePicUpdate()],
    [Icons.short_text, "Name", Name()],
    [Icons.enhanced_encryption, "Password", Passowrd()],
    [Icons.email, "Email", Email()],
    [Icons.delete_forever, "Delete Account", DeleteAccount()],
    [Icons.exit_to_app, "Logout",null],
  ];

  

  void navigateToSetting(BuildContext context, Widget page) {
    Navigator.of(context, rootNavigator: false).push(
      MaterialPageRoute(
        builder: (context) {
          return page;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Hero(
            tag: "setting" + tiles[index][1],
            child: ListTile(
              leading: Icon(tiles[index][0],color:Theme.of(context).accentColor),
              title: Text(
                tiles[index][1],
                style: Theme.of(context).primaryTextTheme.body2.copyWith(fontSize: 15),
              ),
              onTap: () {
                if (tiles[index][1] == 'Logout') {
                  logOut(context);
                } else {
                  navigateToSetting(context, tiles[index][2]);
                }
              },
            ),
          );
        },
        childCount: tiles.length,
      ),
    );
  }
}
