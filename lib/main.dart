import 'package:fauna_app/sample_provider.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => SampleProvider()..init(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SampleProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Fauna samples'),
      ),
      body: ListView(
        children: Provider.of<SampleProvider>(context)
            .items
            .map(
              (i) => ListTile(
                title: Text('${i.item.firstName} ${i.item.lastName}'),
                subtitle: Text('${i.item.telephone}'),
                trailing: Icon(Icons.phone),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('ts: ${i.ts.toString()}'),
                          content: Text('customer: ${i.item}'),
                        );
                      });
                },
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("¿Está seguro de eliminar?"),
                          actions: [
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('No, Conservar')),
                            FlatButton(
                                onPressed: () {
                                  provider.deleteCustomer(i);
                                  Navigator.of(context).pop();
                                },
                                child: Text('Sí, Eliminar')),
                          ],
                        );
                      });
                },
                leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage('https://i.stack.imgur.com/Qt4JP.png'),
                ),
              ),
            )
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => provider.createRandomCustomer(),
      ),
    );
  }
}
