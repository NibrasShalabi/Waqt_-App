import '../../../data/models/dua_model.dart';

abstract class DuasState {}

class DuasInitial extends DuasState {}

class DuasLoading extends DuasState {}

class DuasLoaded extends DuasState {
  final List<DuaModel> items;
  final bool hasMore;

  DuasLoaded(this.items, {this.hasMore = false});
}

class DuasError extends DuasState {
  final String message;

  DuasError(this.message);
}
