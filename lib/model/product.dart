class Product {
  int? id;
  String? name;
  String? information;
  String? description;
  int? price;
  bool? status;
  int? popular;
  double? rate;
  Brand? brand;
  List<Attributes>? attributes;
  List<String>? productImgs;
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
      this.productImgs,
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
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(new Attributes.fromJson(v));
      });
    }
    productImgs = json['productImgs'].cast<String>();
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
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
    }
    data['productImgs'] = this.productImgs;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class Brand {
  int? id;
  String? name;

  Brand({this.id, this.name});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Attributes {
  int? id;
  String? name;
  String? optionGroup;

  Attributes({this.id, this.name, this.optionGroup});

  Attributes.fromJson(Map<String, dynamic> json) {
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
