package com.example.student;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodChannel;

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.PowerManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Bundle;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "heartbeat.fritz.ai/native";

  static{
      // System.loadLibrary("native_add");
      System.loadLibrary("Qt5Core");
      System.loadLibrary("Qt5Bluetooth");
      System.loadLibrary("Qt5Gui");
      System.loadLibrary("Qt5AndroidExtras");
      System.loadLibrary("Qt5Concurrent");
    }
  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {  

    GeneratedPluginRegistrant.registerWith(flutterEngine);

  }
}


