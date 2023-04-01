class Tag {
  int id;
  int count;
  String link;
  String name;

  Tag({
    this.id,
    this.count,
    this.link,
    this.name,
  });

  Tag.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    count = json['count'];
    link = json['link'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['count'] = count;
    data['link'] = link;
    data['name'] = name;
    return data;
  }
}
