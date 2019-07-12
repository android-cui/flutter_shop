import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../utils/date_util.dart';

class DetailsContent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(
      builder: (context,child,val){
        var isLeft = Provide.value<DetailsInfoProvide>(context).isLeft;
        if(isLeft){
 if (null !=val && null != val.goodsInfo && null != val.goodsInfo.data.goodInfo && null != val.goodsInfo.data.goodInfo.goodsDetail) {
          return Container(
          child: Html(
            data: val.goodsInfo.data.goodInfo.goodsDetail,
          ),
        );
        } else {
          return Container(
              width: ScreenUtil().setWidth(750),
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child:Text('暂时没有数据')
            );
        }
        }else{
            if (val.goodsInfo != null) {
          return Container(
            width: ScreenUtil().setWidth(750),
            child: Column(
              children: <Widget>[
                _commentList(context, val.goodsInfo.data),
                _commentImage(context, val.goodsInfo.data),
              ],
            ),
          );
        } else {
          return Container(
            width: ScreenUtil().setWidth(750),
            child: Center(
              child: Text(''),
            ),
          );
        }
        }
       
      },
    );
  }

   Widget _commentList(context, data) {
    if (data.goodComments != null && data.goodComments.length > 0) {
      return Container(
        child:
            // Expanded(
            // child:
            ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: data.goodComments.length,
          itemBuilder: (BuildContext context, int position) {
            return _commentItem(data.goodComments[position]);
          },
        ),
        // )
      );
    } else {
      return Container(
          margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Center(
            child: Text(
              '暂时还没有评论喔！',
              style: TextStyle(
                  color: Colors.black12, fontSize: ScreenUtil().setSp(30)),
            ),
          ));
    }
  }

  Widget _commentItem(item) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: ScreenUtil().setWidth(750),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10.0,left: 10.0),
              alignment: Alignment.centerLeft,
              child: Text(
                item.userName,
                style: TextStyle(
                  color: Colors.black26,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0,left: 10.0),
              alignment: Alignment.centerLeft,
              child: Text(
                item.comments,
                style: TextStyle(fontSize: ScreenUtil().setSp(26)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0,left: 10.0),
              alignment: Alignment.centerLeft,
              child: Text(DateUtil.getDateStrByMs(item.discussTime,
                  format: DateFormat.NORMAL),style: TextStyle(color: Colors.black45),),
            ),
          ],
        ),
      ),
    );
  }

  Widget _commentImage(context, data) {
    if (data != null &&
        data.advertesPicture != null &&
        data.advertesPicture.pICTUREADDRESS != null) {
      return Image.network(
        data.advertesPicture.pICTUREADDRESS,
        width: ScreenUtil().setWidth(750),
      );
    } else {
      return Center(
        child: Text(''),
      );
    }
  }
}