import 'package:flutter/material.dart';
import 'package:flutter_challenge_2022/Home/ui/screen/HomePage.dart';
import 'package:flutter_challenge_2022/Router/routes.dart';

abstract class Pages{
 static Map<String, Widget Function(BuildContext context)>  route = {
    Routes.home :(context) => HomePage(),

  };
}