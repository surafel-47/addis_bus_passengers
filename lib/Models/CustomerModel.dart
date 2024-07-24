class CustomerModel {
  String objectId;
  int accountBalance;
  int paidAmount;
  String custId;
  String name;
  String phoneNo;
  String pin;

  String startStation = "";
  String endStation = "";

  CustomerModel({
    this.objectId = '',
    this.accountBalance = 0,
    this.paidAmount = 0,
    this.custId = '',
    this.name = '',
    this.phoneNo = '',
    this.pin = '',
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      objectId: json['_id'] ?? '',
      accountBalance: json['account_balance'] ?? 0,
      paidAmount: json['paid_amount'] ?? 0,
      custId: json['cust_id'] ?? '',
      name: json['name'] ?? '',
      phoneNo: json['phone_no'] ?? '',
      pin: json['pin'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': objectId,
      'account_balance': accountBalance,
      'paid_amount': paidAmount,
      'cust_id': custId,
      'name': name,
      'phone_no': phoneNo,
      'pin': pin,
    };
  }

  void printCustomerDetails() {
    print('Object ID: $objectId');
    print('Account Balance: $accountBalance');
    print('Paid Amount: $paidAmount');
    print('Customer ID: $custId');
    print('Name: $name');
    print('Phone Number: $phoneNo');
    print('PIN: $pin');
  }
}
