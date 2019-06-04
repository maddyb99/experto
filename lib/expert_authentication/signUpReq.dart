import 'package:experto/expert_authentication/expertAdd.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import "package:experto/utils/bloc/is_loading.dart";

class Authenticate {
  CollectionReference expertReference;
  QuerySnapshot expertSnapshot;
  List<String> details;
  String userName;
  //bool _isSignIn;
  Future<void> Function(BuildContext context) fn;

  Authenticate() {
    //_isSignIn = false;
    details = new List<String>();
    getExpert();
  }

  Future<void> _ackAlert(BuildContext context, String title, String content) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  getExpert() async {
    expertReference = Firestore.instance.collection("Experts");
  }

  getName(String x) => details.add(x);
  getPass(String x) => details.add(x);
  getCity(String x) => details.add(x);
  getSkype(String x) => details.add(x);
  getMobile(String x) => details.add(x);
  getEmail(String x) => details.add(x);

  // Widget signInButton(String x) {
  //   if (_isSignIn)
  //     return Center(child: CircularProgressIndicator());
  //   else
  //     return Text(
  //       x,
  //       style: TextStyle(
  //         fontSize: 16,
  //         fontWeight: FontWeight.bold,
  //         color: Colors.black,
  //       ),
  //     );
  // }

  Future<void> signUp(
      GlobalKey<FormState> _formKey, BuildContext context) async {
    FormState formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        isLoadingSignupExpert.updateStatus(true);
        //_isSignIn = true;
        userName = "expert_" + details[0].split(" ")[0];
        String index = details[0].substring(0, 1).toUpperCase();
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: details[1], password: details[5]);
        expert = new Experts(
            email: details[1],
            city: details[3],
            name: details[0],
            skype: details[2],
            userId: userName,
            status: false,
            m: details[4],
            index: index);
        Firestore.instance.runTransaction((Transaction t) async {
          await expertReference.add(expert.toJson());
        });
        expertSnapshot = await expertReference
            .where('emailID', isEqualTo: details[1])
            .getDocuments();
        currentExpert = expertSnapshot.documents[0];
        Navigator.pushNamedAndRemoveUntil(
            context, '/expert_home', ModalRoute.withName(':'));
        formState.reset();
      } catch (e) {
        //_isSignIn = false;
        formState.reset();
        details.clear();
        expert = null;
        isLoadingSignupExpert.updateStatus(false);
        _ackAlert(context, "SignUp failed", e.toString().split(',')[1]);
      }
    }
  }

  Future<void> signIn(
      GlobalKey<FormState> _formKey, BuildContext context) async {
    String _email;
    FormState formState = _formKey.currentState;
    if (formState.validate()) {
      isLoadingLoginExpert.updateStatus(true);
      //_isSignIn = true;
      formState.save();
      try {
        await Firestore.instance
            .collection("Experts")
            .where("userID", isEqualTo: details[0])
            .getDocuments()
            .then((QuerySnapshot q) {
          _email = q.documents[0]["emailID"];
        }).catchError((e) {
          _email = null;
        });
        if (_email == null) throw ("User not found!");
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: details[1]);
        expertSnapshot = await expertReference
            .where('emailID', isEqualTo: _email)
            .getDocuments();
        if (expertSnapshot.documents[0]["Status"] == false)
          throw ("Not Active");
        //print(expertSnapshot.documents[0]["emailID"]);
        currentExpert = expertSnapshot.documents[0];
        Navigator.pushNamedAndRemoveUntil(
            context, '/expert_home', ModalRoute.withName(':'));
        formState.reset();
      } catch (e) {
        //_isSignIn = false;
        //formState.reset();
        details.clear();
        isLoadingLoginExpert.updateStatus(false);
        _ackAlert(
            context,
            "Login Failed!",
            e == "Not Active" || e == "User not found!"
                ? e
                : e.toString().split(',')[1]);
      }
    }
  }
}
