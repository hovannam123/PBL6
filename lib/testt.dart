import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:pbl6/api/api_service.dart';
import 'package:pbl6/model/order.dart';
import 'package:url_launcher/url_launcher.dart';

class MyTest extends StatefulWidget {
  const MyTest({super.key});

  @override
  State<MyTest> createState() => _MyTestState();
}

class _MyTestState extends State<MyTest> {
  late List<Order> orders = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    ApiService.instance.getOrder().then((value) => {
          setState(() {
            orders = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return Text(
              orders[index].bill!.billDetails![0].totalPayable.toString());
        },
      ),
    );
  }
}
