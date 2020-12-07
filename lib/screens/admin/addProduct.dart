import 'package:buy_it/models/product.dart';
import 'package:buy_it/widgets/custome_textfield.dart';
import 'package:flutter/material.dart';
import 'package:buy_it/services/store.dart';

class AddProduct extends StatelessWidget {
  static String id = 'AddProduct';
  String _name, _price, _description, _category, _imageLocation;
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Form(
        key: _globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomeTextField(
              hint: 'Product Name',
              icon: null,
              onClick: (value) {
                _name = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomeTextField(
              hint: 'Product Price',
              icon: null,
              onClick: (value) {
                _price = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomeTextField(
              hint: 'Product Description',
              icon: null,
              onClick: (value) {
                _description = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomeTextField(
              hint: 'Product Category',
              icon: null,
              onClick: (value) {
                _category = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomeTextField(
              hint: 'Product Location',
              icon: null,
              onClick: (value) {
                _imageLocation = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              onPressed: () {
                if (_globalKey.currentState.validate()) {
                  _globalKey.currentState.save();

                  _store.addProduct(Product(
                    pName: _name,
                    pPrice: _price,
                    pDescription: _description,
                    pCategory: _category,
                    pLocation: _imageLocation,
                  ));
                }
              },
              child: Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
