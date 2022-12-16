
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UserController extends GetxController{

  var token = "".obs;
  var id = 0.obs;
  var name = "".obs;
  var address = "".obs;
  var dateOfBirth = "".obs;
  var phoneNumber = "".obs;
  var gender = false.obs;
  var userAccount = "".obs;
  var email = "".obs;


  information({@required token,@required id, @required name, @required address, @required dateOfBirth, @required phoneNumber, @required gender, @required userAccount, @required email}){
    this.token = token;
    this.id = id;
    this.name = name ;
    this.address = address;
    this.dateOfBirth = dateOfBirth;
    this.phoneNumber = phoneNumber ;
    this.gender = gender;
    this.userAccount = userAccount;
    this.email = email;
  }
}