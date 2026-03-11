import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waqt/features/duas/bloc/duas_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../adhkar/dua_model.dart';
import '../bloc/duas_event.dart';
import '../bloc/duas_state.dart';
import 'widgets/dua_card.dart';
import 'widgets/dua_form_sheet.dart';

class DuasPage extends StatefulWidget {
  const DuasPage({super.key});

  @override
  State<DuasPage> createState() => _DuasPageState();
}

class _DuasPageState extends State<DuasPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late DuasBloc _duasBloc;
  late DuasBloc _azkarBloc;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _duasBloc  = DuasBloc()..add(LoadDuas(false));
    _azkarBloc = DuasBloc()..add(LoadDuas(true));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _duasBloc.close();
    _azkarBloc.close();
    super.dispose();
  }

  DuasBloc get _currentBloc =>
      _tabController.index == 0 ? _duasBloc : _azkarBloc;

  void _showAddSheet() {
    final isAzkar = _tabController.index == 1;
    showModalBottomSheet(
      context:            context,
      isScrollControlled: true,
      backgroundColor:    AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusXL),
        ),
      ),
      builder: (_) => DuaFormSheet(
        isAzkar: isAzkar,
        onSave:  (data) => _currentBloc.add(AddDua(data, isAzkar)),
      ),
    );
  }

  void _showEditSheet(int index, DuaModel dua) {
    final isAzkar = _tabController.index == 1;
    showModalBottomSheet(
      context:            context,
      isScrollControlled: true,
      backgroundColor:    AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusXL),
        ),
      ),
      builder: (_) => DuaFormSheet(
        isAzkar:  isAzkar,
        existing: {
          'title':   dua.title,
          'content': dua.content,
          'source':  dua.source,
        },
        onSave: (data) => _currentBloc.add(UpdateDua(index, data)),
      ),
    );
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text('حذف', style: TextStyle(color: AppColors.textPrimary, fontSize: AppDimensions.fontL)),
        content: Text(AppStrings.confirmDelete, style: TextStyle(color: AppColors.textSecondary, fontSize: AppDimensions.fontM)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppStrings.cancel, style: const TextStyle(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () {
              _currentBloc.add(DeleteDua(index));
              Navigator.pop(context);
            },
            child: Text(AppStrings.delete, style: const TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  Widget _buildList(DuasBloc bloc) {
    return BlocBuilder<DuasBloc, DuasState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is DuasLoading) {
          return const Center(child: CircularProgressIndicator(color: AppColors.gold));
        }
        if (state is DuasLoaded) {
          if (state.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.menu_book_outlined, color: AppColors.textHint, size: AppDimensions.iconXL),
                  SizedBox(height: AppDimensions.paddingM),
                  Text(AppStrings.empty, style: TextStyle(color: AppColors.textHint, fontSize: AppDimensions.fontM)),
                ],
              ),
            );
          }
          return NotificationListener<ScrollNotification>(
            onNotification: (scroll) {
              if (scroll.metrics.pixels >= scroll.metrics.maxScrollExtent - 200 && state.hasMore) {
                bloc.add(LoadMoreDuas());
              }
              return false;
            },
            child: ListView.builder(
              padding:     EdgeInsets.all(AppDimensions.paddingM),
              itemCount:   state.items.length + (state.hasMore ? 1 : 0),
              itemBuilder: (_, i) {
                if (i == state.items.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(color: AppColors.gold),
                    ),
                  );
                }
                return DuaCard(
                  title:     state.items[i].title,
                  content:   state.items[i].content,
                  source:    state.items[i].source,
                  isDefault: state.items[i].isDefault,
                  onEdit:    () => _showEditSheet(i, state.items[i]),
                  onDelete:  () => _confirmDelete(i),
                );
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الأدعية'),
        bottom: TabBar(
          controller:           _tabController,
          indicatorColor:       AppColors.gold,
          labelColor:           AppColors.gold,
          unselectedLabelColor: AppColors.textHint,
          onTap: (_) => setState(() {}),
          labelStyle: TextStyle(fontSize: AppDimensions.fontM),
          tabs: const [
            Tab(text: 'الأدعية'),
            Tab(text: 'الأذكار'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildList(_duasBloc),
          _buildList(_azkarBloc),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:       _showAddSheet,
        backgroundColor: AppColors.primary,
        child: Icon(Icons.add, color: AppColors.gold, size: AppDimensions.iconM),
      ),
    );
  }
}