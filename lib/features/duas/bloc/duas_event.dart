abstract class DuasEvent {}

class LoadDuas extends DuasEvent {
  final bool isAzkar;

  LoadDuas(this.isAzkar);
}

class LoadMoreDuas extends DuasEvent {}

class AddDua extends DuasEvent {
  final Map<String, dynamic> data;
  final bool isAzkar;

  AddDua(this.data, this.isAzkar);
}

class UpdateDua extends DuasEvent {
  final int index;
  final Map<String, dynamic> data;

  UpdateDua(this.index, this.data);
}

class DeleteDua extends DuasEvent {
  final int index;

  DeleteDua(this.index);
}
