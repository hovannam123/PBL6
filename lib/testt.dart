import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class MyTest extends StatefulWidget {
  const MyTest({super.key});

  @override
  State<MyTest> createState() => _MyTestState();
}

class _MyTestState extends State<MyTest> {
  final Uri _url = Uri.parse('https://www.facebook.com/');

  Future<void> _launchUrl() async {
    if (await launchUrl(_url)) {
      await launchUrl(_url); //forceWebView is true now
    } else {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: IconButton(
            onPressed: _launchUrl,
            icon: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
