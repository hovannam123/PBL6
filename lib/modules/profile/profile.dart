

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pbl6/config/app_color.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.settings, color: Colors.black,),),
          IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart, color: Colors.black,),),
          IconButton(onPressed: (){}, icon: Icon(Icons.message_rounded, color: Colors.black,),),
        ],
      ),
    );
  }
}
