
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/app_text_style.dart';

class StackLogin extends StatelessWidget {

  final Widget child;
  final bool isAsyncCall;


  const StackLogin({Key? key, required this.child, required this.isAsyncCall}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child);
    if(isAsyncCall){
      final stack = new Stack(
        children: [
          new Opacity(opacity: 0.9),
          new Center(
            child: new CircularProgressIndicator(),
          )
        ],
      );
      widgetList.add(stack);
    }
    return Stack(
      children: widgetList,
    );
  }
}
