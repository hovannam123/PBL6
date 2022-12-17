import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pbl6/config/app_text_style.dart';

class PlusMinusButtons extends StatelessWidget {
  final String amount;
  final VoidCallback deleteQuantity;
  final VoidCallback addQuantity;
  const PlusMinusButtons(
      {Key? key,
        required this.amount,
        required this.addQuantity,
        required this.deleteQuantity,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Số lượng: ", style: AppTextStyle.heading4Black,),
        IconButton(onPressed: deleteQuantity, icon: const Icon(Icons.remove)),
        Text(amount, style: AppTextStyle.heading4Black,),
        IconButton(onPressed: addQuantity, icon: const Icon(Icons.add)),
      ],
    );
  }
}