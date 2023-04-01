class Category {
  int id;
  int count;
  String name;
  int parent;

  Category({
    this.id,
    this.count,
    this.name,
    this.parent,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    count = json['count'];
    name = json['name'];
    parent = json['parent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['count'] = count;
    data['name'] = name;
    data['parent'] = parent;
    return data;
  }
}
