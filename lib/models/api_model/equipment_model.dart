class EquipmentModel {
  String brandName;
  String modelNumber;
  String modelName;
  String serialNumber;
  String productType;
  String warrentyLength;
  SubWarrenty subWarrenty;

  EquipmentModel(
      {this.brandName,
      this.modelNumber,
      this.modelName,
      this.serialNumber,
      this.productType,
      this.warrentyLength,
      this.subWarrenty});

  EquipmentModel.fromJson(Map<String, dynamic> json) {
    brandName = json['brand_name'];
    modelNumber = json['model_number'];
    modelName = json['model_name'];
    serialNumber = json['serial_number'];
    productType = json['product_type'];
    warrentyLength = json['warrenty_length'];
    subWarrenty = json['sub_warrenty'] != null
        ? new SubWarrenty.fromJson(json['sub_warrenty'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_name'] = this.brandName;
    data['model_number'] = this.modelNumber;
    data['model_name'] = this.modelName;
    data['serial_number'] = this.serialNumber;
    data['product_type'] = this.productType;
    data['warrenty_length'] = this.warrentyLength;
    if (this.subWarrenty != null) {
      data['sub_warrenty'] = this.subWarrenty.toJson();
    }
    return data;
  }
}

class SubWarrenty {
  String parts;
  String name;
  String warrentyLength;

  SubWarrenty({this.parts, this.name, this.warrentyLength});

  SubWarrenty.fromJson(Map<String, dynamic> json) {
    parts = json['parts'];
    name = json['name '];
    warrentyLength = json['warrenty_length'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parts'] = this.parts;
    data['name '] = this.name;
    data['warrenty_length'] = this.warrentyLength;
    return data;
  }
}