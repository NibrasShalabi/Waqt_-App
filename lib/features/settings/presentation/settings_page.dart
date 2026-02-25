import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/cities_data.dart';
import '../../../features/settings/bloc/settings_bloc.dart';
import '../../../features/settings/bloc/settings_event.dart';
import '../../../features/settings/bloc/settings_state.dart';
import 'widgets/settings_tile.dart';

class SettingsPage extends StatefulWidget {
  final VoidCallback? onCityChanged;
  const SettingsPage({super.key, this.onCityChanged});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late SettingsBloc _bloc;
  String _selectedCity = 'دمشق';

  @override
  void initState() {
    super.initState();
    _bloc = SettingsBloc()..add(LoadSettings());
    _loadCity();
  }

  Future<void> _loadCity() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => _selectedCity = prefs.getString('selected_city') ?? 'دمشق');
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void _showCityPicker(BuildContext context) {
    String search = '';
    showModalBottomSheet(
      context:            context,
      isScrollControlled: true,
      backgroundColor:    AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppDimensions.radiusXL)),
      ),
      builder: (_) => StatefulBuilder(
        builder: (context, setModalState) {
          final filtered = CitiesData.cities
              .where((c) => c.nameAr.contains(search) || c.country.contains(search))
              .toList();

          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.85,
            child: Column(
              children: [
                SizedBox(height: AppDimensions.paddingM),
                Container(
                  width: 40.w, height: 4.h,
                  decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)),
                ),
                SizedBox(height: AppDimensions.paddingM),
                Text('اختر مدينتك',
                    style: TextStyle(color: AppColors.gold, fontSize: AppDimensions.fontXL, fontWeight: FontWeight.bold)),
                SizedBox(height: AppDimensions.paddingM),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
                  child: TextField(
                    textAlign:  TextAlign.right,
                    style:      TextStyle(color: AppColors.textPrimary),
                    decoration: InputDecoration(
                      hintText:   'ابحث عن مدينة أو دولة...',
                      hintStyle:  TextStyle(color: AppColors.textHint),
                      prefixIcon: Icon(Icons.search, color: AppColors.textHint),
                      filled:     true,
                      fillColor:  AppColors.card,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                        borderSide:   BorderSide.none,
                      ),
                    ),
                    onChanged: (v) => setModalState(() => search = v),
                  ),
                ),
                SizedBox(height: AppDimensions.paddingS),
                Expanded(
                  child: ListView.separated(
                    itemCount:        filtered.length,
                    separatorBuilder: (_, __) => Divider(height: 1, color: AppColors.divider),
                    itemBuilder: (_, i) {
                      final city = filtered[i];
                      return ListTile(
                        title:    Text(city.nameAr, style: TextStyle(color: AppColors.textPrimary, fontSize: AppDimensions.fontM)),
                        subtitle: Text(city.country, style: TextStyle(color: AppColors.textHint, fontSize: AppDimensions.fontS)),
                        trailing: Text(city.nameEn, style: TextStyle(color: AppColors.textSecondary, fontSize: AppDimensions.fontS)),
                        selected:          city.nameAr == _selectedCity,
                        selectedTileColor: AppColors.gold.withOpacity(0.1),
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString('selected_city', city.nameAr);
                          setState(() => _selectedCity = city.nameAr);
                          widget.onCityChanged?.call();
                          if (context.mounted) Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      bloc: _bloc,
      builder: (context, state) {
        if (state is! SettingsLoaded) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator(color: AppColors.gold)),
          );
        }

        return Scaffold(
          appBar: AppBar(title: const Text('الإعدادات')),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(AppDimensions.paddingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('الموقع',
                    style: TextStyle(color: AppColors.gold, fontSize: AppDimensions.fontL, fontWeight: FontWeight.bold)),
                SizedBox(height: AppDimensions.paddingS),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: ListTile(
                    leading: Container(
                      width: 40.w, height: 40.w,
                      decoration: BoxDecoration(
                        color:        AppColors.primary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                      ),
                      child: Icon(Icons.location_city, color: AppColors.gold, size: AppDimensions.iconM),
                    ),
                    title:    Text('المدينة', style: TextStyle(color: AppColors.textPrimary, fontSize: AppDimensions.fontM)),
                    subtitle: Text(_selectedCity, style: TextStyle(color: AppColors.gold, fontSize: AppDimensions.fontS)),
                    trailing: Icon(Icons.arrow_forward_ios, color: AppColors.textHint, size: AppDimensions.iconS),
                    onTap:    () => _showCityPicker(context),
                  ),
                ),
                SizedBox(height: AppDimensions.paddingL),

                Text(AppStrings.notifications,
                    style: TextStyle(color: AppColors.gold, fontSize: AppDimensions.fontL, fontWeight: FontWeight.bold)),
                SizedBox(height: AppDimensions.paddingS),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      SettingsTile(
                        icon: Icons.notifications_outlined, iconColor: AppColors.gold,
                        title: AppStrings.prayerNotification, subtitle: 'تنبيه عند دخول وقت الصلاة',
                        value: state.prayerNotif, onChanged: (v) => _bloc.add(TogglePrayerNotif(v)), showDivider: true,
                      ),
                      SettingsTile(
                        icon: Icons.menu_book_outlined, iconColor: AppColors.primary,
                        title: AppStrings.quranNotification, subtitle: 'تذكير يومي بقراءة القرآن',
                        value: state.quranNotif, onChanged: (v) => _bloc.add(ToggleQuranNotif(v)), showDivider: true,
                      ),
                      SettingsTile(
                        icon: Icons.wb_sunny_outlined, iconColor: AppColors.sunrise,
                        title: AppStrings.azkarNotification, subtitle: 'أذكار الصباح والمساء',
                        value: state.azkarNotif, onChanged: (v) => _bloc.add(ToggleAzkarNotif(v)), showDivider: false,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppDimensions.paddingL),

                Text('الهاتف',
                    style: TextStyle(color: AppColors.gold, fontSize: AppDimensions.fontL, fontWeight: FontWeight.bold)),
                SizedBox(height: AppDimensions.paddingS),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: SettingsTile(
                    icon: Icons.do_not_disturb_on_outlined, iconColor: AppColors.error,
                    title: AppStrings.dndMode, subtitle: AppStrings.dndDescription,
                    value: state.dndMode, onChanged: (v) => _bloc.add(ToggleDnd(v)), showDivider: false,
                  ),
                ),
                SizedBox(height: AppDimensions.paddingL),

                // Text('الويدجت',
                //     style: TextStyle(color: AppColors.gold, fontSize: AppDimensions.fontL, fontWeight: FontWeight.bold)),
                // SizedBox(height: AppDimensions.paddingS),
               // home widgits
                // Container(
                //   decoration: BoxDecoration(
                //     color: AppColors.card,
                //     borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                //     border: Border.all(color: AppColors.border),
                //   ),
                //   child: ListTile(
                //     leading: Container(
                //       width: 40.w, height: 40.w,
                //       decoration: BoxDecoration(
                //         color:        AppColors.primary.withOpacity(0.2),
                //         borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                //       ),
                //       child: Icon(Icons.widgets_outlined, color: AppColors.primary, size: AppDimensions.iconM),
                //     ),
                //     title:    Text(AppStrings.widget, style: TextStyle(color: AppColors.textPrimary, fontSize: AppDimensions.fontM)),
                //     subtitle: Text(AppStrings.widgetDescription, style: TextStyle(color: AppColors.textHint, fontSize: AppDimensions.fontS)),
                //     trailing: Icon(Icons.arrow_forward_ios, color: AppColors.textHint, size: AppDimensions.iconS),
                //     onTap: () {},
                //   ),
                // ),
                SizedBox(height: AppDimensions.paddingL),

                Center(
                  child: Column(
                    children: [
                      Text('Waqt', style: TextStyle(color: AppColors.gold, fontSize: AppDimensions.fontXL, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4.h),
                      Text('الإصدار 1.0.0', style: TextStyle(color: AppColors.textHint, fontSize: AppDimensions.fontS)),
                      Text('nibras.shalabi0@gmail.com', style: TextStyle(color: AppColors.textHint, fontSize: AppDimensions.fontXS)),
                    ],
                  ),
                ),
                SizedBox(height: AppDimensions.paddingL),
              ],
            ),
          ),
        );
      },
    );
  }
}