class OnWarrantyProcess {
  String status;
  String code;
  int total;
  List<OnWarrantyList> onWarrantyList;

  OnWarrantyProcess({
    this.status,
    this.code,
    this.total,
    this.onWarrantyList,
  });

  factory OnWarrantyProcess.fromJson(Map<String, dynamic> json) {
    var list = json['onWarrantyList'];
    List<OnWarrantyList> onWarranty = list
        .map((onWarrantyList) => OnWarrantyList.fromJson(onWarrantyList))
        .toList();

    return OnWarrantyProcess(
      status: json['status'],
      code: json['code'],
      total: json['total'],
      onWarrantyList: onWarranty,
    );
  }
}

class OnWarrantyList {
  String orderId;
  String stage2;
  String stage3;
  String stage4;
  String productBrand;
  String productModel;
  int warrentyLength;
  String type;
  String expiryDate;
  String partsWarrenty;
  String bphone;
  String bemail;
  String bname;

  OnWarrantyList(
      {this.orderId,
      this.stage2,
      this.stage3,
      this.stage4,
      this.productBrand,
      this.productModel,
      this.warrentyLength,
      this.type,
      this.expiryDate,
      this.partsWarrenty,
      this.bphone,
      this.bemail,
      this.bname});

  factory OnWarrantyList.fromJson(Map<String, dynamic> json) {
    return OnWarrantyList(
      orderId: json['order_id'],
      stage2: json['stage2'],
      stage3: json['stage3'],
      stage4: json['stage4'],
      productBrand: json['product_brand'],
      productModel: json['product_model'],
      warrentyLength: json['warrenty_length'],
      type: json['type'],
      expiryDate: json['expiry_date'],
      partsWarrenty: json['parts_warrenty'],
      bphone: json['bphone'],
      bemail: json['bemail'],
      bname: json['bname'],
    );
  }
}
