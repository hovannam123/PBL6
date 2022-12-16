import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginResponseModel {
  String? token;
  String? type;
  UserModel? userModel;
  List<Roles>? roles;

  LoginResponseModel({this.token, this.type, this.userModel, this.roles});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    type = json['type'];
    userModel = json['userModel'] != null
        ? new UserModel.fromJson(json['userModel'])
        : null;
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(new Roles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['type'] = this.type;
    if (this.userModel != null) {
      data['userModel'] = this.userModel!.toJson();
    }
    if (this.roles != null) {
      data['roles'] = this.roles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserModel {
  int? id;
  String? name;
  String? dateOfBirth;
  String? address;
  String? phoneNumber;
  bool? gender;
  String? userAccount;
  String? email;

  UserModel(
      {this.id,
        this.name,
        this.dateOfBirth,
        this.address,
        this.phoneNumber,
        this.gender,
        this.userAccount,
        this.email});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dateOfBirth = json['dateOfBirth'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
    userAccount = json['userAccount'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['dateOfBirth'] = this.dateOfBirth;
    data['address'] = this.address;
    data['phoneNumber'] = this.phoneNumber;
    data['gender'] = this.gender;
    data['userAccount'] = this.userAccount;
    data['email'] = this.email;
    return data;
  }
}

class Roles {
  String? authority;

  Roles({this.authority});

  Roles.fromJson(Map<String, dynamic> json) {
    authority = json['authority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authority'] = this.authority;
    return data;
  }
}


class LoginRequestModel{
  String? username;
  String? password;

  LoginRequestModel({
    this.username,
    this.password
  });

  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = {
      "username": username?.trim(),
      "password": password?.trim()
    };

    return map;
  }

}