class Todo {
  final int id;
  final int userId;
  final String title;
  final bool completed;

  const Todo(
    this.id,
    this.userId,
    this.title,
    this.completed,
  );

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        json['id'],
        json['userId'],
        json['title'],
        json['completed'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'title': title,
        'completed': completed,
      };

  @override
  String toString() =>
      'Todo(id: $id, userId: $userId, title: $title, completed: $completed)';
}
