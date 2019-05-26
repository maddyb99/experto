import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import './card.dart';

class SearchResults extends StatelessWidget {
  final QuerySnapshot results;
  final String headerText;
  SearchResults(this.results, this.headerText);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(top: 20, bottom: 80),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            if (index == 0) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      headerText,
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(fontSize: 15),
                    ),
                  ),
                  CustomCard(results.documents[index]["Name"]),
                ],
              );
            } else {
              return CustomCard(results.documents[index]["Name"]);
            }
          },
          childCount: results.documents.length,
        ),
      ),
    );
  }
}
