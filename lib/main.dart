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
    var dealerId = 'QFvm25W7Zrtj25Tj3DR2';
    return Container(
      child: StreamProvider<List<Product>>.value(
        value: db.streamProducts(dealerId),
        child: StreamBuilder<List<Product>>(
          stream: db.streamProducts(dealerId),
          builder: (context, snapshot) {
            if (!snapshot.hasError) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text('Offline!');
                case ConnectionState.waiting:
                  return Text('loading...');
                case ConnectionState.done:
                  return Text('okey gibi');
                case ConnectionState.active:
                  return ProductsList();
                default:
                  return Text('standart');
              }
            } else {
              return Text('Error');
            }
          },
        ),
      ),
    );
  }
}

class ProductsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var products = Provider.of<List<Product>>(context);
    var products = Provider.of<List<Product>>(context);
    Widget resultWidget;
    if (products != null && products.isNotEmpty) {
      resultWidget = Column(
        children: List.generate(products.length, (index) => Text('${products[index].name}')),
      );
    }else{
      resultWidget = Text('Ürün Yok');
    }

    return resultWidget;
  }
}
