class NoteModel {
  const NoteModel({
    this.id,
    required this.title,
    required this.description,
    this.pinned = 0,
    this.color = 'FFFFFF',
  });

  final int? id;
  final String title;
  final String description;
  final int pinned;
  final String color;

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        pinned: json['pinned'],
        color: json['color'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'pinned': pinned,
        'color': color,
      };
}
