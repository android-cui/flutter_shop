import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/pages/shop_cart_page/cart_count.dart';
import 'package:flutter_shop/provide/shop_car.dart';
import '../../model/shopCartInfo.dart';
import 'package:provide/provide.dart';

class CartItemPage extends StatelessWidget {
  final ShopCartInfo item;

  CartItemPage(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 1.0, color: Colors.black12))),
      child: Row(
        children: <Widget>[
          _cartCheckBotton(context,item),
          _image(),
          _goodsName(item),
          _goodPrice(context)
        ],
      ),
    );
  }

/*
 * 多选按钮
 */
  Widget _cartCheckBotton(context,item) {
    return Container(
      child: Checkbox(
        value: item.isCheck, //默认是选中
        activeColor: Colors.pink, //激活颜色
        onChanged: (bool val) {
          item.isCheck = val;
          Provide.value<ShopCarProvide>(context).changeCheckState(item);
        },
      ),
    );
  }

/*
*商品图片
*/
  Widget _image() {
    return Container(
      width: ScreenUtil().setWidth(150),
      // height: ScreenUtil().setHeight(150),
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black12),
      ),
      child: Image.network(item.images),
    );
  }

/*
*商品名称
*/
  Widget _goodsName(item) {
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(3.0),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(item.goodsName),
          CartCount(item),
        ],
      ),
    );
  }

/*
 *  商品价格 
 */
  Widget _goodPrice(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('￥${item.price}'),
          Container(
            child: InkWell(
              onTap: () {
                Provide.value<ShopCarProvide>(context).deleteGoods(item.goodsId);
              },
              child: Icon(
                Icons.delete_forever,
                color: Colors.black12,
              ),
            ),
          )
        ],
      ),
    );
  }
}
