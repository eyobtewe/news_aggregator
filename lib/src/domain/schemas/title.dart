class Title {
  // String raw;
  String rendered;

  Title({this.rendered});

  Title.fromJson(Map<String, dynamic> json) {
    // raw = json['raw'];
    rendered = json['rendered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // if (this.raw != null) data['raw'] = this.raw;
    if (rendered != null) data['rendered'] = rendered;
    return data;
  }
}
