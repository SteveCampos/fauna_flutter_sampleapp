import 'package:fauna_app/address.dart';
import 'package:fauna_app/credit_card.dart';
import 'package:fauna_app/customer.dart';
import 'package:fauna_app/fauna_data.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import 'package:flutter/material.dart';

class SampleProvider with ChangeNotifier {
  List<FaunaData<Customer>> items = [];

  FaunaClient _client;

  void init() {
    final config = FaunaConfig.build(
      secret: 'FAUNA_SECRET_KEY_HERE',
    );
    _client = FaunaClient(config);
    readData();
  }

  @override
  void dispose() {
    _client.close();
    super.dispose();
  }

  void readData() async {
    print('readData...');

    //final query = Paginate(Match(Index('all_customers')));
    final mappedList = Map_(Paginate(Documents(Collection('customers'))),
        Lambda('customerRef', Get(Var('customerRef'))));

    final FaunaResponse result = await _client.query(mappedList);

    final page = result.asPage();

    final List<FaunaData<Customer>> list = page.data
        .map((item) => FaunaData<Customer>.fromJson(
            item, (item) => Customer.fromJson(item)))
        .toList();
    items = list;
    notifyListeners();

    print('list size: ${list.length}');

    print('page: $page');
  }

  void updateCustomer(FaunaData<Customer> customer) async {
    print('updateCustomer...');
    final updateCustomer = Update(
        customer.ref, Obj({'firstName': "Steve", 'lastName': "Campos Vega"}));
    final response = await _client.query(updateCustomer);
    print('response: $response');

    readData();
  }

  void deleteCustomer(FaunaData<Customer> customer) async {
    print('deleteCustomer...');
    final deleteUser = Delete(customer.ref);
    final response = await _client.query(deleteUser);
    print('response: $response');
    reload();
  }

  void createCustomer(Customer customer) async {
    print('createUser...');
    final createUser =
        Create(Collection('customers'), Obj({'data': customer.toJson()}));
    final response = await _client.query(createUser);
    print('createUser response: $response');
    reload();
  }

  void reload() {
    readData();
  }

  void createRandomCustomer() {
    final customer = Customer(
        firstName: "Steve",
        lastName: "Campos Vega",
        address: Address(
            street: "Forestales",
            city: "La Molina",
            state: "Lima",
            zipCode: "51"),
        telephone: "+51923490928",
        creditCard: CreditCard(network: "Visa", number: "4545 9028 3311 3221"));
    createCustomer(customer);
  }
}
