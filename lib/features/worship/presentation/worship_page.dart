import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waqt/features/worship/presentation/widgets/quran_tracker.dart';
import 'package:waqt/features/worship/presentation/widgets/tasbih_counter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../features/worship/bloc/worship_bloc.dart';
import '../../../features/worship/bloc/worship_event.dart';
import '../../../features/worship/bloc/worship_state.dart';

class WorshipPage extends StatefulWidget {
  const WorshipPage({super.key});

  @override
  State<WorshipPage> createState() => _WorshipPageState();
}

class _WorshipPageState extends State<WorshipPage> {
  late WorshipBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = WorshipBloc()..add(LoadQuranProgress());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorshipBloc, WorshipState>(
      bloc: _bloc,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('العبادة')),
          body: state is WorshipLoading
              ? const Center(child: CircularProgressIndicator(color: AppColors.gold))
              : state is WorshipLoaded
              ? SingleChildScrollView(
            padding: EdgeInsets.all(AppDimensions.paddingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.quranTracker,
                    style: TextStyle(color: AppColors.gold, fontSize: AppDimensions.fontL, fontWeight: FontWeight.bold)),
                SizedBox(height: AppDimensions.paddingS),
                QuranTracker(
                  progress:       state.progress,
                  onKhatmChanged: (count) => _bloc.add(UpdateKhatmCount(count)),
                  onJuzChanged:   (juz)   => _bloc.add(UpdateCurrentJuz(juz)),
                ),
                SizedBox(height: AppDimensions.paddingL),
                Text(AppStrings.tasbih,
                    style: TextStyle(color: AppColors.gold, fontSize: AppDimensions.fontL, fontWeight: FontWeight.bold)),
                SizedBox(height: AppDimensions.paddingS),
                TasbihCounter(
                  items: state.tasbihItems,
                  onIncrement:   (i) => _bloc.add(IncrementTasbih(i)),
                  onReset:       (i) => _bloc.add(ResetTasbih(i)),
                  onUpdateLabel: (i, label) => _bloc.add(UpdateTasbihLabel(i, label)),
                ),
              ],
            ),
          )
              : const SizedBox(),
        );
      },
    );
  }
}