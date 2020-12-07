import 'package:buy_it/constants.dart';
import 'package:buy_it/models/product.dart';
import 'package:buy_it/services/store.dart';
import 'package:buy_it/widgets/custome_textfield.dart';
import 'package:flutter/material.dart';

class EditProduct extends StatelessWidget {
  static String id = 'EditProduct';

  String _name, _price, _description, _category, _imageLocation;
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Column(
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

                      _store.editProduct(
                          ({
                            kProductName: _name,
                            kProductPrice: _price,
                            kProductDescription: _description,
                            kProductCategory: _category,
                            kProductLocation: _imageLocation,
                          }),
                          product.pId);
                    }
                  },
                  child: Text('Update Product'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
