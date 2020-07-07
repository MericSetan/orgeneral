import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:orgeneral/data/comment_service.dart';
import 'package:orgeneral/data/dealer_service.dart';
import 'package:orgeneral/data/product_service.dart';
import 'package:orgeneral/model/Comment.dart';
import 'package:orgeneral/model/Product.dart';
import 'package:orgeneral/model/Dealer.dart';
import 'package:orgeneral/screen/DealerPage.dart';
import 'package:orgeneral/widget/CommentsListView.dart';

class ProductPage extends StatefulWidget {
  final String dealerUid;
  final String productUid;

  ProductPage({
    @required this.dealerUid,
    @required this.productUid,
  });

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  BuildContext _context;

  @override
  void initState() {
    super.initState();
    setState(() {
      asyncInitState();
    });
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(title: Text('orgeneral')),
      body: buildListView(),
    );
  }

  Dealer dealer = Dealer();
  Product product = Product();

  List<Comment> comments = List();

  Future<void> asyncInitState() async {
    await DealerService.getWithUid(widget.dealerUid).then((_dealer) => dealer = _dealer);
    await ProductService.getWithUid(widget.dealerUid, widget.productUid).then((_product) {
      setState(() {
        product = _product;
      });
    });
    await CommentService.getInProduct(dealerUid: widget.dealerUid, productUid: product.uid)
        .then((_comments) {
      setState(() {
        comments = _comments;
      });
    });
  }

  Widget buildListView() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: ListView(
        physics: ScrollPhysics(),
        children: <Widget>[
          buildProductImage(),
          buildProductDetails(),
          buildProductComments(),
        ],
      ),
    );
  }

  Widget buildProductImage() {
    return Container(
      height: MediaQuery.of(_context).size.width,
      child: CachedNetworkImage(
        imageUrl: product.imageUrl,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  Widget buildProductComments() {
    return Column(
      children: <Widget>[
        Text('yorumlar'),
        CommentListView(comments: comments),
      ],
    );
  }

  Widget buildProductDetails() {
    return Column(
      children: <Widget>[
        Text(product.name),
        Text('${product.unit} ${product.price} ₺ '),
        RaisedButton(
            onPressed: () {
              Navigator.push(
                  _context,
                  MaterialPageRoute(
                    builder: (context) => DealerPage(
                      dealer: dealer,
                    ),
                  ));
            },
            child: Text(dealer.name)),
      ],
    );
  }
}
