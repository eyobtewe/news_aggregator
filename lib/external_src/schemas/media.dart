// class Media {
//   int id;
//   Caption caption;
//   int post;
//   String sourceUrl;

//   Media({
//     this.id,
//     this.caption,
//     this.post,
//     this.sourceUrl,
//   });

//   Media.fromJson(Map<String, dynamic> json) {
//     id = json['id'];

//     caption =
//         json['caption'] != null ? new Caption.fromJson(json['caption']) : null;

//     post = json['post'];
//     sourceUrl = json['source_url'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;

//     if (this.caption != null) {
//       data['caption'] = this.caption.toJson();
//     }

//     data['post'] = this.post;
//     data['source_url'] = this.sourceUrl;

//     return data;
//   }
// }

// class Caption {
//   String raw;
//   String rendered;

//   Caption({this.raw, this.rendered});

//   Caption.fromJson(Map<String, dynamic> json) {
//     raw = json['raw'];
//     rendered = json['rendered'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['raw'] = this.raw;
//     data['rendered'] = this.rendered;
//     return data;
//   }
// }
