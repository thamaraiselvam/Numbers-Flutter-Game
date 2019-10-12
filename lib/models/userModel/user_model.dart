class User {
  User._internal();

  static final User _singleton = User._internal();

  factory User() => _singleton;
  String name;
  String email;
  String phone;
  String uid;
  toJson() {
    return {
      "name": this.name,
      "phone": this.phone,
      "email": this.email,
      "userID": this.uid,
    };
  }

  fromJson(Map<String, dynamic> json) {
    this.email = json["email"];
    this.name = json["name"];
    this.phone = json["phone"];
    this.uid = json["userID"];
  }

  setDetails(String email, String name, String phone, String uid) {
    this.email = email;
    this.phone = phone;
    this.name = name;
    this.uid = uid;
  }
}
