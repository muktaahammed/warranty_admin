class ViewEquipments {
  
  String brandName;
  String serialNumber;
  String modelNumber;
  String modelName;
  String productType;
  int warrantyPeriod;
  String partsName;
  String partsWarranty;
  String parts2Name;
  String parts2Length;
  ViewEquipments(
    this.brandName,
    this.serialNumber,
    this.modelNumber,
    this.modelName,
    this.productType,
    this.warrantyPeriod,
    this.partsName,
    this.partsWarranty,
    this.parts2Name,
    this.parts2Length,
  );

  ViewEquipments.fromJson(Map<String, dynamic> json) {
    brandName = json['brand_name'];
    serialNumber = json['serial_number'];
    modelNumber = json['model_number'];
    modelName = json['model_name'];
    productType = json['product_type'];
    warrantyPeriod = json['warrenty_length'];
    partsName = json['parts_name'];
    partsWarranty = json['parts_warrenty'];
    parts2Name = json['part2_name'];
    parts2Length = json['parts2_length'];
  }
}
