import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/dua_model.dart';
import '../../../data/repositories/dua_repository.dart';
import 'duas_event.dart';
import 'duas_state.dart';

class DuasBloc extends Bloc<DuasEvent, DuasState> {
  final DuaRepository _repo    = DuaRepository();
  List<DuaModel>      _items   = [];
  bool                _hasMore = true;
  int                 _page    = 0;
  late bool           _isAzkar;

  DuasBloc() : super(DuasInitial()) {
    on<LoadDuas>(_onLoad);
    on<LoadMoreDuas>(_onLoadMore);
    on<AddDua>(_onAdd);
    on<UpdateDua>(_onUpdate);
    on<DeleteDua>(_onDelete);
  }

  Future<void> _onLoad(LoadDuas event, Emitter emit) async {
    _isAzkar = event.isAzkar;
    _page    = 0;
    _items   = [];
    _hasMore = true;
    emit(DuasLoading());
    try {
      final page = await _repo.getPage(isAzkar: _isAzkar, page: 0);
      _items   = page;
      _hasMore = page.length == 20;
      _page    = 1;
      emit(DuasLoaded(List.from(_items), hasMore: _hasMore));
    } catch (e) {
      emit(DuasError(e.toString()));
    }
  }

  Future<void> _onLoadMore(LoadMoreDuas event, Emitter emit) async {
    if (!_hasMore) return;
    try {
      final page = await _repo.getPage(isAzkar: _isAzkar, page: _page);
      _items.addAll(page);
      _hasMore = page.length == 20;
      _page++;
      emit(DuasLoaded(List.from(_items), hasMore: _hasMore));
    } catch (e) {
      emit(DuasError(e.toString()));
    }
  }

  Future<void> _onAdd(AddDua event, Emitter emit) async {
    final dua = DuaModel(
      title:     event.data['title'],
      content:   event.data['content'],
      source:    event.data['source'] ?? '',
      isDefault: false,
      isAzkar:   event.isAzkar,
    );
    await _repo.add(dua);
    _items.add(dua);
    emit(DuasLoaded(List.from(_items), hasMore: _hasMore));
  }

  Future<void> _onUpdate(UpdateDua event, Emitter emit) async {
    final dua   = _items[event.index];
    dua.title   = event.data['title'];
    dua.content = event.data['content'];
    dua.source  = event.data['source'] ?? '';
    await _repo.update(dua);
    emit(DuasLoaded(List.from(_items), hasMore: _hasMore));
  }

  Future<void> _onDelete(DeleteDua event, Emitter emit) async {
    await _repo.delete(_items[event.index]);
    _items.removeAt(event.index);
    emit(DuasLoaded(List.from(_items), hasMore: _hasMore));
  }
}