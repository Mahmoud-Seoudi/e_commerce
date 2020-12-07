import 'package:buy_it/constants.dart';
import 'package:buy_it/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  final Firestore _firestore = Firestore.instance;

  addProduct(Product product) async {
    _firestore.collection(kProductCollection).add({
      kProductName: product.pName,
      kProductPrice: product.pPrice,
      kProductDescription: product.pDescription,
      kProductCategory: product.pCategory,
      kProductLocation: product.pLocation,
    });
  }

  Stream<QuerySnapshot> loadProduct() {
    return _firestore.collection(kProductCollection).snapshots();
  }

  deleteProduct(documentId) {
    _firestore.collection(kProductCollection).document(documentId).delete();
  }

  Stream<QuerySnapshot> loadOrders() {
    return _firestore.collection(kOrders).snapshots();
  }

  Stream<QuerySnapshot> loadOrdersDetails(documentId) {
    return _firestore
        .collection(kOrders)
        .document(documentId)
        .collection(kOrderDetails)
        .snapshots();
  }

  editProduct(data, documentId) {
    _firestore
        .collection(kProductCollection)
        .document(documentId)
        .updateData(data);
  }

  storeOrders(data, List<Product> products) {
    var documentRef = _firestore.collection(kOrders).document();
    documentRef.setData(data);
    for (var product in products) {
      documentRef.collection(kOrderDetails).document().setData({
        kProductName: product.pName,
        kProductPrice: product.pPrice,
        kProductDescription: product.pDescription,
        kProductCategory: product.pCategory,
        kProductQuantity: product.pQuantity,
        kProductLocation: product.pLocation,
      });
    }
  }
}
