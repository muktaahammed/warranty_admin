class AdminDataModel {
  String name;
  String email;
  String phone;
  String staffID;
  AdminDataModel({
    this.name,
    this.email,
    this.phone,
    this.staffID,
  });

  AdminDataModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        phone = json['phone'],
        staffID = json['staffID'];
  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'staffID': staffID,
      };
}
