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
          title: 'آية الكرسي ',
          content: 'اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ لَهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ مَنْ ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلَّا بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلَا يُحِيطُونَ بِشَيْءٍ مِنْ عِلْمِهِ إِلَّا بِمَا شَاءَ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ وَلَا يَئُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ',
          source: 'البقرة:255',
          isDefault: true,
          isAzkar: true),

      DuaModel(
          title: 'سورة الإخلاص',
          content: 'قُلْ هُوَ اللَّهُ أَحَدٌ اللَّهُ الصَّمَدُ لَمْ يَلِدْ وَلَمْ يُولَدْ وَلَمْ يَكُنْ لَهُ كُفُوًا أَحَدٌ',
          source: 'الإخلاص',
          isDefault: true,
          isAzkar: true),

      DuaModel(
          title: 'سورة الفلق',
          content: 'قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ مِنْ شَرِّ مَا خَلَقَ وَمِنْ شَرِّ غَاسِقٍ إِذَا وَقَبَ وَمِنْ شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ وَمِنْ شَرِّ حَاسِدٍ إِذَا حَسَدَ',
          source: 'الفلق',
          isDefault: true,
          isAzkar: true),

      DuaModel(
          title: 'سورة الناس',
          content: 'قُلْ أَعُوذُ بِرَبِّ النَّاسِ مَلِكِ النَّاسِ إِلَٰهِ النَّاسِ مِنْ شَرِّ الْوَسْوَاسِ الْخَنَّاسِ الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ مِنَ الْجِنَّةِ وَالنَّاسِ',
          source: 'الناس',
          isDefault: true,
          isAzkar: true),

      DuaModel(
          title: 'حسبـي الله سبع مرات',
          content: 'حَسْبِيَ اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ عَلَيْهِ تَوَكَّلْتُ وَهُوَ رَبُّ الْعَرْشِ الْعَظِيمِ',
          source: 'التوبة:129',
          isDefault: true,
          isAzkar: true),

      DuaModel(
          title: 'العفو والعافية',
          content: 'اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِي دِينِي وَدُنْيَايَ وَأَهْلِي وَمَالِي اللَّهُمَّ اسْتُرْ عَوْرَاتِي وَآمِنْ رَوْعَاتِي اللَّهُمَّ احْفَظْنِي مِنْ بَيْنِ يَدَيَّ وَمِنْ خَلْفِي وَعَنْ يَمِينِي وَعَنْ شِمَالِي وَمِنْ فَوْقِي وَأَعُوذُ بِعَظَمَتِكَ أَنْ أُغْتَالَ مِنْ تَحْتِي',
          source: 'أبو داود',
          isDefault: true,
          isAzkar: true),

      DuaModel(
          title: 'اللهم عالم الغيب والشهادة',
          content: 'اللَّهُمَّ عَالِمَ الْغَيْبِ وَالشَّهَادَةِ فَاطِرَ السَّمَاوَاتِ وَالْأَرْضِ رَبَّ كُلِّ شَيْءٍ وَمَلِيكَهُ أَشْهَدُ أَنْ لَا إِلَٰهَ إِلَّا أَنْتَ أَعُوذُ بِكَ مِنْ شَرِّ نَفْسِي وَمِنْ شَرِّ الشَّيْطَانِ وَشِرْكِهِ',
          source: 'أبو داود',
          isDefault: true,
          isAzkar: true),

      DuaModel(
          title: 'سيد الاستغفار',
          content: 'اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَٰهَ إِلَّا أَنْتَ خَلَقْتَنِي وَأَنَا عَبْدُكَ وَأَنَا عَلَىٰ عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ وَأَبُوءُ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ',
          source: 'البخاري',
          isDefault: true,
          isAzkar: true),

      DuaModel(
          title: 'اللهم ما أصبح بي من نعمة',
          content: 'اللَّهُمَّ مَا أَصْبَحَ بِي مِنْ نِعْمَةٍ أَوْ بِأَحَدٍ مِنْ خَلْقِكَ فَمِنْكَ وَحْدَكَ لَا شَرِيكَ لَكَ فَلَكَ الْحَمْدُ وَلَكَ الشُّكْرُ',
          source: 'أبو داود',
          isDefault: true,
          isAzkar: true),

      DuaModel(
          title: 'العافية في البدن',
          content: 'اللَّهُمَّ عَافِنِي فِي بَدَنِي اللَّهُمَّ عَافِنِي فِي سَمْعِي اللَّهُمَّ عَافِنِي فِي بَصَرِي لَا إِلَٰهَ إِلَّا أَنْتَ اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْكُفْرِ وَالْفَقْرِ وَأَعُوذُ بِكَ مِنْ عَذَابِ الْقَبْرِ لَا إِلَٰهَ إِلَّا أَنْتَ',
          source: 'أبو داود',
          isDefault: true,
          isAzkar: true),

      DuaModel(
          title: 'الشهادتان أربع مرات',
          content: 'اللَّهُمَّ إِنِّي أَصْبَحْتُ أُشْهِدُكَ وَأُشْهِدُ حَمَلَةَ عَرْشِكَ وَمَلَائِكَتَكَ وَجَمِيعَ خَلْقِكَ أَنَّكَ أَنْتَ اللَّهُ لَا إِلَٰهَ إِلَّا أَنْتَ وَحْدَكَ لَا شَرِيكَ لَكَ وَأَنَّ مُحَمَّدًا عَبْدُكَ وَرَسُولُكَ',
          source: 'أبو داود',
          isDefault: true,
          isAzkar: true),
    ];

    await box.addAll(defaults);
  }
}
