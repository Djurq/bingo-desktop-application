const String tableBingocardsItems = 'bingocardsitems';

class BingocardItemsFields {
  static final List<String> values = [id, name];

  static const String id = '_id';
  static const String idb = '_idb';
  static const String name = 'name';
}

class BingocardItems {
  final int? id;
  final int idb;
  String? name;

  BingocardItems({this.id, required this.idb, this.name});

  static BingocardItems fromJson(Map<String, Object?> json) => BingocardItems(
        id: json[BingocardItemsFields.id] as int?,
        idb: json[BingocardItemsFields.idb] as int,
        name: json[BingocardItemsFields.name] as String?,
      );

  Map<String, Object?> toJson() => {
        BingocardItemsFields.id: id,
        BingocardItemsFields.idb: idb,
        BingocardItemsFields.name: name,
      };

  BingocardItems copy({int? id, int? idb, String? name}) => BingocardItems(
      id: id ?? this.id, idb: idb ?? this.idb, name: name ?? this.name);
}

class PlayBingocardItems {
  late BingocardItems item;
  final bool checked = false;

  PlayBingocardItems(this.item);
}
