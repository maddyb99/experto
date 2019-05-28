import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
DocumentSnapshot currentUser;

class Users {

  final String name,email,city,m;
  int mobile;

  Users({
    @required this.name,
    @required this.email,
    @required this.city,
    @required this.m,
    this.mobile=0,
  }){
    mobile=int.parse(m);
  }

  Map<String, dynamic> toJson() =>
      {
        'Name':name,
        'emailID':email,
        'City':city,
        'Mobile':mobile,
      };

}var user;