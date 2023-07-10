# Basic
PRODUCT_PACKAGES += \
    messaging \
    Gallery2 \
    Contacts \
    Dialer \
    Jelly \
    LatinIME \
    SecurityHub \
    SettingsIntelligenceGoogle \
    SoundPickerGoogleRelease
    
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += \
    vendor/cherish/overlay-aosp

DEVICE_PACKAGE_OVERLAYS += \
    vendor/cherish/overlay-aosp/common
    
# Build
PRODUCT_BROKEN_VERIFY_USES_LIBRARIES := true

# Permissions
PRODUCT_COPY_FILES += \
    vendor/cherish/config/permissions/privapp-permissions-cherish-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-cherish-product.xml \
    vendor/cherish/config/permissions/default-permissions-cherish-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/default-permissions/default-permissions-cherish-product.xml
