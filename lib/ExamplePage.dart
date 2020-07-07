import 'package:flutter/material.dart';
import 'package:orgeneral/services/db.dart';

var db = DatabaseService();

class ExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          RaisedButton(onPressed: () => getAllDealers(), child: Text('ge dealers')),
          RaisedButton(onPressed: () => getDealer('AXvFV6xY7Y94PeDbFyHy'), child: Text('get dealer')),
          RaisedButton(onPressed: () => getProducts('AXvFV6xY7Y94PeDbFyHy'), child: Text('get products')),
          RaisedButton(onPressed: () => getProduct('AXvFV6xY7Y94PeDbFyHy','tof9O7PGJYTcZFcc4XYT'), child: Text('get product')),
          RaisedButton(onPressed: () => getDealerComments('AXvFV6xY7Y94PeDbFyHy'), child: Text('get dealer comments')),
          RaisedButton(onPressed: () => getProductComments('AXvFV6xY7Y94PeDbFyHy','tof9O7PGJYTcZFcc4XYT'), child: Text('get product comments')),

        ],
      ),
    );
  }
}

getAllDealers() {
  var dealersStream = db.streamDealers();
  dealersStream.listen((event) {
    event.forEach((dealer) {
      print('${dealer.uid}: ${dealer.toMap()}');
    });
  });
}

getDealer(String dealerId) {
  var dealerStream = db.streamDealer(dealerId);
  dealerStream.listen((event) {
    print('${event.uid}: ${event.toMap()}');
  });
}
// hahahaa deneme 1

getProducts(String dealerId) {
  var productsStream = db.streamProducts(dealerId);
  productsStream.listen((event) {
    event.forEach((product) {
      print('${product.uid}: ${product.toMap()}');
    });
  });
}

getProduct(String dealerId, String productId) {
  var productStream = db.streamProduct(dealerId, productId);
  productStream.listen((event) {
    print('${event.uid}: ${event.toMap()}');
  });
}

getDealerComments(String dealerId) {
  var commentsStream = db.streamDealerComments(dealerId);
  commentsStream.listen((event) {
    event.forEach((product) {
      print('${product.uid}: ${product.toMap()}');
    });
  });
}

getProductComments(String dealerId, String productId) {
  var commentsStream = db.streamProductComments(dealerId,productId);
  commentsStream.listen((event) {
    event.forEach((product) {
      print('${product.uid}: ${product.toMap()}');
    });
  });
}
