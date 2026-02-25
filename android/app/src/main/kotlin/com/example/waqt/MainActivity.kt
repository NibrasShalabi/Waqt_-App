package com.example.waqt

import android.appwidget.AppWidgetManager
import android.content.ComponentName
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.example.waqt/widget")
            .setMethodCallHandler { call, result ->
                if (call.method == "updateWidget") {
                    val appWidgetManager = AppWidgetManager.getInstance(this)
                    val ids = appWidgetManager.getAppWidgetIds(
                        ComponentName(this, WaqtWidget::class.java)
                    )
                    for (id in ids) {
                        WaqtWidget.updateAppWidget(this, appWidgetManager, id)
                    }
                    result.success(null)
                } else {
                    result.notImplemented()
                }
            }
    }
}