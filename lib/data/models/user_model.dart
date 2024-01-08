class UserModel {
  String? email;
  String? firstName;
  String? middleName;
  String? lastName;
  String? mobile;
  String? photo;

  UserModel(
      {this.email, this.firstName, this.middleName, this.lastName, this.mobile, this.photo});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['firstName'];
    middleName = json['middleName'];
    lastName = json['lastName'];
    mobile = json['mobile'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['firstName'] = firstName;
    data['middleName'] = middleName;
    data['lastName'] = lastName;
    data['mobile'] = mobile;
    data['photo'] = photo;
    return data;
  }
}
