// ignore_for_file: camel_case_types, unnecessary_this, unnecessary_new, prefer_collection_literals

class course_model {
  int? courseId;
  String? name;
  String? description;
  String? price;
  String? isProgressLimited;
  String? createdAt;

  course_model(
      {this.courseId,
      this.name,
      this.description,
      this.price,
      this.isProgressLimited,
      this.createdAt});

  course_model.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    isProgressLimited = json['is_progress_limited'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_id'] = this.courseId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['is_progress_limited'] = this.isProgressLimited;
    data['createdAt'] = this.createdAt;
    return data;
  }
}