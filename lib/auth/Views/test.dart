
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
  final user User ;
   bool switchVal = getbiometric_Enabled()  =='true'?true:false ;

    setSwitchVal() async {
      bool switchVal1 = await getbiometric_Enabled() =='false'?false:true ;
      print(switchVal1);
      setState(() {
        switchVal = switchVal1;
      });
   }

  _testPageState(this.User);


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
           await biometric_Enabled(value);
            setState(() {
              switchVal = value;
            });
          },)
        ],
      ),
    );
  }
}
