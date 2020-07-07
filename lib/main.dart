import 'package:flutter/material.dart';
import 'package:orgeneral/model/Dealer.dart';
import 'package:orgeneral/model/Product.dart';
import 'package:orgeneral/model/Comment.dart';
import 'package:orgeneral/services/db.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
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
      home: Example(),
    );
  }
}

class Example extends StatelessWidget {
  final db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamProvider<List<Comment>>.value(
        value: db.streamProductComments('AXvFV6xY7Y94PeDbFyHy', 'tof9O7PGJYTcZFcc4XYT'),
        child: ProductsList(),
      ),
    );
  }
}

class ProductsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var products = Provider.of<List<Product>>(context);
    var dealers = Provider.of<List<Comment>>(context);
    return Column(
      children: List.generate(dealers.length, (index) => Text('${dealers[index].content}')),
    );
  }
}
