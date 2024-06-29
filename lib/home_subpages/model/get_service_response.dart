class GetServiceResponse {
  String? status;
  String? message;
  List<Data>? data;

  GetServiceResponse({this.status, this.message, this.data});

  GetServiceResponse.fromJson(Map<String, dynamic> json) {
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
  String? servicename;
  String? category;
  String? price;
  String? photo;

  Data(
      {this.saloonid, this.servicename, this.category, this.price, this.photo});

  Data.fromJson(Map<String, dynamic> json) {
    saloonid = json['saloonid'];
    servicename = json['servicename'];
    category = json['category'];
    price = json['price'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['saloonid'] = saloonid;
    data['servicename'] = servicename;
    data['category'] = category;
    data['price'] = price;
    data['photo'] = photo;
    return data;
  }
}
