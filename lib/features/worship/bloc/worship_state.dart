import '../../../data/models/quran_progress_model.dart';

abstract class WorshipState {}

class WorshipInitial extends WorshipState {}
class WorshipLoading extends WorshipState {}
class WorshipError   extends WorshipState { final String message; WorshipError(this.message); }

class WorshipLoaded  extends WorshipState {
  final QuranProgressModel           progress;
  final List<Map<String, dynamic>>   tasbihItems;

  WorshipLoaded({required this.progress, required this.tasbihItems});
}