class ViewEquipments {
  String brandName;
  String serialNumber;
  String modelNumber;
  String modelName;
  String productType;
  String warrantyPeriod;
  String partsWarranty;

  ViewEquipments({ 
    this.brandName,
    this.serialNumber,
    this.modelNumber,
    this.modelName,
    this.productType,
    this.warrantyPeriod,
    this.partsWarranty,
  });

  ViewEquipments.fromJson(Map<String, dynamic> json) {
    brandName = json['brand_name'];
    serialNumber = json['serial_number'];
    modelNumber = json['model_number'];
    modelName = json['model_name'];
    productType = json['product_type'];
    warrantyPeriod = json['warrenty_length'];
    partsWarranty = json['parts_warrenty'];
  }
}
