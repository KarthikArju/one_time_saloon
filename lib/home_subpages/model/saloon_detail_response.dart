class SaloonDetailResponse {
  String? status;
  String? message;
  List<Data>? data;

  SaloonDetailResponse({this.status, this.message, this.data});

  SaloonDetailResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? saloonid;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? msg;

  Data(
      {this.saloonid,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.msg});

  Data.fromJson(Map<String, dynamic> json) {
    saloonid = json['saloonid'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['saloonid'] = saloonid;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['msg'] = msg;
    return data;
  }
}
