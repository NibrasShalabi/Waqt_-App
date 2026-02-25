import 'package:hive_flutter/hive_flutter.dart';
import '../models/dua_model.dart';

class DuaRepository {
  static const String _boxName  = 'duas';
  static const int    _pageSize = 20;

  Future<Box<DuaModel>> get _box async =>
      Hive.isBoxOpen(_boxName)
          ? Hive.box(_boxName)
          : await Hive.openBox<DuaModel>(_boxName);

  // جلب بـ pagination
  Future<List<DuaModel>> getPage({
    required bool isAzkar,
    required int  page,
  }) async {
    final box  = await _box;
    final all  = box.values.where((d) => d.isAzkar == isAzkar).toList();
    final from = page * _pageSize;
    if (from >= all.length) return [];
    final to   = (from + _pageSize).clamp(0, all.length);
    return all.sublist(from, to);
  }

  // جلب العدد الكلي
  Future<int> getCount({required bool isAzkar}) async {
    final box = await _box;
    return box.values.where((d) => d.isAzkar == isAzkar).length;
  }

  Future<void> add(DuaModel dua) async {
    final box = await _box;
    await box.add(dua);
  }

  // تعديل
  Future<void> update(DuaModel dua) async {
    await dua.save();
  }

  // حذف
  Future<void> delete(DuaModel dua) async {
    await dua.delete();
  }

  // تهيئة البيانات الافتراضية (أول تشغيل فقط)
  Future<void> initDefaults() async {
    final box = await _box;
    if (box.isNotEmpty) return;

    final defaults = [
      // أدعية
      DuaModel(
          title: 'دعاء الإفطار',
          content: 'اللَّهُمَّ لَكَ صُمْتُ وَعَلَى رِزْقِكَ أَفْطَرْتُ',
          source: 'أبو داود',
          isDefault: true,
          isAzkar: false),
      DuaModel(
          title: 'دعاء للمطور',
          content: 'اللهم ارزق و زوج المطور آمينَ',
          source: 'المطور',
          isDefault: true,
          isAzkar: false),
      DuaModel(
          title: 'دعاء ليلة القدر',
          content:
              'اللَّهُمَّ إِنَّكَ عَفُوٌّ تُحِبُّ الْعَفْوَ فَاعْفُ عَنِّي',
          source: 'الترمذي',
          isDefault: true,
          isAzkar: false),
      DuaModel(
          title: 'دعاء الكرب',
          content:
              'لَا إِلَهَ إِلَّا أَنتَ سُبْحَانَكَ إِنِّي كُنتُ مِنَ الظَّالِمِينَ',
          source: 'الأنبياء:87',
          isDefault: true,
          isAzkar: false),
      // أذكار
      DuaModel(
          title: 'آية الكرسي',
          content: 'اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ',
          source: 'البقرة:255',
          isDefault: true,
          isAzkar: true),
      DuaModel(
          title: 'الاستغفار',
          content:
              'أَسْتَغْفِرُ اللَّهَ الَّذِي لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ وَأَتُوبُ إِلَيْهِ',
          source: 'أبو داود',
          isDefault: true,
          isAzkar: true),
      DuaModel(
          title: 'الحفظ',
          content:
              'بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ',
          source: 'الترمذي',
          isDefault: true,
          isAzkar: true),
    ];

    await box.addAll(defaults);
  }
}
