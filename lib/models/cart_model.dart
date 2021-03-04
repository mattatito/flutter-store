import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lojaonline/datas/cart_product.dart';
import 'package:lojaonline/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  List<CartProduct> products = [];
  UserModel user;

  String couponCode;
  int discountPercentage = 0;

  CartModel(this.user){
    if(user.isLoggedIn())
      _loadCartItems();

  }



  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);
  bool isLoading = false;

  void decProduct(CartProduct cartProduct) {
    cartProduct.quantity--;
    print(cartProduct.quantity);
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.cid)
        .updateData(cartProduct.toMap());
    notifyListeners();
  }

  void incProduct(CartProduct cartProduct) {
    cartProduct.quantity++;
    print(cartProduct.quantity);
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.cid)
        .updateData(cartProduct.toMap());
    notifyListeners();
  }

  void setCoupon(String coupon, int discountPercentage){
    this.couponCode = coupon;
    this.discountPercentage = discountPercentage;
  }

  void addCartItem(CartProduct cartProduct) {
    products.add(cartProduct);
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .add(cartProduct.toMap())
        .then((doc) {
      cartProduct.cid = doc.documentID;
    });

    notifyListeners();
  }

  void finishOrder(){
    if(products.length == 0) return;

    

  }

  double getProductsPrice(){
    double price = 0.0;
    for(CartProduct c in products){
      if(c.productData != null)
        price+= c.quantity* c.productData.price;
    }
    return price;

  }
  void updatePrices(){
    notifyListeners();
  }

  double getDiscount(){
    return getProductsPrice() * discountPercentage / 100;
  }

  double getShipPrice(){
    return 9.99;
  }



  void _loadCartItems() async {
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid).collection("cart").getDocuments();

    products = querySnapshot.documents.map((doc)=>CartProduct.fromDocument(doc)).toList();
    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct) {
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.cid)
        .delete();
    products.remove(cartProduct);
    notifyListeners();
  }
}
