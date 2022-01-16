import 'package:bingochart_app/model/bingocard_items.dart';

const String tableBingocards = 'bingocards';

class BingocardFields {
  static final List<String> values = [id, name];

  static const String id = '_id';
  static const String name = 'name';
}

class Bingocard {
  final int? id;
  final String name;

  Bingocard({
    this.id,
    required this.name,
  });

  static Bingocard fromJson(Map<String, Object?> json) => Bingocard(
        id: json[BingocardFields.id] as int?,
        name: json[BingocardFields.name] as String,
      );

  Map<String, Object?> toJson() => {
        BingocardFields.id: id,
        BingocardFields.name: name,
      };

  Bingocard copy({int? id, String? name}) =>
      Bingocard(id: id ?? this.id, name: name ?? this.name);
}

class PlayBingocard{

}
