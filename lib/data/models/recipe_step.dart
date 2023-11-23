class RecipeStep {
  String? id;
  String name;
  String details;

  RecipeStep({this.id, required this.name, required this.details});

  factory RecipeStep.fromJson(Map<String, dynamic> json) {
    return RecipeStep(
      id: json['id'],
      name: json['name'],
      details: json['details'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'details': details,
    };
  }
}