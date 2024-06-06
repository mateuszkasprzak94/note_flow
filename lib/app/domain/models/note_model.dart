class NoteModel {
  const NoteModel({
    this.id,
    required this.title,
    required this.description,
    this.pinned = 0,
    this.color = 'FFFFFF',
    this.inspirationTag = false,
    this.personalTag = false,
    this.workTag = false,
  });

  final int? id;
  final String title;
  final String description;
  final int pinned;
  final String color;
  final bool inspirationTag;
  final bool personalTag;
  final bool workTag;

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        pinned: json['pinned'],
        color: json['color'],
        inspirationTag: json['inspirationTag'] == 1,
        personalTag: json['personalTag'] == 1,
        workTag: json['workTag'] == 1,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'pinned': pinned,
        'color': color,
        'inspirationTag': inspirationTag ? 1 : 0,
        'personalTag': personalTag ? 1 : 0,
        'workTag': workTag ? 1 : 0,
      };
}
