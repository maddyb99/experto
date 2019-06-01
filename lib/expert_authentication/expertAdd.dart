import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

DocumentSnapshot currentExpert;

class Experts {
  final String name, email, city, m, userId, skype, index;
  bool status;
  int mobile;

  Experts({
    @required this.name,
    @required this.email,
    @required this.city,
    @required this.m,
    @required this.userId,
    @required this.skype,
    @required this.status,
    @required this.index,
    this.mobile = 0,
  }) {
    mobile = int.parse(m);
  }

  Map<String, dynamic> toJson() => {
        'Name': name,
        'emailID': email,
        'userID': userId,
        'SkypeUser': skype,
        'City': city,
        'Mobile': mobile,
        'Status': status,
        'Index': index
      };
}

var expert;
