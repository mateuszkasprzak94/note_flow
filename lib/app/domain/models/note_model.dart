class NoteModel {
  const NoteModel({
    this.id,
    required this.title,
    required this.description,
    this.pinned = 0,
  });

  final int? id;
  final String title;
  final String description;
  final int pinned;

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        pinned: json['pinned'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'pinned': pinned,
      };
}
