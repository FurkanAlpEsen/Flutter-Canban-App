enum Status { todo, inprogress, done }

class Task {
  String title;
  String description;
  Status taskStatus;
  bool isFavorite;

  Task({
    required this.title,
    required this.description,
    required this.taskStatus,
    required this.isFavorite,
  });

  Task copyWith({
    String? title,
    String? description,
    Status? taskStatus,
    bool? isFavorite,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      taskStatus: taskStatus ?? this.taskStatus,
      isFavorite: isFavorite ?? this.isFavorite
    );
  }

  @override
  String toString() =>
      'Task(title: $title, description: $description, taskStatus: $taskStatus, favorite: $isFavorite)';

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'taskStatus': taskStatus,
      'isFavorite': isFavorite
    };
  }
}

//? If HIVE database required use these Adapters

// class TaskAdapter extends TypeAdapter<Task> {
//   @override
//   final typeId = 0;

//   @override
//   Task read(BinaryReader reader) {
//     //Task()..title = reader.read();
//     // Task()..description = reader.read();
//     // Task()..taskStatus = reader.read();

//     return Task(title: reader.read(), description: reader.read(), taskStatus: Status.values[reader.read() as int]);
//   }

//   @override
//   void write(BinaryWriter writer, Task obj) {
//     writer.write(obj.title);
//     writer.write(obj.description);
//     writer.write(obj.taskStatus.index);
//   }
// }
