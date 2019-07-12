import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/shop_cart_page/cart_item.dart';
import 'package:flutter_shop/pages/shop_cart_page/shop_cart_bottom.dart';
import 'package:provide/provide.dart';
import '../provide/counter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/shopCartInfo.dart';
import '../provide/shop_car.dart';

class ShopCarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: FutureBuilder(
        future: _getShopCarInfo(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List shopCartList =
                Provide.value<ShopCarProvide>(context).cartInfoList;
            return Stack(
              children: <Widget>[
                Provide<ShopCarProvide>(
                  builder: (context, child, val) {
                    shopCartList =
                        Provide.value<ShopCarProvide>(context).cartInfoList;
                    return ListView.builder(
                      itemCount: shopCartList.length,
                      itemBuilder: (context, index) {
                        return CartItemPage(shopCartList[index]);
                      },
                    );
                  },
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: ShopCartBottomPage(),
                ),
              ],
            );
          } else {
            return Text('空空如也');
          }
        },
      ),
    );
  }

  Future<String> _getShopCarInfo(BuildContext context) async {
    await Provide.value<ShopCarProvide>(context).getCartInfo();
    return 'end';
  }
}
