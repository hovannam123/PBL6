
class Laptop {
  int? id;
  String? name;
  int? price;
  int? amount;

  Laptop({this.id, this.name, this.price, this.amount});

  Laptop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['amount'] = this.amount;
    return data;
  }
}