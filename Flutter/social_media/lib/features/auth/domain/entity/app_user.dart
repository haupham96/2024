class AppUser {
  String uid;
  String email;
  String name;

  AppUser({required this.uid, required this.email, required this.name});

  // convert app_user to json
  Map<String, dynamic> toJson() {
    return {'uid': uid, 'email': email, 'name': name};
  }

  // convert json to app_user
  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(uid: json['uid'], email: json['email'], name: json['name']);
  }
}
