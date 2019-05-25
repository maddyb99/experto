import 'package:experto/user_authentication/login_page.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

import "./home_page/home_page.dart";
import "./user_authentication/signup_page.dart";
import "./user_page/home_page.dart" as user;

import './theme.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/user_signup": (context) => SignupPage(),
        "/user_home": (context) => user.HomePage(),
        '/user_login': (context)=> LoginPage(),
      },
      darkTheme: theme.darkTheme(),
      theme: theme.lightTheme(),
      home: HomePage(), 
    );
  }
}
