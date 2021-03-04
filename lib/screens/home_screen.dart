import 'package:flutter/material.dart';
import 'package:lojaonline/tabs/home_tab.dart';
import 'package:lojaonline/tabs/products_tab.dart';
import 'package:lojaonline/widgets/cart_button.dart';
import 'package:lojaonline/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(title: Text("Produtos"),
          centerTitle: true,),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: CartButton(),
          body: ProductsTab(),
        )
      ],
    );
  }
}
