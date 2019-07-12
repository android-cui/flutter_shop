import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/details_info.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var goodInfo =
    //     Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo;
    return Provide<DetailsInfoProvide>(
      builder: (context, child, val) {
        if (val.goodsInfo != null) {
          return Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  _goodImage(val.goodsInfo.data.goodInfo.image1),
                  _goodName(val.goodsInfo.data.goodInfo.goodsName),
                  _goodNumber(val.goodsInfo.data.goodInfo.goodsSerialNumber),
                  _goodPrice(val.goodsInfo.data.goodInfo.presentPrice, val.goodsInfo.data.goodInfo.oriPrice),
                  _goodDeclare(),
                ],
              ),
          );
        } else {
          return Text('正在加载中...');
        }
      },
    );
  }

//商品图片
  Widget _goodImage(url) {
    return Image.network(
      url,
      width: ScreenUtil().setWidth(740), //高度总共750
    );
  }

//商品名称
  Widget _goodName(name) {
    return Container(
      width: ScreenUtil().setWidth(740),
      margin: EdgeInsets.only(left: 15.0),
      child: Text(name, style: TextStyle(fontSize: ScreenUtil().setSp(30))),
    );
  }

//商品编号
  Widget _goodNumber(number) {
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 15.0),
      margin: EdgeInsets.only(top: 8.0),
      child: Text(
        '编号:${number}',
        style: TextStyle(color: Colors.black12),
      ),
    );
  }

//商品编号
  Widget _goodPrice(presentPrice, oriPrice) {
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 15.0),
      margin: EdgeInsets.only(top: 8.0),
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(
              '￥${presentPrice}',
              style: TextStyle(
                  color: Colors.red, fontSize: ScreenUtil().setSp(30)),
            ),
          ),
          Container(
              alignment: Alignment.center,
              child: Text(
                '      市场价:  ',
                style: TextStyle(fontSize: ScreenUtil().setSp(24)),
              )),
          Container(
            alignment: Alignment.center,
            child: Text('￥${oriPrice}',
                style: TextStyle(
                  color: Colors.black12,
                  decoration: TextDecoration.lineThrough,
                )),
          ),
        ],
      ),
    );
  }

// 说明
  Widget _goodDeclare() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
      decoration: BoxDecoration(
          border: BorderDirectional(
              top: BorderSide(width: 12.0, color: Colors.black12),
              bottom: BorderSide(width: 12.0, color: Colors.black12))),
      child: Text(
        "说明:>急速送达>正品保证",
        style: TextStyle(fontSize: ScreenUtil().setSp(28), color: Colors.red),
      ),
    );
  }
}
