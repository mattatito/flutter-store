import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojaonline/datas/product_data.dart';

class CartProduct {

  String cid;
  String category;
  String pid;
  int quantity;
  String size;

  ProductData productData;

  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot document){
    cid = document.id;
    category = document.data()["category"];
    pid = document.data()["pid"];
    quantity = document.data()["quantity"];
    size = document.data()["size"];
  }

  Map<String, dynamic> toMap(){
    return {
      "category":category,
      "pid":pid,
      "quantity": quantity,
      "size":size,
      "product": productData.toResumedMap()
    };
  }


}











