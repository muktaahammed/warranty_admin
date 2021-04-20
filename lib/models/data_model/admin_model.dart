class AdminDataModel {
  String message;
  String id;
  String name;
  String email;
  String phone;
  String staffID;
  AdminDataModel({
    this.message,
    this.id,
    this.name,
    this.email,
    this.phone,
    this.staffID,
  });

  AdminDataModel.fromJson(Map<String, dynamic> json)
      : message = json['message'],
        id = json['id'],
        name = json['name'],
        email = json['email'],
        phone = json['phone'],
        staffID = json['staffID'];
  Map<String, dynamic> toJson() => {
        'message': message,
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'staffID': staffID,
      };
}
