class Product {
  int? id;
  String? name;
  String? information;
  String? description;
  double? price;
  bool? status;
  int? popular;
  double? rate;
  String? brand;
  List<String>? attributes;
  Category? category;

  Product(
      {this.id,
        this.name,
        this.information,
        this.description,
        this.price,
        this.status,
        this.popular,
        this.rate,
        this.brand,
        this.attributes,
        this.category});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    information = json['information'];
    description = json['description'];
    price = json['price'];
    status = json['status'];
    popular = json['popular'];
    rate = json['rate'];
    brand = json['brand'];
    attributes = json['attributes'].cast<String>();
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['information'] = this.information;
    data['description'] = this.description;
    data['price'] = this.price;
    data['status'] = this.status;
    data['popular'] = this.popular;
    data['rate'] = this.rate;
    data['brand'] = this.brand;
    data['attributes'] = this.attributes;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? optionGroup;

  Category({this.id, this.name, this.optionGroup});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    optionGroup = json['optionGroup'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['optionGroup'] = this.optionGroup;
    return data;
  }
}
