class CourseModel {
  int? courseId;
  String? courseName;
  String? description;
  String? price;
  String? isProgressLimited;
  String? createdAt;

  CourseModel(
      {this.courseId,
      this.courseName,
      this.description,
      this.price,
      this.isProgressLimited,
      this.createdAt});

  CourseModel.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    courseName = json['course_name'];
    description = json['description'];
    price = json['price'];
    isProgressLimited = json['is_progress_limited'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['course_id'] = courseId;
    data['course_name'] = courseName;
    data['description'] = description;
    data['price'] = price;
    data['is_progress_limited'] = isProgressLimited;
    data['createdAt'] = createdAt;
    return data;
  }
}
