
import 'package:flutter/material.dart';
import 'package:users/auth/models/userModel.dart';

import '../services/biometric_servic.dart';


class testPage extends StatefulWidget {
  final user User ;
  const testPage({required this.User});


  @override
  State<testPage> createState() => _testPageState(User);
}

class _testPageState extends State<testPage> {
  final user _User ;
  late bool switchVal ;

    setSwitchVal() async {
      bool? switchVal1 = await getbiometric_Enabled(_User);
      print(switchVal1);
      setState(() {
        switchVal = switchVal1??false;
      });
   }

  _testPageState(this._User);


  @override
  void initState() {
    setState(() {
      setSwitchVal();
    });

  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("test"),
      ),
      body: Column(
        children: [
          Switch(value: switchVal, onChanged:(value) async {
           await biometric_Enabled(value,_User);
            setState(() {
              switchVal = value;
            });
          },)
        ],
      ),
    );
  }
}
