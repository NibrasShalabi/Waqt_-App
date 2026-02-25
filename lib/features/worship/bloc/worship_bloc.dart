import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../data/repositories/quran_repository.dart';
import 'worship_event.dart';
import 'worship_state.dart';

class WorshipBloc extends Bloc<WorshipEvent, WorshipState> {
  final QuranRepository _repo = QuranRepository();

  static const String _tasbihKey = 'tasbih_items';
  List<Map<String, dynamic>> _tasbihItems = [];

  static const List<Map<String, dynamic>> _defaultTasbih = [
    {'label': 'سبحان الله',      'count': 0},
    {'label': 'الحمد لله',       'count': 0},
    {'label': 'الله أكبر',       'count': 0},
    {'label': 'لا إله إلا الله', 'count': 0},
  ];

  WorshipBloc() : super(WorshipInitial()) {
    on<LoadQuranProgress>(_onLoad);
    on<UpdateKhatmCount>(_onUpdateKhatm);
    on<UpdateCurrentJuz>(_onUpdateJuz);
    on<LoadTasbih>(_onLoadTasbih);
    on<IncrementTasbih>(_onIncrement);
    on<ResetTasbih>(_onReset);
    on<UpdateTasbihLabel>(_onUpdateLabel);
  }

  Future<void> _saveTasbih() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tasbihKey, jsonEncode(_tasbihItems));
  }

  Future<void> _onLoad(LoadQuranProgress event, Emitter emit) async {
    emit(WorshipLoading());
    try {
      // حمّل القرآن والتسبيح مع بعض
      final progress = await _repo.getProgress();
      final prefs    = await SharedPreferences.getInstance();
      final json     = prefs.getString(_tasbihKey);
      _tasbihItems   = json != null
          ? List<Map<String, dynamic>>.from(jsonDecode(json))
          : _defaultTasbih.map((e) => Map<String, dynamic>.from(e)).toList();

      emit(WorshipLoaded(progress: progress, tasbihItems: List.from(_tasbihItems)));
    } catch (e) {
      emit(WorshipError(e.toString()));
    }
  }

  Future<void> _onUpdateKhatm(UpdateKhatmCount event, Emitter emit) async {
    await _repo.updateKhatmCount(event.count);
    final progress = await _repo.getProgress();
    emit(WorshipLoaded(progress: progress, tasbihItems: List.from(_tasbihItems)));
  }

  Future<void> _onUpdateJuz(UpdateCurrentJuz event, Emitter emit) async {
    await _repo.updateJuz(event.juz);
    final progress = await _repo.getProgress();
    emit(WorshipLoaded(progress: progress, tasbihItems: List.from(_tasbihItems)));
  }

  Future<void> _onLoadTasbih(LoadTasbih event, Emitter emit) async {
    if (state is! WorshipLoaded) return;
    final current = state as WorshipLoaded;
    emit(WorshipLoaded(progress: current.progress, tasbihItems: List.from(_tasbihItems)));
  }

  Future<void> _onIncrement(IncrementTasbih event, Emitter emit) async {
    if (state is! WorshipLoaded) return;
    final current = state as WorshipLoaded;
    _tasbihItems[event.index]['count']++;
    await _saveTasbih();
    emit(WorshipLoaded(progress: current.progress, tasbihItems: List.from(_tasbihItems)));
  }

  Future<void> _onReset(ResetTasbih event, Emitter emit) async {
    if (state is! WorshipLoaded) return;
    final current = state as WorshipLoaded;
    _tasbihItems[event.index]['count'] = 0;
    await _saveTasbih();
    emit(WorshipLoaded(progress: current.progress, tasbihItems: List.from(_tasbihItems)));
  }

  Future<void> _onUpdateLabel(UpdateTasbihLabel event, Emitter emit) async {
    if (state is! WorshipLoaded) return;
    final current = state as WorshipLoaded;
    _tasbihItems[event.index]['label'] = event.label;
    await _saveTasbih();
    emit(WorshipLoaded(progress: current.progress, tasbihItems: List.from(_tasbihItems)));
  }
}