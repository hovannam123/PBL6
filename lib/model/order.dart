import 'package:pbl6/model/product.dart';

class Order {
  int? id;
  String? dayOrder;
  Bill? bill;
  Brand? orderStatus;

  Order({
    this.id,
    this.dayOrder,
  });

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dayOrder = json['dayOrder'];
    bill = json['bill'] != null ? new Bill.fromJson(json['bill']) : null;
    orderStatus = json['orderStatus'] != null
        ? new Brand.fromJson(json['orderStatus'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dayOrder'] = this.dayOrder;
    if (this.bill != null) {
      data['bill'] = this.bill!.toJson();
    }
    if (this.orderStatus != null) {
      data['orderStatus'] = this.orderStatus!.toJson();
    }
    return data;
  }
}

class Bill {
  int? id;
  num? total;
  String? day;
  bool? type;
  List<BillDetails>? billDetails;

  Bill({this.id, this.total, this.day, this.type, this.billDetails});

  Bill.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    day = json['day'];
    type = json['type'];
    if (json['billDetails'] != null) {
      billDetails = <BillDetails>[];
      json['billDetails'].forEach((v) {
        billDetails!.add(new BillDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total'] = this.total;
    data['day'] = this.day;
    data['type'] = this.type;
    if (this.billDetails != null) {
      data['billDetails'] = this.billDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BillDetails {
  int? id;
  OrderDetail? orderDetail;
  double? totalPayable;

  BillDetails({this.id, this.orderDetail, this.totalPayable});

  BillDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderDetail = json['orderDetail'] != null
        ? new OrderDetail.fromJson(json['orderDetail'])
        : null;
    totalPayable = json['totalPayable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.orderDetail != null) {
      data['orderDetail'] = this.orderDetail!.toJson();
    }
    data['totalPayable'] = this.totalPayable;
    return data;
  }
}

class OrderDetail {
  int? id;
  int? amount;
  Product? product;

  OrderDetail({this.id, this.amount, this.product});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}
