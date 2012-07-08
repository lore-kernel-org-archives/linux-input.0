From: Yuri Khan <yurivkhan@gmail.com>
Subject: [PATCH v2 1/1] Input: xpad - Handle all variations of Mad Catz Beat Pad
Date: Sun,  8 Jul 2012 12:49:49 +0700
Message-ID: <1341726589-5400-1-git-send-email-yurivkhan@gmail.com>
References: <1341592324-665-1-git-send-email-yurivkhan@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1341592324-665-1-git-send-email-yurivkhan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, Yuri Khan <yurivkhan@gmail.com>
List-Id: linux-input@vger.kernel.org

* Add a quirk to usbhid to ignore this device
---
 drivers/hid/hid-ids.h           |    3 +++
 drivers/hid/usbhid/hid-quirks.c |    2 ++
 drivers/input/joystick/xpad.c   |    1 +
 3 files changed, 6 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index d1cdd2d..43c3d75 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -518,6 +518,9 @@
 #define USB_DEVICE_ID_CRYSTALTOUCH	0x0006
 #define USB_DEVICE_ID_CRYSTALTOUCH_DUAL	0x0007
 
+#define USB_VENDOR_ID_MADCATZ		0x0738
+#define USB_DEVICE_ID_MADCATZ_BEATPAD	0x4540
+
 #define USB_VENDOR_ID_MCC		0x09db
 #define USB_DEVICE_ID_MCC_PMD1024LS	0x0076
 #define USB_DEVICE_ID_MCC_PMD1208LS	0x007a
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 0597ee6..8726d33 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -45,6 +45,8 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RUMBLEPAD, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_TOPMAX, USB_DEVICE_ID_TOPMAX_COBRAPAD, HID_QUIRK_BADPAD },
 
+	{ USB_VENDOR_ID_MADCATZ, USB_DEVICE_ID_MADCATZ_BEATPAD, HID_QUIRK_IGNORE },
+
 	{ USB_VENDOR_ID_AFATECH, USB_DEVICE_ID_AFATECH_AF9016, HID_QUIRK_FULLSPEED_INTERVAL },
 
 	{ USB_VENDOR_ID_EMS, USB_DEVICE_ID_EMS_TRIO_LINKER_PLUS_II, HID_QUIRK_MULTI_INPUT },
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index ee16fb6..16974ef 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -238,6 +238,7 @@ static struct usb_device_id xpad_table [] = {
 	XPAD_XBOX360_VENDOR(0x045e),		/* Microsoft X-Box 360 controllers */
 	XPAD_XBOX360_VENDOR(0x046d),		/* Logitech X-Box 360 style controllers */
 	XPAD_XBOX360_VENDOR(0x0738),		/* Mad Catz X-Box 360 controllers */
+	{ USB_DEVICE(0x0738, 0x4540) },		/* Mad Catz Beat Pad */
 	XPAD_XBOX360_VENDOR(0x0e6f),		/* 0x0e6f X-Box 360 controllers */
 	XPAD_XBOX360_VENDOR(0x12ab),		/* X-Box 360 dance pads */
 	XPAD_XBOX360_VENDOR(0x1430),		/* RedOctane X-Box 360 controllers */
-- 
1.7.9.5
