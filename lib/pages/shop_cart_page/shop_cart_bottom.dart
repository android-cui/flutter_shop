import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/shop_car.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopCartBottomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<ShopCarProvide>(
      builder: (context, child, val) {
        return Container(
          padding: EdgeInsets.all(5.0),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              _selectALlButton(context),
              _allPriceArea(context),
              _goButton(context),
            ],
          ),
        );
      },
    );
  }

/*
 * 全选按钮
 */
  Widget _selectALlButton(context) {
    bool isAllCheck = Provide.value<ShopCarProvide>(context).isAllCheck;
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: isAllCheck,
            activeColor: Colors.pink,
            onChanged: (bool val) {
              Provide.value<ShopCarProvide>(context).changeAllCheckButton(val);
            },
          ),
          Text('全选')
        ],
      ),
    );
  }

  /*
  *  商品总价
  */
  Widget _allPriceArea(context) {
    var allPrice = Provide.value<ShopCarProvide>(context).allPrice;
    return Container(
      width: ScreenUtil().setWidth(430),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: Text(
                  '合计：',
                  style: TextStyle(fontSize: ScreenUtil().setSp(36)),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(280),
                child: Text(
                  '￥${allPrice}',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(36), color: Colors.red),
                ),
              )
            ],
          ),
          Container(
              width: ScreenUtil().setWidth(430),
              alignment: Alignment.centerRight,
              child: Text(
                '满10元免派送费,预购免派送费',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28), color: Colors.black38),
              )),
        ],
      ),
    );
  }

  Widget _goButton(context) {
    var allGoodCount = Provide.value<ShopCarProvide>(context).allGoodCount;
    return Container(
      width: ScreenUtil().setWidth(160),
      padding: EdgeInsets.only(left: 10.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Text(
            '结算(${allGoodCount})',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
