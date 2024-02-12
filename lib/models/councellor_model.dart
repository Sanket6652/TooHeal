class counceller_data {
  List<Data>? data;
  bool? success;

  counceller_data({this.data, this.success});

  counceller_data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}

class Data {
  int? id;
  String? username;
  String? smallDiscription;
  String? discription;
  String? callCharges;

  Data(
      {this.id,
      this.username,
      this.smallDiscription,
      this.discription,
      this.callCharges});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    smallDiscription = json['small_discription'];
    discription = json['discription'];
    callCharges = json['call_charges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['small_discription'] = this.smallDiscription;
    data['discription'] = this.discription;
    data['call_charges'] = this.callCharges;
    return data;
  }
}