import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';

class FaunaData<T> {
  Ref ref;
  Object ts;
  T item;

  FaunaData.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) parser) {
    ref = (json['ref'] as RefResult).asRef();
    ts = json['ts'];
    item = parser(json['data']);
  }
}
