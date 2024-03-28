// ignore_for_file: camel_case_types, unnecessary_this, unnecessary_new, prefer_collection_literals

class CourseModel {
  final int? courseId;
  final String? name;
  final String? description;
  final String? price;
  final String? isProgressLimited;
  final String? createdAt;

  CourseModel({
    this.courseId,
    this.name,
    this.description,
    this.price,
    this.isProgressLimited,
    this.createdAt,
  });

  CourseModel.fromJson(Map<String, dynamic> json)
      : courseId = json['course_id'],
        name = json['name'],
        description = json['description'],
        price = json['price'],
        isProgressLimited = json['is_progress_limited'],
        createdAt = json['createdAt'];

  Map<String, dynamic> toJson() {
    return {
      'course_id': courseId,
      'name': name,
      'description': description,
      'price': price,
      'is_progress_limited': isProgressLimited,
      'createdAt': createdAt,
    };
  }
}
