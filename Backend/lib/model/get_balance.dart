class GetBalanceResponse {
  String? sols;
  String? balance;

  GetBalanceResponse({this.sols, this.balance});

  GetBalanceResponse.fromJson(Map<String, dynamic> json) {
    sols = json['sols'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sols'] = this.sols;
    data['balance'] = this.balance;
    return data;
  }
}