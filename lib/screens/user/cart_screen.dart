import 'dart:ui';

import 'package:buy_it/constants.dart';
import 'package:buy_it/models/product.dart';
import 'package:buy_it/provider/cart_item.dart';
import 'package:buy_it/screens/user/product_info.dart';
import 'package:buy_it/services/store.dart';
import 'package:buy_it/widgets/custom_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static String id = 'CartScreen';
  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<CartItem>(context).products;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          'My Cart'.toUpperCase(),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          LayoutBuilder(
            builder: (context, constrains) {
              if (products.isNotEmpty) {
                return Container(
                  height: screenHeight -
                      statusBarHeight -
                      appBarHeight -
                      (screenHeight * .08),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: GestureDetector(
                          onTapUp: (details) {
                            showCustomMenu(details, context, products[index]);
                          },
                          child: Container(
                            height: screenHeight * 0.1,
                            color: kInputTextColor,
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: screenHeight * 0.1 / 2,
                                  backgroundImage: AssetImage(
                                    products[index].pLocation,
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              products[index].pName,
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(
                                              '\$${products[index].pPrice}',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20.0),
                                        child: Text(
                                          products[index].pQuantity.toString(),
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: products.length,
                  ),
                );
              } else
                return Container(
                  height: screenHeight -
                      (screenHeight * .08) -
                      appBarHeight -
                      statusBarHeight,
                  child: Center(
                    child: Text('Cart is Empty....'),
                  ),
                );
            },
          ),
          Builder(
            builder: (context) => ButtonTheme(
              minWidth: screenWidth,
              height: screenHeight * 0.07,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: RaisedButton(
                onPressed: () {
                  showCustomDialog(products, context);
                },
                child: Text(
                  'Order Now'.toUpperCase(),
                ),
                color: kMainColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showCustomMenu(details, context, product) async {
    double dx = details.globalPosition.dx;
    double dy = details.globalPosition.dy;
    double dx2 = MediaQuery.of(context).size.width - dx;
    double dy2 = MediaQuery.of(context).size.width - dy;
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
      items: [
        MyPopupMenuItem(
          child: Text(
            'Edit',
          ),
          onClick: () {
            Navigator.pop(context);
            Provider.of<CartItem>(context, listen: false)
                .deleteProduct(product);
            Navigator.pushNamed(context, ProductInfo.id, arguments: product);
          },
        ),
        MyPopupMenuItem(
          child: Text('Delete'),
          onClick: () {
            Navigator.pop(context);
            Provider.of<CartItem>(context, listen: false)
                .deleteProduct(product);
          },
        ),
      ],
    );
  }

  void showCustomDialog(List<Product> products, context) async {
    var price = getTotalPrice(products);
    var address;

    AlertDialog alertDialog = AlertDialog(
      actions: <Widget>[
        MaterialButton(
          onPressed: () {
            try {
              Store _store = Store();
              _store.storeOrders({
                kTotalPrice: price,
                kAddress: address,
              }, products);
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Orderd Successfully ! '),
                ),
              );
              Navigator.pop(context);
            } catch (ex) {
              print(ex.message);
            }
          },
          child: Text(
            'Confirm',
          ),
        ),
      ],
      content: TextField(
        onChanged: (value) {
          address = value;
        },
        decoration: InputDecoration(hintText: 'Enter your address : '),
      ),
      title: Text('Total Price = \$ $price'),
    );
    await showDialog(
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }

  getTotalPrice(List<Product> products) {
    var price = 0;
    for (var product in products) {
      price += product.pQuantity * int.parse(product.pPrice);
    }
    return price;
  }
}
