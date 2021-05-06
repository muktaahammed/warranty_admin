class ExpiredProductModel {
  String orderId;
  String productBrand;
  String productModel;
  String warrentyLength;
  String type;
  String expiryDate;
  //
  String partsWarrenty;
  String bname;
  String bemail;
  String bphone;

  ExpiredProductModel({
    this.orderId,
    this.productBrand,
    this.productModel,
    this.warrentyLength,
    this.type,
    this.expiryDate,
//
    this.partsWarrenty,
    this.bname,
    this.bemail,
    this.bphone,
  });

  ExpiredProductModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    productBrand = json['product_brand'];
    productModel = json['product_model'];
    warrentyLength = json['warrenty_length'];
    type = json['type'];
    expiryDate = json['expiry_date'];
//
    partsWarrenty = json['parts_warrenty'];
    bname = json['bname'];
    bphone = json['bphone'];
    bemail = json['bemail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['product_brand'] = this.productBrand;
    data['product_model'] = this.productModel;
    data['warrenty_length'] = this.warrentyLength;
    data['type'] = this.type;
    data['expiry_date'] = this.expiryDate;
//
    data['parts_warrenty'] = this.partsWarrenty;
    data['bname'] = this.bname;
    data['bemail'] = this.bemail;
    data['bphone'] = this.bphone;

    return data;
  }
}
