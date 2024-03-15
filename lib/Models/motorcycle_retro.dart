class MotorcycleRetro {
  int? id;
  String? client;
  String? clientPhone;
  String? country;
  String? model;
  String? make;
  String? createdAt;
  String? updatedAt;
  String? remarks;
  String? engineNo;
  String? chassisNo;
  String? numberPlate;
  String? motorNo;
  String? supervisor;
  String? approval;
  String? status;
  String? condition;
  String? conditionDate;

  MotorcycleRetro(
      {this.id,
      this.client,
      this.clientPhone,
      this.country,
      this.model,
      this.make,
      this.createdAt,
      this.updatedAt,
      this.remarks,
      this.engineNo,
      this.chassisNo,
      this.numberPlate,
      this.motorNo,
      this.supervisor,
      this.approval,
      this.status,
      this.condition,
      this.conditionDate});

  MotorcycleRetro.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    client = json['client'];
    clientPhone = json['client_phone'];
    country = json['country'];
    model = json['model'];
    make = json['make'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    remarks = json['remarks'];
    engineNo = json['engine_no'];
    chassisNo = json['chassis_no'];
    numberPlate = json['number_plate'];
    motorNo = json['motor_no'];
    supervisor = json['supervisor'];
    approval = json['approval'];
    status = json['status'];
    condition = json['condition'];
    conditionDate = json['condition_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['client'] = client;
    data['client_phone'] = clientPhone;
    data['country'] = country;
    data['model'] = model;
    data['make'] = make;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['remarks'] = remarks;
    data['engine_no'] = engineNo;
    data['chassis_no'] = chassisNo;
    data['number_plate'] = numberPlate;
    data['motor_no'] = motorNo;
    data['supervisor'] = supervisor;
    data['approval'] = approval;
    data['status'] = status;
    data['condition'] = condition;
    data['condition_date'] = conditionDate;
    return data;
  }
}
