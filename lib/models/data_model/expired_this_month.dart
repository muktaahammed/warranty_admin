class ExpireThisMonthList {
  String status;
  String code;
  int expireThisMonth;

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

  ExpireThisMonthList(
      this.status,
      this.code,
      this.expireThisMonth,
      this.orderId,
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
      this.bname);

  ExpireThisMonthList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    expireThisMonth = json['expireThisMonth'];

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
}
