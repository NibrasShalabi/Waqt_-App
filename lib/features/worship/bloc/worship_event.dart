abstract class WorshipEvent {}

class LoadQuranProgress  extends WorshipEvent {}
class UpdateKhatmCount   extends WorshipEvent { final int count; UpdateKhatmCount(this.count); }
class UpdateCurrentJuz   extends WorshipEvent { final int juz;   UpdateCurrentJuz(this.juz); }

// التسبيح
class LoadTasbih         extends WorshipEvent {}
class IncrementTasbih    extends WorshipEvent { final int index;  IncrementTasbih(this.index); }
class ResetTasbih        extends WorshipEvent { final int index;  ResetTasbih(this.index); }
class UpdateTasbihLabel  extends WorshipEvent { final int index;  final String label; UpdateTasbihLabel(this.index, this.label); }