import 'package:hive/hive.dart';

part 'quran_progress_model.g.dart';

@HiveType(typeId: 2)
class QuranProgressModel extends HiveObject {
  @HiveField(0)
  int khatmCount;

  @HiveField(1)
  int currentJuz;

  QuranProgressModel({
    this.khatmCount = 1,
    this.currentJuz = 0,
  });
}