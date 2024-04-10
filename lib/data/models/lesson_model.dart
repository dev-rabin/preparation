class LessonModel {
  int? lessonId;
  int? moduleId;
  String? name;
  int? number;
  String? videoUrl;
  String? lessonDetails;
  String? courseOrder;
  String? createdAt;

  LessonModel(
      {this.lessonId,
      this.moduleId,
      this.name,
      this.number,
      this.videoUrl,
      this.lessonDetails,
      this.courseOrder,
      this.createdAt});

  LessonModel.fromJson(Map<String, dynamic> json) {
    lessonId = json['lesson_id'];
    moduleId = json['module_id'];
    name = json['name'];
    number = json['number'];
    videoUrl = json['video_url'];
    lessonDetails = json['lesson_details'];
    courseOrder = json['course_order'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lesson_id'] = lessonId;
    data['module_id'] = moduleId;
    data['name'] = name;
    data['number'] = number;
    data['video_url'] = videoUrl;
    data['lesson_details'] = lessonDetails;
    data['course_order'] = courseOrder;
    data['createdAt'] = createdAt;
    return data;
  }
}
