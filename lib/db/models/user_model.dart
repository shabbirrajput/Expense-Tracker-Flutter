class UserModel {
  int? id;
  /*String? token;*/
  String? name;
  String? email;
  String? password;

  UserModel({this.id, /*this.token,*/ this.name, this.email, this.password});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    /*token = json['token'];*/
    name = json['name'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    /*data['token'] = token;*/
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
