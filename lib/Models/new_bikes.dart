class NewMotobikes {
  int? id;
  String? numberplate;
  String? client;
  String? clientPhone;
  String? country;
  String? status;
  String? condition;
  String? model;
  String? make;
  String? chassisNo;
  String? motorNo;
  String? color;
  String? conditionDate;
  String? deploymentDate;
  String? isDelete;
  String? remarks;
  String? createdAt;
  String? updatedAt;

  NewMotobikes(
      {this.id,
      this.numberplate,
      this.client,
      this.clientPhone,
      this.country,
      this.status,
      this.condition,
      this.model,
      this.make,
      this.chassisNo,
      this.motorNo,
      this.color,
      this.conditionDate,
      this.deploymentDate,
      this.isDelete,
      this.remarks,
      this.createdAt,
      this.updatedAt});

  NewMotobikes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    numberplate = json['numberplate'];
    client = json['client'];
    clientPhone = json['client_phone'];
    country = json['country'];
    status = json['status'];
    condition = json['condition'];
    model = json['model'];
    make = json['make'];
    chassisNo = json['chassis_no'];
    motorNo = json['motor_no'];
    color = json['color'];
    conditionDate = json['condition_date'];
    deploymentDate = json['deployment_date'];
    isDelete = json['is_delete'];
    remarks = json['remarks'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['numberplate'] = numberplate;
    data['client'] = client;
    data['client_phone'] = clientPhone;
    data['country'] = country;
    data['status'] = status;
    data['condition'] = condition;
    data['model'] = model;
    data['make'] = make;
    data['chassis_no'] = chassisNo;
    data['motor_no'] = motorNo;
    data['color'] = color;
    data['condition_date'] = conditionDate;
    data['deployment_date'] = deploymentDate;
    data['is_delete'] = isDelete;
    data['remarks'] = remarks;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
