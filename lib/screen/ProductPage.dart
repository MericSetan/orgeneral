import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final String dealerUid;
  final String productUid;

  ProductPage({
    @required this.dealerUid,
    @required this.productUid,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('orgeneral')),
      body: Text('dealer: $dealerUid, productUid: $productUid'),
    );
  }
}
