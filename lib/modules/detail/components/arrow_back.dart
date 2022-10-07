import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArrowBack extends StatelessWidget {
  const ArrowBack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black,size: 27,),
      ),
    );
  }
}