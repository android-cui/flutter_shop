import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/shopCartInfo.dart';
import 'package:flutter_shop/provide/shop_car.dart';
import 'package:provide/provide.dart';

class CartCount extends StatelessWidget {
  final ShopCartInfo item;

  CartCount(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(169),
      height: ScreenUtil().setHeight(45),
      margin: EdgeInsets.only(top: 5.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.black12),
      ),
      child: Row(
        children: <Widget>[
          _reduceBotton(context, item),
          _count(context, item),
          _addBotton(context, item)
        ],
      ),
    );
  }

  /*
   *  减号 
   */
  Widget _reduceBotton(context, item) {
    return InkWell(
      onTap: () {
        Provide.value<ShopCarProvide>(context).addOrReduceGood(item, 'reduce');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: item.count >1 ? Colors.white :Colors.black12,
            border: Border(
                right: BorderSide(
              width: 1.0,
              color: Colors.black12,
            ))),
        child: item.count >1 ? Text('-') :Text(' '),
      ),
    );
  }

  /*
   *  加号 
   */
  Widget _addBotton(context, item) {
    return InkWell(
      onTap: () {
        Provide.value<ShopCarProvide>(context).addOrReduceGood(item, 'add');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                left: BorderSide(
              width: 1.0,
              color: Colors.black12,
            ))),
        child: Text('+'),
      ),
    );
  }

  /*
   *  数量 
   */
  Widget _count(context, item) {
    return Container(
      width: ScreenUtil().setWidth(75),
      height: ScreenUtil().setHeight(45),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text('${item.count}'),
    );
  }
}
