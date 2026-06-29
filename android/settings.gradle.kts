pluginManagement {
    // Get Flutter SDK path from local.properties
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        val localProperties = file("local.properties")
        if (localProperties.exists()) {
            localProperties.inputStream().use { properties.load(it) }
            properties.getProperty("flutter.sdk") ?: error("flutter.sdk not set in local.properties")
        } else {
            error("local.properties not found. Run 'flutter pub get' first.")
        }
    }
    
    settings.extra.set("flutterSdkPath", flutterSdkPath)
    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "9.0.0" apply false
    id("org.jetbrains.kotlin.android") version "2.0.20" apply false
}

include(":app")
