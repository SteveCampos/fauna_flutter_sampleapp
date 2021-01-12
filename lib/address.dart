class Address {
  String street;
  String city;
  String state;
  String zipCode;

  Address({this.street, this.city, this.state, this.zipCode});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zipCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zipCode'] = this.zipCode;
    return data;
  }

  @override
  String toString() {
    return 'Address{street: $street, city: $city, state: $state, zipCode: $zipCode}';
  }
}