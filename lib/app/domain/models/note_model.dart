class NoteModel {
  const NoteModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  final int? id;
  final String title;
  final String description;
  final String date;

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        date: json['date'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'date': date,
      };
}
