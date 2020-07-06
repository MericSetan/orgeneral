import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:orgeneral/data/dealer_service.dart';
import 'package:orgeneral/data/product_service.dart';
import 'package:orgeneral/screen/ProductPage.dart';
import 'package:orgeneral/widget/ProductsGridView.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('orgeneral')),
      body: HomeGridView(),
    );
  }
}

class HomeGridView extends StatefulWidget {
  @override
  _HomeGridViewState createState() => _HomeGridViewState();
}

BuildContext _context;

class _HomeGridViewState extends State<HomeGridView> {
  List<Map<String, dynamic>> dapList = List(); // dap -> Dealer And Product

  @override
  void initState() {
    super.initState();
    asyncInitState();
  } //initState

  Future<void> asyncInitState() async {
    await DealerService.getAllDealers().then((_dealers) {
      dapList.clear();
      // setState(() {
      _dealers.forEach((_dealer) async {
        String _dealerUid = _dealer.referance.documentID;
        await ProductService.getInDealer(dealerUid: _dealerUid).then((_products) async {
          _products.forEach((_product) {
            setState(() {
              dapList.add({'dealer': _dealer, 'product': _product});
            });
          }); //product
        }); //products
      }); //dealer
      // }); //setState
    });
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return ProductsGridView(dapList);
  }
}