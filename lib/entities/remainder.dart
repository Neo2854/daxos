final String tableRemainders = "Remainders";

class RemainderFields {
  static final String id = "_id";
  static final String name = "name";
  static final String description = "description";
  static final String startTs = "start_ts";
  static final String endTs = "end_ts";

  static final List<String> values = [
    id, name, description, startTs, endTs
  ];
}

class Remainder {
  final int? id;
  final String name;
  final String description;
  final DateTime? startTs;
  final DateTime? endTs;

  const Remainder({
      this.id, 
      required this.name, 
      required this.description, 
      this.startTs, 
      this.endTs
    });

  Remainder copy({
    int? id,
    String? name,
    String? description,
    DateTime? startTs,
    DateTime? endTs
  }) => Remainder(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    startTs: startTs ?? this.startTs,
    endTs: endTs ?? this.endTs
  );

  static Remainder fromJson(Map<String, Object?> json) => Remainder(
      id: json[RemainderFields.id] as int?,
      name: json[RemainderFields.name] as String,
      description: json[RemainderFields.description] as String,
      startTs: json[RemainderFields.startTs] != null
        ? DateTime.parse(json[RemainderFields.startTs] as String)
        : null,
      endTs: json[RemainderFields.endTs] != null
        ? DateTime.parse(json[RemainderFields.endTs] as String)
        : null
    );

  Map<String, Object?> toJson() => {
    RemainderFields.id: id,
    RemainderFields.name: name,
    RemainderFields.description: description,
    RemainderFields.startTs: startTs?.toIso8601String(),
    RemainderFields.endTs: endTs?.toIso8601String()
  };

  Map<String, Object?> toMap(){
    return {
      "id": id,
      "name": name,
      "description": description,
      "startTs": startTs,
      "endTs": endTs
    };
  }
}