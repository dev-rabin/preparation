class ModuleModel {
  int? moduleId;
  int? courseId;
  String? moduleName;
  int? number;
  String? createdAt;
  String? courseName;
  String? description;
  String? price;
  String? isProgressLimited;

  ModuleModel(
      {this.moduleId,
      this.courseId,
      this.moduleName,
      this.number,
      this.createdAt,
      this.courseName,
      this.description,
      this.price,
      this.isProgressLimited});

  ModuleModel.fromJson(Map<String, dynamic> json) {
    moduleId = json['module_id'];
    courseId = json['courseId'];
    moduleName = json['module_name'];
    number = json['number'];
    createdAt = json['createdAt'];
    courseId = json['course_id'];
    courseName = json['course_name'];
    description = json['description'];
    price = json['price'];
    isProgressLimited = json['is_progress_limited'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['module_id'] = moduleId;
    data['courseId'] = courseId;
    data['module_name'] = moduleName;
    data['number'] = number;
    data['createdAt'] = createdAt;
    data['course_id'] = courseId;
    data['course_name'] = courseName;
    data['description'] = description;
    data['price'] = price;
    data['is_progress_limited'] = isProgressLimited;
    return data;
  }
}
