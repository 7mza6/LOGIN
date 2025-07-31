
import 'package:flutter/material.dart';
import 'package:users/auth/models/userModel.dart';

import '../auth/services/biometric_servic.dart';


class testPage extends StatefulWidget {

  @override
  State<testPage> createState() => _testPageState();
}

class _testPageState extends State<testPage> {
  final user _User = CurrentUser.getcurrentUser()!;
  late bool switchVal ;

    setSwitchVal() async {
      print(_User.username);
      bool? switchVal1 = await getbiometric_Enabled(_User);
      print(switchVal1);
      setState(() {
        switchVal = switchVal1??false;
      });
   }
   
  _testPageState();


  @override
  void initState() {
    setState(() {
      setSwitchVal();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Switch(value: switchVal, onChanged:(value) async {
           await biometric_Enabled(value,_User);
            setState(() {
              switchVal = value;
            });
          },)
        ],
      );
  }
}
