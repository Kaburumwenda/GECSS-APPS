class MpesaTransactions {
  int? id;
  String? transactionType;
  String? transID;
  String? transTime;
  String? firstName;
  String? transAmount;
  String? billRefNumber;
  String? orgAccountBalance;
  String? agentCommission;
  String? mSISDN;
  String? created;

  MpesaTransactions(
      {this.id,
      this.transactionType,
      this.transID,
      this.transTime,
      this.firstName,
      this.transAmount,
      this.billRefNumber,
      this.orgAccountBalance,
      this.agentCommission,
      this.mSISDN,
      this.created});

  MpesaTransactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionType = json['transactionType'];
    transID = json['transID'];
    transTime = json['transTime'];
    firstName = json['firstName'];
    transAmount = json['transAmount'];
    billRefNumber = json['billRefNumber'];
    orgAccountBalance = json['orgAccountBalance'];
    agentCommission = json['agentCommission'];
    mSISDN = json['MSISDN'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['transactionType'] = transactionType;
    data['transID'] = transID;
    data['transTime'] = transTime;
    data['firstName'] = firstName;
    data['transAmount'] = transAmount;
    data['billRefNumber'] = billRefNumber;
    data['orgAccountBalance'] = orgAccountBalance;
    data['agentCommission'] = agentCommission;
    data['MSISDN'] = mSISDN;
    data['created'] = created;
    return data;
  }
}
