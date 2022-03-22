PRODUCT_BRAND ?= aosp

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(TARGET_BUILD_VARIANT),user)
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
else
# Disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
endif

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/aosp/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# Enforce privapp-permissions whitelist
#PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
#    ro.control_privapp_permissions=enforce

# Power whitelist
PRODUCT_COPY_FILES += \
    vendor/aosp/config/permissions/custom-power-whitelist.xml:system/etc/sysconfig/custom-power-whitelist.xml

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

# Dex preopt
PRODUCT_DEXPREOPT_SPEED_APPS += \
    Launcher3QuickStep \
    SystemUI \
    NexusLauncherRelease

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    fsck.ntfs \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs \
    mount.ntfs

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/aosp/overlay
DEVICE_PACKAGE_OVERLAYS += vendor/aosp/overlay/common

# Face Unlock
ifeq ($(TARGET_FACE_UNLOCK), true)
PRODUCT_PACKAGES += \
    FaceUnlockService

PRODUCT_COPY_FILES += \
    vendor/apps/FaceUnlock/prebuilt/product/etc/default-permissions/facesense-default-permissions.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/default-permissions/facesense-default-permissions.xml

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.face.sense_service=true
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.face.sense_service=false
endif

# SystemUI plugins
PRODUCT_PACKAGES += \
    QuickAccessWallet

# TouchGestures
PRODUCT_PACKAGES += \
    TouchGestures

# Charger images
include vendor/aosp/config/charger-res.mk

# Branding
include vendor/aosp/config/branding.mk

-include $(WORKSPACE)/build_env/image-auto-bits.mk

# Lawnchair
-include vendor/huexxx-prebuilts/packages/apps/Lawnchair/lawnchair.mk
-include vendor/huexxx-prebuilts/packages/apps/Lawnicons/lawnicons.mk

# Pre-granted product permissions
PRODUCT_COPY_FILES += \
    vendor/aosp/config/permissions/default-permissions-product-huexxx.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/default-permissions/default-permissions-product-huexxx.xml

# Gapps
$(call inherit-product, vendor/aosp/config/gapps.mk)

PRODUCT_PACKAGES += \
    libjni_latinimegoogle

ifneq ($(WITH_GAPPS),true)
# Pixel sysconfig
PRODUCT_COPY_FILES += \
    vendor/aosp/prebuilt/common/etc/sysconfig/pixel.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/pixel.xml \
    vendor/aosp/prebuilt/common/etc/permissions/privapp-permissions-google.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-google.xml
endif

# Pixel sysconfig from Pixel XL (Photos)
PRODUCT_COPY_FILES += \
    vendor/aosp/prebuilt/common/etc/sysconfig/pixel_2016_exclusive.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/pixel_2016_exclusive.xml

# Needed by some RILs and for some gApps packages
PRODUCT_PACKAGES += \
    librsjni \
    libprotobuf-cpp-full

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.mode=OPTIONAL \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.setupwizard.rotation_locked=true \
    ro.opa.eligible_device=true \
    persist.debug.wfd.enable=1 \
    persist.sys.wfd.virtual=0 \
    persist.sys.dun.override=0 \
    ro.storage_manager.enabled=true \
    persist.sys.recovery_update=false \
    ro.com.google.ime.bs_theme=true \
    ro.com.google.ime.theme_id=5 \
    persist.sys.disable_rescue=true
