import 'package:pbl6/model/product.dart';

class Cart {
  int? id;
  User? user;
  Product? product;
  int? amount;

  Cart({this.id, this.user, this.product, this.amount});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['amount'] = this.amount;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? dateOfBirth;
  String? address;
  String? phoneNumber;
  bool? gender;
  String? userAccount;

  User(
      {this.id,
        this.name,
        this.dateOfBirth,
        this.address,
        this.phoneNumber,
        this.gender,
        this.userAccount});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dateOfBirth = json['dateOfBirth'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
    userAccount = json['userAccount'];
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
    return data;
  }
}
