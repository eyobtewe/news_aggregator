class Feedbacks {
  String email;
  String name;
  String phone;
  String status;
  String fileUrl;

  Feedbacks({
    this.email,
    this.name,
    this.phone,
    this.status,
    this.fileUrl,
  });

  Map<String, String> toJson() {
    return {
      "email": email ?? 'unknown',
      "name": name ?? 'unknown',
      "phone": phone ?? 'unknown',
      "status": status ?? 'unknown',
      "fileUrl": fileUrl,
    };
  }

  Feedbacks.fromjson(Map<String, dynamic> parsedJson) {
    fileUrl = parsedJson["fileUrl"].toString();
    email = parsedJson["email"].toString();
    phone = parsedJson["phone"].toString();
    status = parsedJson["status"].toString();
    name = parsedJson["name"].toString();
  }
}
