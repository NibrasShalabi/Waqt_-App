import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TasbihRepository {
  static const String _key = 'tasbih_items';

  static const List<Map<String, dynamic>> _defaults = [
    {'label': 'سبحان الله',     'count': 0},
    {'label': 'الحمد لله',      'count': 0},
    {'label': 'الله أكبر',      'count': 0},
    {'label': 'لا إله إلا الله', 'count': 0},
  ];

  Future<List<Map<String, dynamic>>> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    final json  = prefs.getString(_key);
    if (json == null) return List.from(_defaults);
    return List<Map<String, dynamic>>.from(jsonDecode(json));
  }

  Future<void> saveAll(List<Map<String, dynamic>> items) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(items));
  }

  Future<void> increment(List<Map<String, dynamic>> items, int index) async {
    items[index]['count']++;
    await saveAll(items);
  }

  Future<void> reset(List<Map<String, dynamic>> items, int index) async {
    items[index]['count'] = 0;
    await saveAll(items);
  }

  Future<void> updateLabel(List<Map<String, dynamic>> items, int index, String label) async {
    items[index]['label'] = label;
    await saveAll(items);
  }
}