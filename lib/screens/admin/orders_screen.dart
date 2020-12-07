import 'dart:ui';

import 'package:buy_it/constants.dart';
import 'package:buy_it/models/orders.dart';
import 'package:buy_it/screens/admin/order_details.dart';
import 'package:buy_it/services/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  static String id = 'OrderScreen';
  final Store _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrders(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'there is no orders . ',
              ),
            );
          } else {
            List<Order> orders = [];
            for (var doc in snapshot.data.documents) {
              orders.add(
                Order(
                  documentId: doc.documentID,
                  totalPrice: doc.data[kTotalPrice],
                  address: doc.data[kAddress],
                ),
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, OrderDetails.id,
                        arguments: orders[index].documentId);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    color: kInputTextColor,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Total Price = \$ ${orders[index].totalPrice}',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Address : ${orders[index].address}',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              itemCount: orders.length,
            );
          }
        },
      ),
    );
  }
}
