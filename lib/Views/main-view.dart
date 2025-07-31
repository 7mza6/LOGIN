import 'package:flutter/material.dart';
import 'package:users/Views/test.dart';
import 'package:users/auth/models/userModel.dart';

import 'DrawerView.dart';
import 'navBar.dart';
import 'homePage.dart';
import 'AppHeader.dart';

class mainView extends StatefulWidget {
   Widget? body;
  mainView({this.body});
  @override
  State<mainView> createState() => _mainViewState();  
}

class _mainViewState extends State<mainView> {
  
  void setBody(Widget body) {
    setState(() {
      widget.body = body;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppHeader(context),
        drawer: DrawerView(),
        bottomNavigationBar: BottomNavBar(mainView: this,),
        body: widget.body ?? HomePage(),        
      ),
    );
  }
}

