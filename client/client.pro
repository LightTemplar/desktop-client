QT += widgets core gui network xml remoteobjects quick

TARGET = AmneziaVPN
TEMPLATE = app
#CONFIG += console

CONFIG += qtquickcompiler
CONFIG += qzxing_multimedia \
          enable_decoder_qr_code \
          enable_encoder_qr_code

DEFINES += QT_DEPRECATED_WARNINGS

include("3rd/QtSsh/src/ssh/qssh.pri")
include("3rd/QtSsh/src/botan/botan.pri")
!android:!ios:include("3rd/SingleApplication/singleapplication.pri")
include ("3rd/SortFilterProxyModel/SortFilterProxyModel.pri")
include("3rd/QZXing/src/QZXing-components.pri")

INCLUDEPATH += $$PWD/3rd/OpenSSL/include
DEPENDPATH += $$PWD/3rd/OpenSSL/include

HEADERS  += \
    ../ipc/ipc.h \
   configurators/cloak_configurator.h \
   configurators/ikev2_configurator.h \
   configurators/shadowsocks_configurator.h \
   configurators/ssh_configurator.h \
   configurators/vpn_configurator.h \
   configurators/wireguard_configurator.h \
    containers/containers_defs.h \
    core/defs.h \
    core/errorstrings.h \
    core/ipcclient.h \
    configurators/openvpn_configurator.h \
   core/privileged_process.h \
   core/scripts_registry.h \
   core/server_defs.h \
    core/servercontroller.h \
    debug.h \
    defines.h \
    managementserver.h \
   protocols/protocols_defs.h \
    settings.h \
    ui/notificationhandler.h \
    ui/models/containers_model.h \
    ui/models/protocols_model.h \
    ui/pages.h \
    ui/pages_logic/AppSettingsLogic.h \
    ui/pages_logic/GeneralSettingsLogic.h \
    ui/pages_logic/NetworkSettingsLogic.h \
   ui/pages_logic/NewServerProtocolsLogic.h \
    ui/pages_logic/PageLogicBase.h \
   ui/pages_logic/QrDecoderLogic.h \
   ui/pages_logic/ServerConfiguringProgressLogic.h \
    ui/pages_logic/ServerContainersLogic.h \
    ui/pages_logic/ServerListLogic.h \
    ui/pages_logic/ServerSettingsLogic.h \
    ui/pages_logic/ShareConnectionLogic.h \
    ui/pages_logic/SitesLogic.h \
    ui/pages_logic/StartPageLogic.h \
    ui/pages_logic/VpnLogic.h \
    ui/pages_logic/WizardLogic.h \
   ui/pages_logic/protocols/CloakLogic.h \
   ui/pages_logic/protocols/OpenVpnLogic.h \
   ui/pages_logic/protocols/OtherProtocolsLogic.h \
   ui/pages_logic/protocols/PageProtocolLogicBase.h \
   ui/pages_logic/protocols/ShadowSocksLogic.h \
    ui/property_helper.h \
    ui/models/servers_model.h \
    ui/uilogic.h \
   ui/qautostart.h \
   ui/models/sites_model.h \
    utils.h \
    vpnconnection.h \
    protocols/vpnprotocol.h \
    logger.h \
    loghandler.h \
    loglevel.h \
    constants.h

SOURCES  += \
   configurators/cloak_configurator.cpp \
   configurators/ikev2_configurator.cpp \
   configurators/shadowsocks_configurator.cpp \
   configurators/ssh_configurator.cpp \
   configurators/vpn_configurator.cpp \
   configurators/wireguard_configurator.cpp \
    containers/containers_defs.cpp \
   core/errorstrings.cpp \
    core/ipcclient.cpp \
    configurators/openvpn_configurator.cpp \
   core/privileged_process.cpp \
   core/scripts_registry.cpp \
   core/server_defs.cpp \
    core/servercontroller.cpp \
    debug.cpp \
    main.cpp \
    managementserver.cpp \
   protocols/protocols_defs.cpp \
    settings.cpp \
    ui/notificationhandler.cpp \
    ui/models/containers_model.cpp \
    ui/models/protocols_model.cpp \
    ui/pages_logic/AppSettingsLogic.cpp \
    ui/pages_logic/GeneralSettingsLogic.cpp \
    ui/pages_logic/NetworkSettingsLogic.cpp \
   ui/pages_logic/NewServerProtocolsLogic.cpp \
    ui/pages_logic/PageLogicBase.cpp \
   ui/pages_logic/QrDecoderLogic.cpp \
   ui/pages_logic/ServerConfiguringProgressLogic.cpp \
    ui/pages_logic/ServerContainersLogic.cpp \
    ui/pages_logic/ServerListLogic.cpp \
    ui/pages_logic/ServerSettingsLogic.cpp \
    ui/pages_logic/ShareConnectionLogic.cpp \
    ui/pages_logic/SitesLogic.cpp \
    ui/pages_logic/StartPageLogic.cpp \
    ui/pages_logic/VpnLogic.cpp \
    ui/pages_logic/WizardLogic.cpp \
   ui/pages_logic/protocols/CloakLogic.cpp \
   ui/pages_logic/protocols/OpenVpnLogic.cpp \
   ui/pages_logic/protocols/OtherProtocolsLogic.cpp \
   ui/pages_logic/protocols/PageProtocolLogicBase.cpp \
   ui/pages_logic/protocols/ShadowSocksLogic.cpp \
    ui/models/servers_model.cpp \
    ui/uilogic.cpp \
   ui/qautostart.cpp \
   ui/models/sites_model.cpp \
    utils.cpp \
    vpnconnection.cpp \
    protocols/vpnprotocol.cpp \
    logger.cpp \
    loghandler.cpp


RESOURCES += \
    resources.qrc

TRANSLATIONS = \
    translations/amneziavpn_ru.ts

win32 {
    DEFINES += MVPN_WINDOWS

    OTHER_FILES += platform_win/vpnclient.rc
    RC_FILE = platform_win/vpnclient.rc

    HEADERS += \
       protocols/ikev2_vpn_protocol_windows.h \
       ui/framelesswindow.h

    SOURCES += \
       protocols/ikev2_vpn_protocol_windows.cpp \
       ui/framelesswindow.cpp

    VERSION = 2.0.0.0
    QMAKE_TARGET_COMPANY = "AmneziaVPN"
    QMAKE_TARGET_PRODUCT = "AmneziaVPN"


    LIBS += \
        -luser32 \
        -lrasapi32 \
        -lshlwapi \
        -liphlpapi \
        -lws2_32 \
        -liphlpapi \
        -lgdi32


   !contains(QMAKE_TARGET.arch, x86_64) {
      message("Windows x86 build")
      LIBS += -L$$PWD/3rd/OpenSSL/lib/windows/x86/ -llibssl -llibcrypto
   }
   else {
      message("Windows x86_64 build")
      LIBS += -L$$PWD/3rd/OpenSSL/lib/windows/x86_64/ -llibssl -llibcrypto
   }
}

macx {
    DEFINES += MVPN_MACOS

    ICON   = $$PWD/images/app.icns

    HEADERS  += ui/macos_util.h
    SOURCES  += ui/macos_util.mm

    LIBS += -framework Cocoa -framework ApplicationServices -framework CoreServices -framework Foundation -framework AppKit -framework Security

    LIBS += $$PWD/3rd/OpenSSL/lib/macos/x86_64/libcrypto.a
    LIBS += $$PWD/3rd/OpenSSL/lib/macos/x86_64/libssl.a
}

linux:!android {
    DEFINES += MVPN_LINUX

    LIBS += /usr/lib/x86_64-linux-gnu/libcrypto.a
    LIBS += /usr/lib/x86_64-linux-gnu/libssl.a
}

win32|macx|linux:!android {
   DEFINES += AMNEZIA_DESKTOP

   HEADERS  += \
      ui/systemtray_notificationhandler.h \
      protocols/openvpnprotocol.h \
      protocols/openvpnovercloakprotocol.h \
      protocols/shadowsocksvpnprotocol.h \
      protocols/wireguardprotocol.h \

   SOURCES  += \
      ui/systemtray_notificationhandler.cpp \
      protocols/openvpnprotocol.cpp \
      protocols/openvpnovercloakprotocol.cpp \
      protocols/shadowsocksvpnprotocol.cpp \
      protocols/wireguardprotocol.cpp \
}

android {
   QT += androidextras
   DEFINES += MVPN_ANDROID

   INCLUDEPATH += platforms/android

   HEADERS += \
      platforms/android/native.h \
      platforms/android/android_controller.h \
      platforms/android/android_notificationhandler.h \
      protocols/android_vpnprotocol.h

   SOURCES += \
      platforms/android/native.cpp \
      platforms/android/android_controller.cpp \
      platforms/android/android_notificationhandler.cpp \
      protocols/android_vpnprotocol.cpp


   DISTFILES += \
       android/AndroidManifest.xml \
       android/build.gradle \
       android/gradle/wrapper/gradle-wrapper.jar \
       android/gradle/wrapper/gradle-wrapper.properties \
       android/gradlew \
       android/gradlew.bat \
       android/gradle.properties \
       android/res/values/libs.xml \
       android/src/org/amnezia/vpn/OpenVPNThreadv3.kt \
       android/src/org/amnezia/vpn/VpnService.kt \
       android/src/org/amnezia/vpn/VpnServiceBinder.kt \
       android/src/org/amnezia/vpn/qt/VPNPermissionHelper.kt

       ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

   for (abi, ANDROID_ABIS): {
      equals(ANDROID_TARGET_ARCH,$$abi) {
         LIBS += $$PWD/3rd/OpenSSL/lib/android/$${abi}/libcrypto.a
         LIBS += $$PWD/3rd/OpenSSL/lib/android/$${abi}/libssl.a
      }

      ANDROID_EXTRA_LIBS += $$PWD/android/lib/wireguard/$${abi}/libwg.so
      ANDROID_EXTRA_LIBS += $$PWD/android/lib/wireguard/$${abi}/libwg-go.so
      ANDROID_EXTRA_LIBS += $$PWD/android/lib/wireguard/$${abi}/libwg-quick.so

      ANDROID_EXTRA_LIBS += $$PWD/android/lib/openvpn/$${abi}/libjbcrypto.so
      ANDROID_EXTRA_LIBS += $$PWD/android/lib/openvpn/$${abi}/libopenvpn.so
      ANDROID_EXTRA_LIBS += $$PWD/android/lib/openvpn/$${abi}/libopvpnutil.so
      ANDROID_EXTRA_LIBS += $$PWD/android/lib/openvpn/$${abi}/libovpn3.so
      ANDROID_EXTRA_LIBS += $$PWD/android/lib/openvpn/$${abi}/libovpnexec.so
   }
}

ios {
    message("Client ios build")
    CONFIG += static
    CONFIG += file_copies

    # For the authentication
    LIBS += -framework AuthenticationServices

    # For notifications
    LIBS += -framework UIKit
    LIBS += -framework Foundation
    LIBS += -framework StoreKit
    LIBS += -framework UserNotifications

#    LIBS += $$PWD/3rd/OpenVPNAdapter/build/Debug-iphoneos/LZ4.framework
#    LIBS += $$PWD/3rd/OpenVPNAdapter/build/Debug-iphoneos/mbedTLS.framework
#    LIBS += $$PWD/3rd/OpenVPNAdapter/build/Debug-iphoneos/OpenVPNClient.framework
#    LIBS += $$PWD/3rd/OpenVPNAdapter/build/Debug-iphoneos/OpenVPNAdapter.framework

    DEFINES += MVPN_IOS

    HEADERS += \
      protocols/ios_vpnprotocol.h \
      platforms/ios/iosnotificationhandler.h \
      platforms/ios/json.h \
      platforms/ios/bigint.h \
      platforms/ios/bigintipv6addr.h \
      platforms/ios/ipaddress.h \
      platforms/ios/ipaddressrange.h
  
    SOURCES  += \
      protocols/ios_vpnprotocol.mm \
      platforms/ios/iosnotificationhandler.mm \
      platforms/ios/json.cpp \
      platforms/ios/iosglue.mm \
      platforms/ios/ipaddress.cpp \
      platforms/ios/ipaddressrange.cpp

    Q_ENABLE_BITCODE.value = NO
    Q_ENABLE_BITCODE.name = ENABLE_BITCODE
    QMAKE_MAC_XCODE_SETTINGS += Q_ENABLE_BITCODE

#    CONFIG(iphoneos, iphoneos|iphonesimulator) {
  iphoneos {
    message("Building for iPhone OS")
    QMAKE_TARGET_BUNDLE_PREFIX = org.amnezia
    QMAKE_BUNDLE = AmneziaVPN
    QMAKE_IOS_DEPLOYMENT_TARGET = 12.0
    QMAKE_APPLE_TARGETED_DEVICE_FAMILY = 1
    QMAKE_DEVELOPMENT_TEAM = X7UJ388FXK
    QMAKE_PROVISIONING_PROFILE = f2fefb59-14aa-4aa9-ac14-1d5531b06dcc
    QMAKE_XCODE_CODE_SIGN_IDENTITY = "Apple Distribution"
    QMAKE_INFO_PLIST = $$PWD/ios/app/Info.plist
    
    XCODEBUILD_FLAGS += -allowProvisioningUpdates
    
    DEFINES += iphoneos
    
    contains(QT_ARCH, arm64) {
      message("Building for iOS/ARM v8 64-bit architecture")
      ARCH_TAG = "ios_armv8_64"
      
      LIBS += $$PWD/3rd/OpenSSL/lib/ios/iphone/libcrypto.a
      LIBS += $$PWD/3rd/OpenSSL/lib/ios/iphone/libssl.a
    } else {
      message("Building for iOS/ARM v7 (32-bit) architecture")
      ARCH_TAG = "ios_armv7"
    }
  }
#    }
  

#    CONFIG(iphonesimulator, iphoneos|iphonesimulator) {
#  iphonesimulator {
#    message("Building for iPhone Simulator")
#    ARCH_TAG = "ios_x86_64"
#    
#    DEFINES += iphonesimulator
#    
#    LIBS += $$PWD/3rd/OpenSSL/lib/ios/simulator/libcrypto.a
#    LIBS += $$PWD/3rd/OpenSSL/lib/ios/simulator/libssl.a
#  }
#    }

    NETWORKEXTENSION=1
#    ! build_pass: system(ruby $$PWD/scripts/xcode_patcher.rb "$$PWD" "$$OUT_PWD/AmneziaVPN.xcodeproj" "2.0" "2.0.0" "ios" "$$NETWORKEXTENSION"|| echo "Failed to merge xcode with wireguard")



#ruby %{sourceDir}/client/ios/xcode_patcher.rb "%{buildDir}/AmneziaVPN.xcodeproj" "2.0" "2.0.0" "ios" "1"
    #cd client/ && /Users/md/Qt/5.15.2/ios/bin/qmake -o Makefile /Users/md/amnezia/desktop-client/client/client.pro -spec macx-ios-clang CONFIG+=iphonesimulator CONFIG+=simulator CONFIG+=qml_debug -after
# %{sourceDir}/client/ios/xcode_patcher.rb %{buildDir}/client/AmneziaVPN.xcodeproj 2.0 2.0.0 ios 1
}


REPC_REPLICA += ../ipc/ipc_interface.rep
!ios: REPC_REPLICA += ../ipc/ipc_process_interface.rep

