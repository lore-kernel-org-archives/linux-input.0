From: Simon Wood <simon@mungewell.org>
Subject: [PATCH] HID: hid-lg: Add USBID for Logitech G29 Wheel
Date: Thu, 23 Jul 2015 19:10:03 -0600
Message-ID: <1437700203-4546-1-git-send-email-simon@mungewell.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Simon Wood <simon@mungewell.org>
List-Id: linux-input@vger.kernel.org

Since this wheel is now available, and the USBID is listed on their website,
this patch adds it to allow the hid-lg4ff force feedback driver to find it.

I do not have this wheel to test with, but this should at least get it working
in emulation mode.

Note: There is probably more work required for adjust HID descriptor and handle
switching between emulation and native modes.

Signed-off-by: Simon Wood <simon@mungewell.org>
---
 drivers/hid/hid-ids.h | 1 +
 drivers/hid/hid-lg.c  | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b04b082..653bfd4 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -599,6 +599,7 @@
 #define USB_DEVICE_ID_LOGITECH_DUAL_ACTION	0xc216
 #define USB_DEVICE_ID_LOGITECH_RUMBLEPAD2	0xc218
 #define USB_DEVICE_ID_LOGITECH_RUMBLEPAD2_2	0xc219
+#define USB_DEVICE_ID_LOGITECH_G29_WHEEL	0xc24f
 #define USB_DEVICE_ID_LOGITECH_WINGMAN_F3D	0xc283
 #define USB_DEVICE_ID_LOGITECH_FORCE3D_PRO	0xc286
 #define USB_DEVICE_ID_LOGITECH_FLIGHT_SYSTEM_G940	0xc287
diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index 429340d..5332fb7 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -776,6 +776,8 @@ static const struct hid_device_id lg_devices[] = {
 		.driver_data = LG_FF },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD2_2),
 		.driver_data = LG_FF },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G29_WHEEL),
+		.driver_data = LG_FF4 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WINGMAN_F3D),
 		.driver_data = LG_FF },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_FORCE3D_PRO),
-- 
2.1.4
