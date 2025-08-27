plugins {
    id("com.android.application")
    id("kotlin-android")
    // Flutter Gradle Plugin باید بعد از Android و Kotlin باشه
    id("dev.flutter.flutter-gradle-plugin")
    // برای Firebase
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.my_first_app01"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    defaultConfig {
        applicationId = "com.example.my_first_app01"
        minSdk = 23
        targetSdk = 33
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    buildTypes {
        release {
            // فعلاً با کلید دیباگ امضا می‌کنیم
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // BOM = مدیریت ورژن اتوماتیک
    implementation platform("com.google.firebase:firebase-bom:33.1.2")
    // یکی دو تا سرویس برای تست (Analytics رو معمولا همه می‌ذارن)
    implementation "com.google.firebase:firebase-analytics"
}
