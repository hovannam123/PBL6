import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:pbl6/model/order.dart';

class MyOrderDetail extends StatefulWidget {
  const MyOrderDetail({super.key, required this.billDetais});
  final List<BillDetails>? billDetais;

  @override
  State<MyOrderDetail> createState() => _MyOrderDetailState();
}

class _MyOrderDetailState extends State<MyOrderDetail> {
  final NumberFormat decimalFormat = NumberFormat.decimalPattern();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.billDetais!.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: Card(
              child: Column(children: [
                Text(
                    '${decimalFormat.format(widget.billDetais![index].totalPayable)}')
              ]),
            ),
          );
        },
      ),
    );
  }
}
