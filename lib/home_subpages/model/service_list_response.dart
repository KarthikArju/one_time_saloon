class ServiceListResponse {
  String? status;
  String? message;
  Data? data;

  ServiceListResponse({this.status, this.message, this.data});

  ServiceListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<ServiceName>? serviceName;

  Data({this.serviceName});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['Service_Name'] != null) {
      serviceName = <ServiceName>[];
      json['Service_Name'].forEach((v) {
        serviceName!.add(new ServiceName.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (serviceName != null) {
      data['Service_Name'] = serviceName!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceName {
  String? saloonid;
  String? servicename;
  String? category;
  String? price;
  String? photo;

  ServiceName(
      {this.saloonid, this.servicename, this.category, this.price, this.photo});

  ServiceName.fromJson(Map<String, dynamic> json) {
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
