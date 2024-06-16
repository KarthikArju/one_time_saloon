class SaloonListResponse {
  String? status;
  String? message;
  Data? data;

  SaloonListResponse({this.status, this.message, this.data});

  SaloonListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status']; 
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
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
  List<SalonName>? salonName;

  Data({this.salonName});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['Salon_Name'] != null) {
      salonName = <SalonName>[];
      json['Salon_Name'].forEach((v) {
        salonName!.add(new SalonName.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (salonName != null) {
      data['Salon_Name'] = salonName!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SalonName {
  String? saloonid;
  String? name;
  String? email;
  String? phone;
  String? address;

  SalonName({this.saloonid, this.name, this.email, this.phone, this.address});

  SalonName.fromJson(Map<String, dynamic> json) {
    saloonid = json['saloonid'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['saloonid'] = saloonid;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    return data;
  }
}
