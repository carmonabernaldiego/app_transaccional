class TodoModel {
  final int? id;
  final String title;
  final String? description;
  final String? dueDate; // ISO String
  final bool completed;

  TodoModel({
    this.id,
    required this.title,
    this.description,
    this.dueDate,
    this.completed = false,
  });

  TodoModel copyWith({
    int? id,
    String? title,
    String? description,
    String? dueDate,
    bool? completed,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      completed: completed ?? this.completed,
    );
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        id: json['id'] as int?,
        title: json['title'] as String,
        description: json['description'] as String?,
        dueDate: json['due_date'] as String?,
        completed: json['completed'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'due_date': dueDate,
        'completed': completed,
      }..removeWhere((k, v) => v == null);
}
