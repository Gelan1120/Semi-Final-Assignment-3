const String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [ id, title, description, time ];

  static const String id = '_id';
  static const String title = 'title';
  static const String description = 'description';
  static const String time = 'time';
}

class NotesModel {
  final int? id;
  final String title;
  final String description;
  final DateTime createdTime;

  const NotesModel({
    this.id,
    required this.title,
    required this.description,
    required this.createdTime,
  });

  NotesModel copy({
    int? id,
    String? title,
    String? description,
    DateTime? createdTime, }) => NotesModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );

  static NotesModel fromJson(Map<String, Object?> json) => NotesModel(
    id: json[NoteFields.id] as int?,
    title: json[NoteFields.title] as String,
    description: json[NoteFields.description] as String,
    createdTime: DateTime.parse(json[NoteFields.time] as String),
  );

  Map<String, Object?> toJson() => {
    NoteFields.id: id,
    NoteFields.title: title,
    NoteFields.description: description,
    NoteFields.time: createdTime.toIso8601String(),
  };
}
