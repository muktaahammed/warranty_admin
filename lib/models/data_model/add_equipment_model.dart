class AddEquipmentMode {
  //String status;
 // String code;
  //int total;
  //int id;
  String brnadName;
  String serialNumber;
  String modelNumber;
  String modelName;
  String productType;
  String warrantyPeriod;
  String partsName;
  String partsWarranty;
  String parts2Name;
  String parts2Length;

  AddEquipmentMode(
    //this.status,
   // this.code,
    //this.total,
    //this.id,
    this.brnadName,
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

  AddEquipmentMode.fromJson(Map<String, dynamic> json)
      : //status = json['status'],
       // code = json['code'],
        //total = json['total'],
        //id = json['id'],
        brnadName = json['brand_name'],
        serialNumber = json['serial_number'],
        modelNumber = json['model_number'],
        modelName = json['model_name'],
        productType = json['product_type'],
        warrantyPeriod = json['warrenty_length'],
        partsName = json['parts_name'],
        partsWarranty = json['parts_warrenty'],
        parts2Name = json['part2_name'],
        parts2Length = json['parts2_length'];

  Map<String, dynamic> toJson() => {
       // 'status': status,
       // 'code': code,
        //'total': total,
        //'id': id,
        'brand_name' : brnadName,
        'serial_number' : serialNumber,
        'model_number' : modelNumber,
        'model_name' : modelName,
        'product_type' : productType,
        'warrenty_length' : warrantyPeriod,
        'parts_name' : partsName,
        'parts_warrenty' : partsWarranty,
        'part2_name' : parts2Name,
        'parts2_length' : parts2Length,
      };
}
