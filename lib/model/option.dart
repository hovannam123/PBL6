class Option {
  int? id;
  String? name;
  List<OptionGroup>? optionGroup;

  Option({this.id, this.name, this.optionGroup});

  Option.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['optionGroup'] != null) {
      optionGroup = <OptionGroup>[];
      json['optionGroup'].forEach((v) {
        optionGroup!.add(new OptionGroup.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.optionGroup != null) {
      data['optionGroup'] = this.optionGroup!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OptionGroup {
  int? id;
  String? name;
  Null? category;
  List<Attributes>? attributes;

  OptionGroup({this.id, this.name, this.category, this.attributes});

  OptionGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(new Attributes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category'] = this.category;
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
    }
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
