class AddressModel {
  AddressModel({
      this.status, 
      this.message, 
      this.data,});

  AddressModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? status;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      this.salonName,});

  Data.fromJson(dynamic json) {
    if (json['Salon_Name'] != null) {
      salonName = [];
      json['Salon_Name'].forEach((v) {
        salonName?.add(SalonName.fromJson(v));
      });
    }
  }
  List<SalonName>? salonName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (salonName != null) {
      map['Salon_Name'] = salonName?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class SalonName {
  SalonName({
      this.fname, 
      this.payAddress, 
      this.payCity, 
      this.payState, 
      this.payPincode, 
      this.postCode,});

  SalonName.fromJson(dynamic json) {
    fname = json['fname'];
    payAddress = json['pay_address'];
    payCity = json['pay_city'];
    payState = json['pay_state'];
    payPincode = json['pay_pincode'];
    postCode = json['post_code'];
  }
  String? fname;
  String? payAddress;
  String? payCity;
  String? payState;
  String? payPincode;
  String? postCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fname'] = fname;
    map['pay_address'] = payAddress;
    map['pay_city'] = payCity;
    map['pay_state'] = payState;
    map['pay_pincode'] = payPincode;
    map['post_code'] = postCode;
    return map;
  }

}