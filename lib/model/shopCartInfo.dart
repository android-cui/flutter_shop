
class ShopCartInfo {
  String goodsId;
  String goodsName;
  num count;
  num price;
  num oldPrice;
  String images;
  bool isCheck;


  ShopCartInfo(
      {this.goodsId, this.goodsName, this.count, this.price, this.images,this.oldPrice,this.isCheck});

  ShopCartInfo.fromJson(Map<String, dynamic> json) {
    goodsId = json['goodsId'];
    goodsName = json['goodsName'];
    count = json['count'];
    price = json['price'];
    images = json['images'];
    isCheck = json['isCheck'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodsId'] = this.goodsId;
    data['goodsName'] = this.goodsName;
    data['count'] = this.count;
    data['price'] = this.price;
    data['images'] = this.images;
    data['oldPrice'] = this.oldPrice;
    data['isCheck'] = this.isCheck;
    return data;
  }
}