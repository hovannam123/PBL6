import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/app_text_style.dart';

class LoginScreen extends StatelessWidget {
  final Widget child;
  final bool isAsyncCall;
  final bool isLogin;

  const LoginScreen(
      {Key? key,
      required this.child,
      required this.isAsyncCall,
      required this.isLogin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child);
    if (isAsyncCall) {
      final circular = Stack(
        children: const [
          Opacity(opacity: 0.9),
          Center(
            child: CircularProgressIndicator(),
          )
        ],
      );
      widgetList.add(circular);
      if (!isLogin) {
        widgetList.removeAt(1);
        final messege = Stack(
          children: const [
            Opacity(opacity: 0.9),
            Center(
              child: Text(
                "Sai tài khoản hoặc mật khẩu",
                style: AppTextStyle.heading4Light,
              ),
            )
          ],
        );
        widgetList.add(messege);
      }
    }
    return Stack(
      children: widgetList,
    );
  }
}
