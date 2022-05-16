
class Annotation {
  Annotation({
    required this.title,
    required this.date,
    required this.check,
    required this.description,
  });

  String title;
  String date;
  bool check;
  String description;

  factory Annotation.fromJson(Map<String, dynamic> json) => Annotation(
        title: json["title"],
        date: json["date"],
        check: json["check"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "date": date,
        "check": check,
        "description": description,
      };
}
