class RegisterRequest {
  UserDetail? userDetail;
  String? username;
  String? password;
  List<int>? roles;

  RegisterRequest({this.userDetail, this.username, this.password, this.roles});

  RegisterRequest.fromJson(Map<String, dynamic> json) {
    userDetail = json['userDetail'] != null
        ? new UserDetail.fromJson(json['userDetail'])
        : null;
    username = json['username'];
    password = json['password'];
    roles = json['roles'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userDetail != null) {
      data['userDetail'] = this.userDetail!.toJson();
    }
    data['username'] = this.username;
    data['password'] = this.password;
    data['roles'] = this.roles;
    return data;
  }
}

class UserDetail {
  String? name;
  String? dateOfBirth;
  String? address;
  String? phoneNumber;
  bool? gender;
  String? email;

  UserDetail(
      {this.name,
      this.dateOfBirth,
      this.address,
      this.phoneNumber,
      this.gender,
      this.email});

  UserDetail.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dateOfBirth = json['dateOfBirth'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['dateOfBirth'] = this.dateOfBirth;
    data['address'] = this.address;
    data['phoneNumber'] = this.phoneNumber;
    data['gender'] = this.gender;
    data['email'] = this.email;
    return data;
  }
}
