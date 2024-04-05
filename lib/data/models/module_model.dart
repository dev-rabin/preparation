class ModuleModel {
  int? moduleId;
  int? courseId;
  String? name;
  int? number;
  String? createdAt;
  int? courseId;
  String? description;
  String? price;
  String? isProgressLimited;

  ModuleModel(
      {this.moduleId,
      this.courseId,
      this.name,
      this.number,
      this.createdAt,
      this.courseId,
      this.description,
      this.price,
      this.isProgressLimited});

  ModuleModel.fromJson(Map<String, dynamic> json) {
    moduleId = json['module_id'];
    courseId = json['courseId'];
    name = json['name'];
    number = json['number'];
    createdAt = json['createdAt'];
    courseId = json['course_id'];
    description = json['description'];
    price = json['price'];
    isProgressLimited = json['is_progress_limited'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['module_id'] = moduleId;
    data['courseId'] = courseId;
    data['name'] = name;
    data['number'] = number;
    data['createdAt'] = createdAt;
    data['course_id'] = courseId;
    data['description'] = description;
    data['price'] = price;
    data['is_progress_limited'] = isProgressLimited;
    return data;
  }
}
