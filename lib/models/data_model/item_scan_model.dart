class ItemScanModel {
  String brandName='';
  String modelNumber='';
  String modelName='';
  String serialNumber='';
  String warrentyLength='';
  String partsName='';
  String partsWarrenty='';
  String part2Name='';
  String parts2Length='';
  String productType='';

  ItemScanModel(
      {this.brandName,
      this.modelNumber,
      this.modelName,
      this.serialNumber,
      this.warrentyLength,
      this.partsName,
      this.partsWarrenty,
      this.part2Name,
      this.parts2Length,
      this.productType});

  ItemScanModel.fromJson(Map<String, dynamic> json) {
    brandName = json['brand_name'];
    modelNumber = json['model_number'];
    modelName = json['model_name'];
    serialNumber = json['serial_number'];
    warrentyLength = json['warrenty_length'];
    partsName = json['parts_name'];
    partsWarrenty = json['parts_warrenty'];
    part2Name = json['part2_name'];
    parts2Length = json['parts2_length'];
    productType = json['product_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_name'] = this.brandName;
    data['model_number'] = this.modelNumber;
    data['model_name'] = this.modelName;
    data['serial_number'] = this.serialNumber;
    data['warrenty_length'] = this.warrentyLength;
    data['parts_name'] = this.partsName;
    data['parts_warrenty'] = this.partsWarrenty;
    data['part2_name'] = this.part2Name;
    data['parts2_length'] = this.parts2Length;
    data['product_type'] = this.productType;
    return data;
  }
}
