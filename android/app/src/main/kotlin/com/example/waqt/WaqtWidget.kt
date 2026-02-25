package com.example.waqt

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews

class WaqtWidget : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }
    }

    companion object {
        fun updateAppWidget(
            context: Context,
            appWidgetManager: AppWidgetManager,
            appWidgetId: Int
        ) {
            val prefs: SharedPreferences = context.getSharedPreferences(
                "FlutterSharedPreferences", Context.MODE_PRIVATE
            )

            // log عشان نشوف شو موجود
            val all = prefs.all
            android.util.Log.d("WaqtWidget", "All prefs: $all")

            val prayerName = prefs.getString("flutter.prayer_name", "الصلاة القادمة") ?: "الصلاة القادمة"
            val prayerTime = prefs.getString("flutter.prayer_time", "--:--") ?: "--:--"
            val cityName   = prefs.getString("flutter.city_name",   "دمشق")  ?: "دمشق"
            val dhikr      = prefs.getString("flutter.dhikr",       "سبحان الله") ?: "سبحان الله"

            android.util.Log.d("WaqtWidget", "prayer: $prayerName $prayerTime $cityName")

            val views = RemoteViews(context.packageName, R.layout.waqt_widget)
            views.setTextViewText(R.id.widget_prayer_name, prayerName)
            views.setTextViewText(R.id.widget_prayer_time, prayerTime)
            views.setTextViewText(R.id.widget_city,        cityName)
            views.setTextViewText(R.id.widget_dhikr,       dhikr)

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}