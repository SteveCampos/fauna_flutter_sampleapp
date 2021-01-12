class CreditCard {
  String network;
  String number;

  CreditCard({this.network, this.number});

  CreditCard.fromJson(Map<String, dynamic> json) {
    network = json['network'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['network'] = this.network;
    data['number'] = this.number;
    return data;
  }

  @override
  String toString() {
    return 'CreditCard{network: $network, number: $number}';
  }
}