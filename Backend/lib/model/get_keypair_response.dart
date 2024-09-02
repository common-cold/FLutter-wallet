class GetKeyPairResponse {
  List<String>? mnemonic;
  String? publicKey;
  String? privateKey;

  GetKeyPairResponse({this.mnemonic, this.publicKey, this.privateKey});

  GetKeyPairResponse.fromJson(Map<String, dynamic> json) {
    mnemonic = json['mnemonic'].cast<String>();
    publicKey = json['publicKey'];
    privateKey = json['privateKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mnemonic'] = this.mnemonic;
    data['publicKey'] = this.publicKey;
    data['privateKey'] = this.privateKey;
    return data;
  }
}
