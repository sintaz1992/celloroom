package com.example.student;

import androidx.annotation.NonNull;

import dalvik.system.DexClassLoader;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodChannel;

import android.app.Activity;
import android.content.ComponentName;
import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.ComponentInfo;
import android.content.pm.PackageManager;
import android.nfc.Tag;
import android.os.Build;
import android.os.Debug;
import android.os.PowerManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Bundle;
import android.util.Log;

import java.io.File;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;



public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "heartbeat.fritz.ai/native";

    ////////////////QT VARIABLES//////////////////////////
    public static final String ERROR_CODE_KEY = "error.code";
    public static final String ERROR_MESSAGE_KEY = "error.message";
    public static final String DEX_PATH_KEY = "dex.path";
    public static final String LIB_PATH_KEY = "lib.path";
    public static final String LOADER_CLASS_NAME_KEY = "loader.class.name";
    public static final String NATIVE_LIBRARIES_KEY = "native.libraries";
    public static final String ENVIRONMENT_VARIABLES_KEY = "environment.variables";
    public static final String APPLICATION_PARAMETERS_KEY = "application.parameters";
    public static final String BUNDLED_LIBRARIES_KEY = "bundled.libraries";
    public static final String MAIN_LIBRARY_KEY = "main.library";
    public static final String STATIC_INIT_CLASSES_KEY = "static.init.classes";
    public static final String NECESSITAS_API_LEVEL_KEY = "necessitas.api.level";
    public static final String EXTRACT_STYLE_KEY = "extract.android.style";
    private static final String EXTRACT_STYLE_MINIMAL_KEY = "extract.android.style.option";

    // These parameters matter in case of deploying application as system (embedded into firmware)
    public static final String SYSTEM_LIB_PATH = "/system/lib/";
    private static final String TAG = "MyActivity";
    public String[] SYSTEM_APP_PATHS = {"/system/priv-app/", "/system/app/"};
    public String[] m_sources = {"https://download.qt-project.org/ministro/android/qt5/qt-5.7"}; // Make sure you are using ONLY secure locations
    public String m_repository = "default"; // Overwrites the default Ministro repository
    public ArrayList<String> m_qtLibs = null; // required qt libs
    public String ENVIRONMENT_VARIABLES = "QT_USE_ANDROID_NATIVE_DIALOGS=1";
    public int m_displayDensity = -1;
    public String APPLICATION_PARAMETERS = null; // use this variable to pass any parameters to your application,
    /////////////////QT VARIABLES///////////////////////

    ////////////////////////////////////////////////////////////////Qt///////////////////////////////////////////////////////////////////////
    protected ComponentInfo m_contextInfo;
    private ContextWrapper m_context = this;
    private String preferredAbi = null;
    private final List<String> supportedAbis = Arrays.asList(Build.SUPPORTED_ABIS);

    protected String loaderClassName() {
        return "org.qtproject.qt5.android.QtActivityDelegate";
    }
    protected Class<?> contextClassName() {
        return android.app.Activity.class;
    }

    private ArrayList<String> prefferedAbiLibs(String []libs)
    {
        HashMap<String, ArrayList<String>> abisLibs = new HashMap<>();
        for (String lib : libs) {
            String[] archLib = lib.split(";", 2);
            if (preferredAbi != null && !archLib[0].equals(preferredAbi))
                continue;
            if (!abisLibs.containsKey(archLib[0]))
                abisLibs.put(archLib[0], new ArrayList<String>());
            abisLibs.get(archLib[0]).add(archLib[1]);
        }

        if (preferredAbi != null) {
            if (abisLibs.containsKey(preferredAbi)) {
                return abisLibs.get(preferredAbi);
            }
            return new ArrayList<String>();
        }

        for (String abi: supportedAbis) {
            if (abisLibs.containsKey(abi)) {
                preferredAbi = abi;
                return abisLibs.get(abi);
            }
        }
        return new ArrayList<String>();
    }



    public void startApp(final boolean firstStart) {
        try {
            if (m_contextInfo.metaData.containsKey("android.app.qt_sources_resource_id")) {
                int resourceId = m_contextInfo.metaData.getInt("android.app.qt_sources_resource_id");
                m_sources = m_context.getResources().getStringArray(resourceId);
            }

            if (m_contextInfo.metaData.containsKey("android.app.qt_libs_resource_id")) {
                int resourceId = m_contextInfo.metaData.getInt("android.app.qt_libs_resource_id");
                m_qtLibs = prefferedAbiLibs(m_context.getResources().getStringArray(resourceId));
            }
            Log.d(TAG, ""+m_contextInfo.metaData.containsKey("android.app.use_local_qt_libs"));
            if (m_contextInfo.metaData.containsKey("android.app.use_local_qt_libs")
                    && m_contextInfo.metaData.getInt("android.app.use_local_qt_libs") == 1) {
                Log.d(TAG,"qt Loader1 ---------------------------------------");
                ArrayList<String> libraryList = new ArrayList<String>();

                boolean apkDeployFromSystem = false;
                String apkPath = m_context.getApplicationInfo().publicSourceDir;
                File apkFile = new File(apkPath);
                if (apkFile.exists() && Arrays.asList(SYSTEM_APP_PATHS).contains(apkFile.getParentFile().getAbsolutePath() + "/"))
                    apkDeployFromSystem = true;

                String libsDir = null;
                String bundledLibsDir = null;
                if (apkDeployFromSystem) {
                    String systemLibsPrefix = SYSTEM_LIB_PATH;
                    if (m_contextInfo.metaData.containsKey("android.app.system_libs_prefix")) {
                        systemLibsPrefix = m_contextInfo.metaData.getString("android.app.system_libs_prefix");
                    } else {
                        Log.e(TAG, "It looks like app deployed as system app. "
                                + "It may be necessary to specify path to system lib directory using "
                                + "android.app.system_libs_prefix metadata variable in your AndroidManifest.xml");
                        Log.e(TAG, "Using " + SYSTEM_LIB_PATH + " as default path");
                    }
                    File systemLibraryDir = new File(systemLibsPrefix);
                    if (systemLibraryDir.exists() && systemLibraryDir.isDirectory() && systemLibraryDir.list().length > 0)
                        libsDir = systemLibsPrefix;
                } else {
                    String nativeLibraryPrefix = m_context.getApplicationInfo().nativeLibraryDir + "/";
                    File nativeLibraryDir = new File(nativeLibraryPrefix);
                    if (nativeLibraryDir.exists() && nativeLibraryDir.isDirectory() && nativeLibraryDir.list().length > 0) {
                        libsDir = nativeLibraryPrefix;
                        bundledLibsDir = nativeLibraryPrefix;
                    }

                }

                if (apkDeployFromSystem && libsDir == null)
                    throw new Exception("");


                if (m_qtLibs != null) {
                    String libPrefix = libsDir + "lib";
                    for (String lib : m_qtLibs)
                        libraryList.add(libPrefix + lib + ".so");
                }

                if (m_contextInfo.metaData.containsKey("android.app.bundle_local_qt_libs")
                        && m_contextInfo.metaData.getInt("android.app.bundle_local_qt_libs") == 1) {
                    int resourceId = m_contextInfo.metaData.getInt("android.app.load_local_libs_resource_id");
                    for (String libs : prefferedAbiLibs(m_context.getResources().getStringArray(resourceId))) {
                        for (String lib : libs.split(":")) {
                            if (!lib.isEmpty())
                                libraryList.add(libsDir + lib);
                        }
                    }
                    if (bundledLibsDir != null)
                        ENVIRONMENT_VARIABLES += "\tQT_BUNDLED_LIBS_PATH=" + bundledLibsDir;
                }


                Bundle loaderParams = new Bundle();
                loaderParams.putInt(ERROR_CODE_KEY, 0);
                loaderParams.putString(DEX_PATH_KEY, new String());
                loaderParams.putString(LOADER_CLASS_NAME_KEY, loaderClassName());
                if (m_contextInfo.metaData.containsKey("android.app.static_init_classes")) {
                    loaderParams.putStringArray(STATIC_INIT_CLASSES_KEY,
                            m_contextInfo.metaData.getString("android.app.static_init_classes").split(":"));
                }
                loaderParams.putStringArrayList(NATIVE_LIBRARIES_KEY, libraryList);
                loaderParams.putString(ENVIRONMENT_VARIABLES_KEY, ENVIRONMENT_VARIABLES);

                String appParams = null;
                if (APPLICATION_PARAMETERS != null)
                    appParams = APPLICATION_PARAMETERS;

                Intent intent = getIntent();
                if (intent != null) {
                    String parameters = intent.getStringExtra("applicationArguments");
                    if (parameters != null)
                        if (appParams == null)
                            appParams = parameters;
                        else
                            appParams += '\t' + parameters;
                }

                if (appParams != null)
                    loaderParams.putString(APPLICATION_PARAMETERS_KEY, appParams.replace(' ', '\t').trim());

                loadApplication(loaderParams);

                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    // this function is used to load and start the loader
    private void loadApplication(Bundle loaderParams)
    {

        try {Log.d(TAG,"qt Loader1");
            // add all bundled Qt libs to loader params
            ArrayList<String> libs = new ArrayList<String>();
            if (m_contextInfo.metaData.containsKey("android.app.bundled_libs_resource_id")) {
                int resourceId = m_contextInfo.metaData.getInt("android.app.bundled_libs_resource_id");
                libs.addAll(prefferedAbiLibs(m_context.getResources().getStringArray(resourceId)));
            }

            String libName = null;
            if (m_contextInfo.metaData.containsKey("android.app.lib_name")) {
                libName = m_contextInfo.metaData.getString("android.app.lib_name") + "_" + preferredAbi;
                loaderParams.putString(MAIN_LIBRARY_KEY, libName); //main library contains main() function
            }

            loaderParams.putStringArrayList(BUNDLED_LIBRARIES_KEY, libs);
            //loaderParams.putInt(NECESSITAS_API_LEVEL_KEY, NECESSITAS_API_LEVEL);

            // load and start QtLoader class
            DexClassLoader classLoader = new DexClassLoader(loaderParams.getString(DEX_PATH_KEY), // .jar/.apk files
                    m_context.getDir("outdex", Context.MODE_PRIVATE).getAbsolutePath(), // directory where optimized DEX files should be written.
                    loaderParams.containsKey(LIB_PATH_KEY) ? loaderParams.getString(LIB_PATH_KEY) : null, // libs folder (if exists)
                    m_context.getClassLoader()); // parent loader

            Class<?> loaderClass = classLoader.loadClass(loaderParams.getString(LOADER_CLASS_NAME_KEY)); // load QtLoader class
            Object qtLoader = loaderClass.newInstance(); // create an instance
            Method prepareAppMethod = qtLoader.getClass().getMethod("loadApplication",
                    contextClassName(),
                    ClassLoader.class,
                    Bundle.class);

            Log.d(TAG,"qt Loader");

            if (!(Boolean)prepareAppMethod.invoke(qtLoader, m_context, classLoader, loaderParams))
                throw new Exception("");

            /*QtApplication.setQtContextDelegate(m_delegateClass, qtLoader);

            Method startAppMethod=qtLoader.getClass().getMethod("startApplication");
            if (!(Boolean)startAppMethod.invoke(qtLoader))
                throw new Exception("");
            */
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    static{
      // System.loadLibrary("native_add");
     /* System.loadLibrary("Qt5Core_arm64-v8a");
      System.loadLibrary("Qt5Bluetooth_arm64-v8a");
      System.loadLibrary("Qt5Gui_arm64-v8a");
      System.loadLibrary("Qt5AndroidExtras_arm64-v8a");
      System.loadLibrary("plugins_bearer_qandroidbearer_arm64-v8a");*/
      
    // load and start QtLoader class
      /*DexClassLoader classLoader = new DexClassLoader(DEX_PATH_KEY), // .jar/.apk files
                    m_context.getDir("outdex", Context.MODE_PRIVATE).getAbsolutePath(), // directory where optimized DEX files should be written.
                    loaderParams.containsKey(LIB_PATH_KEY) ? loaderParams.getString(LIB_PATH_KEY) : null, // libs folder (if exists)
                    m_context.getClassLoader()); // parent loader

      Class<?> initClass = classLoader.loadClass("org.qtproject.qt5.android.bluetooth.QtBluetoothBroadcastReceiver");
      Object staticInitDataObject = initClass.newInstance();
      try{
          Method m = initClass.getMethod("setActivity",Activity.class, Object.class);
          m.invoke(staticInitDataObject, m_context,this);
      }catch (Exception e){
          Log.d("initClass");
      }
      try{
          Method m = initClass.getMethod("setContext", Context.class);
          m.invoke(staticInitDataObject,(Context)m_context);
      }catch (Exception e){
          e.printStackTrace();
      }*/

      //System.loadLibrary("plugins_platforms_qtforandroid_arm64-v8a");
      //System.loadLibrary("Qt5Concurrent");
    }
    @Override
    public void onCreate(Bundle savedInstanceState)
    {

        Log.d(TAG,"sd");
        try {
            m_contextInfo = m_context.getPackageManager().getActivityInfo(new ComponentName(m_context, m_context.getClass()), PackageManager.GET_META_DATA);
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }
        Log.d(TAG,"-----------------------"+m_contextInfo.name);
        
        startApp(true);
        Log.d(TAG,"startApp true On Create");
        super.onCreate(savedInstanceState);
    }
  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {  

    GeneratedPluginRegistrant.registerWith(flutterEngine);

    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
        .setMethodCallHandler((call, result) -> {
          // if (call.method.equals("powerManage")) {
          //   boolean deviceStatus = getDeviceStatus();

          //   String myMessage =  Boolean.toString(deviceStatus);
          //   result.success(myMessage);
          //}
          System.err.println("load library");
          result.success("YES");
        });
  }

  private boolean getDeviceStatus() {
    boolean deviceStatus = false;
    if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
      PowerManager powerManager = (PowerManager) getSystemService(POWER_SERVICE);
      deviceStatus = powerManager.isDeviceIdleMode();

    } 
  
    return deviceStatus;

  }
}
