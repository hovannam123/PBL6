import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var count = 0.obs;

  getCount({@required count}) {
    this.count = count;
  }
}
