class OnWarrantyProcess {
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
  String stage0;
  String stage1;
  String stage2;
  String stage3;
  String stage4;
  String stage5;

  OnWarrantyProcess(
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
      this.stage0,
      this.stage1,
      this.stage2,
      this.stage3,
      this.stage4,
      this.stage5});

  OnWarrantyProcess.fromJson(Map<String, dynamic> json) {
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
    stage0 = json['stage0'];
    stage1 = json['stage1'];
    stage2 = json['stage2'];
    stage3 = json['stage3'];
    stage4 = json['stage4'];
    stage5 = json['stage5'];
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
    data['stage0'] = this.stage0;
    data['stage1'] = this.stage1;
    data['stage2'] = this.stage2;
    data['stage3'] = this.stage3;
    data['stage4'] = this.stage4;
    data['stage5'] = this.stage5;
    return data;
  }
}