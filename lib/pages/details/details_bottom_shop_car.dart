import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/current_index.dart';
import 'package:provide/provide.dart';
import '../../provide/shop_car.dart';
import '../../provide/details_info.dart';

class DetailsBottom extends StatelessWidget {
  const DetailsBottom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var goodsInfo =
        Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo;

    var goodsName = goodsInfo.goodsName;
    var goodsId = goodsInfo.goodsId;
    var images = goodsInfo.image1;
    var price = goodsInfo.presentPrice;
    var oldPrice = goodsInfo.oriPrice;
    var count = 1;
    return Container(
        width: ScreenUtil().setWidth(750),
        height: ScreenUtil().setHeight(80),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            InkWell(
              onTap: () {
                Provide.value<CurrentIndexProvide>(context).changeIndex(2);
                Navigator.pop(context);
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(110),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.shopping_cart,
                      size: 35,
                      color: Colors.red,
                    ),
                  ),
                  Provide<ShopCarProvide>(
                    builder: (context, child, val) {
                      int goodCount =
                          Provide.value<ShopCarProvide>(context).allGoodCount;
                          print('asdasdasdasdasdasdasdasd${goodCount}');
                      return Positioned(
                        top: 0,
                        right: 5,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                          decoration: BoxDecoration(
                            color: Colors.pink,
                            border: Border.all(width: 2, color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${goodCount}',
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(24),
                                color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () async {
                await Provide.value<ShopCarProvide>(context).save(
                    goodsId, goodsName, count, price, images, oldPrice, true);
              },
              child: Container(
                  width: ScreenUtil().setWidth(320),
                  alignment: Alignment.center,
                  color: Colors.green,
                  child: Text(
                    '加入购物车',
                    style: TextStyle(
                        color: Colors.white, fontSize: ScreenUtil().setSp(28)),
                  )),
            ),
            InkWell(
              onTap: () async {
                await Provide.value<ShopCarProvide>(context).remove();
              },
              child: Container(
                  width: ScreenUtil().setWidth(320),
                  alignment: Alignment.center,
                  color: Colors.red,
                  child: Text(
                    '立即购买',
                    style: TextStyle(
                        color: Colors.white, fontSize: ScreenUtil().setSp(28)),
                  )),
            )
          ],
        ));
  }
}
