import 'package:hive/hive.dart';

part 'dua_model.g.dart';

@HiveType(typeId: 0)
class DuaModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String content;

  @HiveField(2)
  String source;

  @HiveField(3)
  bool isDefault;

  @HiveField(4)
  bool isAzkar;

  DuaModel({
    required this.title,
    required this.content,
    required this.source,
    required this.isDefault,
    required this.isAzkar,
  });
}