class AppInfo {
  String sId;
  String major;
  String minor;
  String patch;

  AppInfo({this.sId, this.major, this.minor, this.patch});

  AppInfo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    major = json['major'].toString();
    minor = json['minor'].toString();
    patch = json['patch'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['major'] = major;
    data['minor'] = minor;
    data['patch'] = patch;
    return data;
  }
  @override
  String toString() {
    return '$major.$minor.$patch';
  }
}
