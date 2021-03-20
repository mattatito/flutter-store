import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojaonline/models/user_model.dart';
import 'package:lojaonline/screens/login_screen.dart';
import 'package:lojaonline/tiles/order_tile.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (UserModel.of(context).isLoggedIn()) {
      String uid = UserModel.of(context).firebaseUser.uid;

      return FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection("users").doc(uid).collection("orders").get(),
          builder: (context, snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }else {
              return ListView(
                children: snapshot.data.docs.map((doc) => OrderTile(doc.id)).toList(),
              );
            }
          },
      );
    } else {
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.view_list,
              size: 80.0,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              "Faça o login para acompanhar seus produtos!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 16.0,
            ),
            RaisedButton(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Entrar",
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginScreen())),
            )
          ],
        ),
      );
    }
  }
}
