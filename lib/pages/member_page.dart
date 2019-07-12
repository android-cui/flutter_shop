import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provide/provide.dart';
import '../provide/counter.dart';

class MemberPage extends StatefulWidget {
  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('会员中心'),
        ),
        body: ListView(
          children: <Widget>[
            _topHeader(),
            _orderTitle(),
            _orderType(),
            _actionList(),
          ],
        ));
  }

  /*
 *  我的头像  
 */
  Widget _topHeader() {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(20),
      color: Colors.pinkAccent,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            child: ClipOval(
              child: Image.network(
                  'https://profile.csdnimg.cn/2/8/3/1_u010960092'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              '小崔同志',
              style: TextStyle(
                  color: Colors.black54, fontSize: ScreenUtil().setSp(36)),
            ),
          )
        ],
      ),
    );
  }

/*
 * 我的订单标题
 */
  Widget _orderTitle() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
      ),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text('我的订单'),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  /*
   *  订单类型 
   */

  Widget _orderType(){
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(150),
      padding: EdgeInsets.only(top: 20),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(Icons.party_mode,size: 30,),
                Text('待付款')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(Icons.query_builder,size: 30,),
                Text('待发货')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(Icons.directions_car,size: 30,),
                Text('待收货')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(Icons.content_paste,size: 30,),
                Text('已收货')
              ],
            ),
          ),
        ],
      ),
    );
  }

/*
 *  通用LitTitle 
 */
  Widget myListTitle(title,icon){

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1,color: Colors.black12)
        )
      ),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: Icon(Icons.arrow_right),
        onTap: (){
          
        },
      ),
    );
  }

Widget _actionList(){
  return Container(
    margin: EdgeInsets.only(top: 20),
    child: 
    Column(
      children: <Widget>[
          myListTitle('领取优惠券',Icons.assignment_ind),
          myListTitle('已领取优惠券',Icons.ac_unit),
          myListTitle('地址管理',Icons.add_alarm),
          myListTitle('客服电话',Icons.phone_forwarded),
      ],
    ),
  );
}

}
