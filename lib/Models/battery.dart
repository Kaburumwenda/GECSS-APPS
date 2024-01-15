class BatteryModel {
  int? id;
  String? code;
  String? location;
  String? batteryCapacity;
  String? status;
  String? batteryCondition;
  String? batteryConditionDate;
  String? make;
  String? model;
  int? productionYear;
  double? purchasePrice;
  String? purchasePriceCurrency;
  String? deploymentDate;
  String? estimatedSoh;
  String? remarks;

  BatteryModel(
      {this.id,
      this.code,
      this.location,
      this.batteryCapacity,
      this.status,
      this.batteryCondition,
      this.batteryConditionDate,
      this.make,
      this.model,
      this.productionYear,
      this.purchasePrice,
      this.purchasePriceCurrency,
      this.deploymentDate,
      this.estimatedSoh,
      this.remarks});

  BatteryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    location = json['location'];
    batteryCapacity = json['battery_capacity'];
    status = json['status'];
    batteryCondition = json['battery_condition'];
    batteryConditionDate = json['battery_condition_date'];
    make = json['make'];
    model = json['model'];
    productionYear = json['production_year'];
    purchasePrice = json['purchase_price'];
    purchasePriceCurrency = json['purchase_price_currency'];
    deploymentDate = json['deployment_date'];
    estimatedSoh = json['estimated_soh'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['location'] = location;
    data['battery_capacity'] = batteryCapacity;
    data['status'] = status;
    data['battery_condition'] = batteryCondition;
    data['battery_condition_date'] = batteryConditionDate;
    data['make'] = make;
    data['model'] = model;
    data['production_year'] = productionYear;
    data['purchase_price'] = purchasePrice;
    data['purchase_price_currency'] = purchasePriceCurrency;
    data['deployment_date'] = deploymentDate;
    data['estimated_soh'] = estimatedSoh;
    data['remarks'] = remarks;
    return data;
  }
}
