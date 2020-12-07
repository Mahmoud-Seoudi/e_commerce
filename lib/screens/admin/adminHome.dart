import 'package:buy_it/constants.dart';
import 'package:buy_it/screens/admin/addProduct.dart';
import 'package:buy_it/screens/admin/manageProduct.dart';
import 'package:buy_it/screens/admin/orders_screen.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {
  static String id = 'AdminHome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, AddProduct.id);
            },
            child: Text(
              'Add Product',
            ),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, ManageProduct.id);
            },
            child: Text(
              'Manage Product',
            ),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, OrderScreen.id);
            },
            child: Text(
              'View Orders',
            ),
          ),
        ],
      ),
    );
  }
}
