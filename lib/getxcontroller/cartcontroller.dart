

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pbl6/model/product.dart';

class CartController extends GetxController{
  var idProduct = 0.obs;
  var amount = 0.obs;
  var count = 0.obs;

  getAmount(@required count){
    this.count = count;
  }

}