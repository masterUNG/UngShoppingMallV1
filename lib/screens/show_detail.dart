import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ungshoppingmall/models/product_model.dart';

class ShowDetail extends StatefulWidget {
  final ProductModel productModel;
  ShowDetail({this.productModel});
  @override
  _ShowDetailState createState() => _ShowDetailState();
}

class _ShowDetailState extends State<ShowDetail> {
  ProductModel productModel;

  @override
  void initState() {
    super.initState();
    setState(() {
      productModel = widget.productModel;
      print('url ==> ${productModel.pathImage}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: productModel == null
            ? Text('Show detail')
            : Text('Show ${productModel.name}'),
      ),
      body: Column(
        children: <Widget>[
          showImage(),
          Text(productModel.detail),
        ],
      ),
    );
  }

  Widget showImage() => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.5,
        child: CachedNetworkImage(
          imageUrl: productModel.pathImage,
          placeholder: (value, string) => Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
}
