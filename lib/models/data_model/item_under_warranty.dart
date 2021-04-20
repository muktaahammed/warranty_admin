class UnderWarrentyList {
  String orderId;
  String productBrand;
  String productModel;
  int warrentyLength;
  String type;
  String expiryDate;
  String partsName;
  String partsWarrenty;
  String part2Name;
  String parts2Length;
  String bphone;
  String bemail;
  String bname;

  UnderWarrentyList(
      {this.orderId,
      this.productBrand,
      this.productModel,
      this.warrentyLength,
      this.type,
      this.expiryDate,
      this.partsName,
      this.partsWarrenty,
      this.part2Name,
      this.parts2Length,
      this.bphone,
      this.bemail,
      this.bname});

  UnderWarrentyList.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    productBrand = json['product_brand'];
    productModel = json['product_model'];
    warrentyLength = json['warrenty_length'];
    type = json['type'];
    expiryDate = json['expiry_date'];
    partsName = json['parts_name'];
    partsWarrenty = json['parts_warrenty'];
    part2Name = json['part2_name'];
    parts2Length = json['parts2_length'];
    bphone = json['bphone'];
    bemail = json['bemail'];
    bname = json['bname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['product_brand'] = this.productBrand;
    data['product_model'] = this.productModel;
    data['warrenty_length'] = this.warrentyLength;
    data['type'] = this.type;
    data['expiry_date'] = this.expiryDate;
    data['parts_name'] = this.partsName;
    data['parts_warrenty'] = this.partsWarrenty;
    data['part2_name'] = this.part2Name;
    data['parts2_length'] = this.parts2Length;
    data['bphone'] = this.bphone;
    data['bemail'] = this.bemail;
    data['bname'] = this.bname;
    return data;
  }
}