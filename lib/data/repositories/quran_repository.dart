import 'package:hive_flutter/hive_flutter.dart';
import '../models/quran_progress_model.dart';

class QuranRepository {
  static const String _boxName = 'quran_progress';
  static const String _key     = 'progress';

  Future<Box<QuranProgressModel>> get _box async =>
      Hive.isBoxOpen(_boxName)
          ? Hive.box(_boxName)
          : await Hive.openBox<QuranProgressModel>(_boxName);

  Future<QuranProgressModel> getProgress() async {
    final box = await _box;
    if (box.containsKey(_key)) return box.get(_key)!;
    final progress = QuranProgressModel();
    await box.put(_key, progress);
    return progress;
  }

  Future<void> saveProgress(QuranProgressModel progress) async {
    await progress.save();
  }

  Future<void> updateJuz(int currentJuz) async {
    final progress    = await getProgress();
    progress.currentJuz = currentJuz;
    await progress.save();
  }

  Future<void> updateKhatmCount(int count) async {
    final progress       = await getProgress();
    progress.khatmCount  = count;
    await progress.save();
  }
}