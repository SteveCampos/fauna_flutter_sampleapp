import 'package:fauna_app/address.dart';
import 'package:fauna_app/credit_card.dart';

class Customer {
  String firstName;
  String lastName;
  Address address;
  String telephone;
  CreditCard creditCard;

  Customer(
      {this.firstName,
      this.lastName,
      this.address,
      this.telephone,
      this.creditCard});

  Customer.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    telephone = json['telephone'];
    creditCard = json['creditCard'] != null
        ? new CreditCard.fromJson(json['creditCard'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['telephone'] = this.telephone;
    if (this.creditCard != null) {
      data['creditCard'] = this.creditCard.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'Customer{firstName: $firstName, lastName: $lastName, address: $address, telephone: $telephone, creditCard: $creditCard}';
  }
}
