From: Nicholas Bishop <nbishop-QeEie8R3kYhl57MIdRCFDg@public.gmane.org>
Subject: [PATCH] HID: add multi-input quirk for IDC6680 touchscreen
Date: Mon,  4 Sep 2017 15:40:42 -0400
Message-ID: <20170904194042.16053-1-nbishop@neverware.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicholas Bishop <nbishop-QeEie8R3kYhl57MIdRCFDg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

The Ideacom 6680 touchscreen is found in the Dell Latitude 2100. It
has two USB descriptors, the first of which has two input reports. The
HID_QUIRK_MULTI_INPUT quirk is needed to keep the correct maximum
value for ABS_X/ABS_Y (8191 instead of 65535).

For reference, here are the full reports:

--- BEGIN REPORTS ---

cat /sys/kernel/debug/hid/0003:1CB6:6680.0001/rdesc
05 0d 09 04 a1 01 85 0a 09 20 a1 00 09 42 09 32 15 00 25 01 95 02 75 01 81 02 95 06 81 03 05 01 09 31 75 10 95 01 a4 55 0d 65 33 35 00 46 ff 1f 26 ff 1f 81 02 09 30 81 02 b4 05 0d 09 30 81 02 c0 06 00 ff 85 02 09 01 75 08 95 07 b1 02 85 03 09 02 75 08 95 07 b1 02 85 04 09 03 75 08 95 07 b1 02 85 05 09 04 75 08 95 07 b1 02 85 06 09 05 75 08 95 07 b1 02 85 07 09 06 75 08 95 07 b1 02 85 08 09 07 75 08 95 07 b1 02 85 09 09 08 75 08 95 07 b1 02 85 0b 09 09 75 08 95 07 b1 02 85 0c 09 0a 75 08 95 07 b1 02 c0 05 01 09 02 a1 01 85 01 09 01 a1 00 05 09 19 01 29 02 15 00 25 01 75 01 95 02 81 02 75 06 95 01 81 01 05 01 09 31 09 30 27 ff ff 00 00 75 10 95 02 81 02 c0 09 01 a1 02 26 ff 00 75 08 81 03 c0 c0

  INPUT(10)[INPUT]
    Field(0)
      Physical(Digitizers.Stylus)
      Application(Digitizers.TouchScreen)
      Usage(2)
        Digitizers.TipSwitch
        Digitizers.InRange
      Logical Minimum(0)
      Logical Maximum(1)
      Report Size(1)
      Report Count(2)
      Report Offset(0)
      Flags( Variable Absolute )
    Field(1)
      Physical(Digitizers.Stylus)
      Application(Digitizers.TouchScreen)
      Usage(1)
        GenericDesktop.Y
      Logical Minimum(0)
      Logical Maximum(8191)
      Physical Minimum(0)
      Physical Maximum(8191)
      Unit Exponent(-3)
      Unit(English Linear : Inch^3)
      Report Size(16)
      Report Count(1)
      Report Offset(8)
      Flags( Variable Absolute )
    Field(2)
      Physical(Digitizers.Stylus)
      Application(Digitizers.TouchScreen)
      Usage(1)
        GenericDesktop.X
      Logical Minimum(0)
      Logical Maximum(8191)
      Physical Minimum(0)
      Physical Maximum(8191)
      Unit Exponent(-3)
      Unit(English Linear : Inch^3)
      Report Size(16)
      Report Count(1)
      Report Offset(24)
      Flags( Variable Absolute )
    Field(3)
      Physical(Digitizers.Stylus)
      Application(Digitizers.TouchScreen)
      Usage(1)
        Digitizers.TipPressure
      Logical Minimum(0)
      Logical Maximum(1)
      Report Size(16)
      Report Count(1)
      Report Offset(40)
      Flags( Variable Absolute )
  INPUT(1)[INPUT]
    Field(0)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Mouse)
      Usage(2)
        Button.0001
        Button.0002
      Logical Minimum(0)
      Logical Maximum(1)
      Report Size(1)
      Report Count(2)
      Report Offset(0)
      Flags( Variable Absolute )
    Field(1)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Mouse)
      Usage(2)
        GenericDesktop.Y
        GenericDesktop.X
      Logical Minimum(0)
      Logical Maximum(65535)
      Report Size(16)
      Report Count(2)
      Report Offset(8)
      Flags( Variable Absolute )
  FEATURE(2)[FEATURE]
    Field(0)
      Application(Digitizers.TouchScreen)
      Usage(7)
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
      Logical Minimum(0)
      Logical Maximum(1)
      Report Size(8)
      Report Count(7)
      Report Offset(0)
      Flags( Variable Absolute )
  FEATURE(3)[FEATURE]
    Field(0)
      Application(Digitizers.TouchScreen)
      Usage(7)
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
      Logical Minimum(0)
      Logical Maximum(1)
      Report Size(8)
      Report Count(7)
      Report Offset(0)
      Flags( Variable Absolute )
  FEATURE(4)[FEATURE]
    Field(0)
      Application(Digitizers.TouchScreen)
      Usage(7)
        ff00.0003
        ff00.0003
        ff00.0003
        ff00.0003
        ff00.0003
        ff00.0003
        ff00.0003
      Logical Minimum(0)
      Logical Maximum(1)
      Report Size(8)
      Report Count(7)
      Report Offset(0)
      Flags( Variable Absolute )
  FEATURE(5)[FEATURE]
    Field(0)
      Application(Digitizers.TouchScreen)
      Usage(7)
        ff00.0004
        ff00.0004
        ff00.0004
        ff00.0004
        ff00.0004
        ff00.0004
        ff00.0004
      Logical Minimum(0)
      Logical Maximum(1)
      Report Size(8)
      Report Count(7)
      Report Offset(0)
      Flags( Variable Absolute )
  FEATURE(6)[FEATURE]
    Field(0)
      Application(Digitizers.TouchScreen)
      Usage(7)
        ff00.0005
        ff00.0005
        ff00.0005
        ff00.0005
        ff00.0005
        ff00.0005
        ff00.0005
      Logical Minimum(0)
      Logical Maximum(1)
      Report Size(8)
      Report Count(7)
      Report Offset(0)
      Flags( Variable Absolute )
  FEATURE(7)[FEATURE]
    Field(0)
      Application(Digitizers.TouchScreen)
      Usage(7)
        ff00.0006
        ff00.0006
        ff00.0006
        ff00.0006
        ff00.0006
        ff00.0006
        ff00.0006
      Logical Minimum(0)
      Logical Maximum(1)
      Report Size(8)
      Report Count(7)
      Report Offset(0)
      Flags( Variable Absolute )
  FEATURE(8)[FEATURE]
    Field(0)
      Application(Digitizers.TouchScreen)
      Usage(7)
        ff00.0007
        ff00.0007
        ff00.0007
        ff00.0007
        ff00.0007
        ff00.0007
        ff00.0007
      Logical Minimum(0)
      Logical Maximum(1)
      Report Size(8)
      Report Count(7)
      Report Offset(0)
      Flags( Variable Absolute )
  FEATURE(9)[FEATURE]
    Field(0)
      Application(Digitizers.TouchScreen)
      Usage(7)
        ff00.0008
        ff00.0008
        ff00.0008
        ff00.0008
        ff00.0008
        ff00.0008
        ff00.0008
      Logical Minimum(0)
      Logical Maximum(1)
      Report Size(8)
      Report Count(7)
      Report Offset(0)
      Flags( Variable Absolute )
  FEATURE(11)[FEATURE]
    Field(0)
      Application(Digitizers.TouchScreen)
      Usage(7)
        ff00.0009
        ff00.0009
        ff00.0009
        ff00.0009
        ff00.0009
        ff00.0009
        ff00.0009
      Logical Minimum(0)
      Logical Maximum(1)
      Report Size(8)
      Report Count(7)
      Report Offset(0)
      Flags( Variable Absolute )
  FEATURE(12)[FEATURE]
    Field(0)
      Application(Digitizers.TouchScreen)
      Usage(7)
        ff00.000a
        ff00.000a
        ff00.000a
        ff00.000a
        ff00.000a
        ff00.000a
        ff00.000a
      Logical Minimum(0)
      Logical Maximum(1)
      Report Size(8)
      Report Count(7)
      Report Offset(0)
      Flags( Variable Absolute )

Digitizers.TipSwitch ---> Key.Touch
Digitizers.InRange ---> Key.ToolPen
GenericDesktop.Y ---> Absolute.Y
GenericDesktop.X ---> Absolute.X
Digitizers.TipPressure ---> Absolute.Pressure
Button.0001 ---> Key.LeftBtn
Button.0002 ---> Key.RightBtn
GenericDesktop.Y ---> Absolute.Y
GenericDesktop.X ---> Absolute.X

cat /sys/kernel/debug/hid/0003:1CB6:6680.0002/rdesc
05 01 09 02 a1 01 85 01 09 01 a1 00 05 09 19 01 29 02 15 00 25 01 75 01 95 02 81 02 75 06 95 01 81 01 05 01 09 31 09 30 27 ff ff 00 00 75 10 95 02 81 02 c0 09 01 a1 02 26 ff 00 75 08 81 03 c0 c0

  INPUT(1)[INPUT]
    Field(0)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Mouse)
      Usage(2)
        Button.0001
        Button.0002
      Logical Minimum(0)
      Logical Maximum(1)
      Report Size(1)
      Report Count(2)
      Report Offset(0)
      Flags( Variable Absolute )
    Field(1)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Mouse)
      Usage(2)
        GenericDesktop.Y
        GenericDesktop.X
      Logical Minimum(0)
      Logical Maximum(65535)
      Report Size(16)
      Report Count(2)
      Report Offset(8)
      Flags( Variable Absolute )

Button.0001 ---> Key.LeftBtn
Button.0002 ---> Key.RightBtn
GenericDesktop.Y ---> Absolute.Y
GenericDesktop.X ---> Absolute.X

--- END REPORTS ---

Signed-off-by: Nicholas Bishop <nbishop-QeEie8R3kYhl57MIdRCFDg@public.gmane.org>
---
 drivers/hid/hid-ids.h           | 1 +
 drivers/hid/usbhid/hid-quirks.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index c9ba4c6db74c..33b4f2a2697a 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -531,6 +531,7 @@
 #define USB_VENDOR_ID_IDEACOM		0x1cb6
 #define USB_DEVICE_ID_IDEACOM_IDC6650	0x6650
 #define USB_DEVICE_ID_IDEACOM_IDC6651	0x6651
+#define USB_DEVICE_ID_IDEACOM_IDC6680	0x6680
 
 #define USB_VENDOR_ID_ILITEK		0x222a
 #define USB_DEVICE_ID_ILITEK_MULTITOUCH	0x0001
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index a88e7c7bea0a..dc0c321baa30 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -99,6 +99,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0A4A, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0B4A, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE, HID_QUIRK_ALWAYS_POLL },
+	{ USB_VENDOR_ID_IDEACOM, USB_DEVICE_ID_IDEACOM_IDC6680, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_C077, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_KEYBOARD_G710_PLUS, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_C01A, HID_QUIRK_ALWAYS_POLL },
-- 
2.13.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
