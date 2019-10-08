linux {
    linux-g++ | linux-g++-64 | linux-g++-32 | linux-clang {
        message("LinuxBuild")
        CONFIG += LinuxBuild
        DEFINES += __STDC_LIMIT_MACROS
        linux-clang {
            message("Linux clang")
            QMAKE_CXXFLAGS += -Qunused-arguments -fcolor-diagnostics
        }
    } else : linux-rasp-pi-g++ {
        message("RaspberryPiBuild")
        CONFIG += RaspberryPiBuild
        DEFINES += __STDC_LIMIT_MACROS __rasp_pi__
        LIBS += -lrt
        message($$LIBS)
    } else : android-g++ | android-clang {
        CONFIG += AndroidBuild MobileBuild
        DEFINES += __mobile__
        DEFINES += __android__
        DEFINES += __STDC_LIMIT_MACROS
        target.path = $$DESTDIR
        equals(ANDROID_TARGET_ARCH, x86)  {
            CONFIG += Androidx86Build
            DEFINES += __androidx86__
        }
    } else {
        error("Compiler/platform not supported")
    }
}

win32 {
    CONFIG += WindowsBuild
    DEFINES += __STDC_LIMIT_MACROS
}

macx {
    message("MacBuild")
    CONFIG += MacBuild
    DEFINES += __macos__
    CONFIG += x86_64
    CONFIG -= x86
    QMAKE_MACOSX_DEPLOYMENT_TARGET = 10.12
    QMAKE_CXXFLAGS += -fvisibility=hidden
    QMAKE_CXXFLAGS += -Wno-address-of-packed-member
}

ios {
    message("iOSBuild")
    CONFIG  += iOSBuild MobileBuild app_bundle
    DEFINES += __ios__
    DEFINES += __mobile__
    QMAKE_IOS_DEPLOYMENT_TARGET = 12.1
    QMAKE_APPLE_TARGETED_DEVICE_FAMILY = 1,2
    QMAKE_LFLAGS += -Wl
}

!iOSBuild {
    OBJECTS_DIR  = $${OUT_PWD}/obj
    MOC_DIR      = $${OUT_PWD}/moc
    UI_DIR       = $${OUT_PWD}/ui
    RCC_DIR      = $${OUT_PWD}/rcc
}

MobileBuild {
    DEFINES += __mobile__
}
