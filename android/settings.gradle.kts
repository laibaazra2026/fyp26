pluginManagement {
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        file("local.properties").inputStream().use {
            properties.load(it)
        }
        val flutterSdkPath = properties.getProperty("flutter.sdk")
        checkNotNull(flutterSdkPath) {
            "flutter.sdk not set in local.properties"
        }
        flutterSdkPath
    }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

dependencyResolutionManagement {
    repositories {
        google()
        mavenCentral()
    }


    
}

rootProject.name = "device_security_system"
include(":app")