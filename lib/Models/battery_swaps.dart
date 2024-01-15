class BatterySwaps {
  int? id;
  String? bikeNo;
  String? memNo;
  String? batteryCode1;
  int? amount;
  String? source;
  String? status;
  String? createdAt;
  String? updatedAt;

  BatterySwaps(
      {this.id,
      this.bikeNo,
      this.memNo,
      this.batteryCode1,
      this.amount,
      this.source,
      this.status,
      this.createdAt,
      this.updatedAt});

  BatterySwaps.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bikeNo = json['bike_no'];
    memNo = json['mem_no'];
    batteryCode1 = json['battery_code1'];
    amount = json['amount'];
    source = json['source'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bike_no'] = bikeNo;
    data['mem_no'] = memNo;
    data['battery_code1'] = batteryCode1;
    data['amount'] = amount;
    data['source'] = source;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
