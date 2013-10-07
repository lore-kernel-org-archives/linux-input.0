From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH] HID: logitech - lg2ff: Add IDs for Formula Vibration Feedback Wheel
Date: Mon,  7 Oct 2013 19:48:12 +0300
Message-ID: <1381164492-27145-1-git-send-email-anssi.hannula@iki.fi>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Elias Vanderstuyft <Elias.vds@gmail.com>, Simon Wood <simon@mungewell.org>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Elias Vanderstuyft <Elias.vds@gmail.com>

Add USB IDs for Logitech Formula Vibration Feedback Wheel (046d:ca04).

The lg2ff force feedback subdriver is used for vibration and
HID_GD_MULTIAXIS is set to avoid deadzone like other Logitech wheels.

Kconfig description etc are also updated accordingly.

Signed-off-by: Elias Vanderstuyft <Elias.vds@gmail.com>
[anssi.hannula@iki.fi: added description and CCs]
Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
Cc: Simon Wood <simon@mungewell.org>
Cc: <stable@vger.kernel.org>
---

Simon, does this look OK to you, or do you think it should be an lg4ff
device? Though I guess lg2ff is better than nothing even in that case.

Jiri, lets see if we get a comment from Simon before applying.

I added CC to stable since it is just ID additions (plus description
stuff), but feel free to drop that if you think it is not appropriate.


 drivers/hid/Kconfig     | 8 +++++---
 drivers/hid/hid-core.c  | 1 +
 drivers/hid/hid-ids.h   | 1 +
 drivers/hid/hid-lg.c    | 3 +++
 drivers/hid/hid-lg2ff.c | 2 +-
 5 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 71b70e3..42c2a8b 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -368,12 +368,14 @@ config LOGITECH_FF
 	  force feedback.
 
 config LOGIRUMBLEPAD2_FF
-	bool "Logitech RumblePad/Rumblepad 2 force feedback support"
+	bool "Logitech force feedback support (variant 2)"
 	depends on HID_LOGITECH
 	select INPUT_FF_MEMLESS
 	help
-	  Say Y here if you want to enable force feedback support for Logitech
-	  RumblePad and Rumblepad 2 devices.
+	  Say Y here if you want to enable force feedback support for:
+	  - Logitech RumblePad
+	  - Logitech Rumblepad 2
+	  - Logitech Formula Vibration Feedback Wheel
 
 config LOGIG940_FF
 	bool "Logitech Flight System G940 force feedback support"
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index b8470b1..037915f 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1752,6 +1752,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_FLIGHT_SYSTEM_G940) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOMO_WHEEL) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOMO_WHEEL2) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_VIBRATION_WHEEL) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_DFP_WHEEL) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_DFGT_WHEEL) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G25_WHEEL) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index e60e8d5..0ff958b 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -570,6 +570,7 @@
 #define USB_DEVICE_ID_DINOVO_EDGE	0xc714
 #define USB_DEVICE_ID_DINOVO_MINI	0xc71f
 #define USB_DEVICE_ID_LOGITECH_MOMO_WHEEL2	0xca03
+#define USB_DEVICE_ID_LOGITECH_VIBRATION_WHEEL	0xca04
 
 #define USB_VENDOR_ID_LUMIO		0x202e
 #define USB_DEVICE_ID_CRYSTALTOUCH	0x0006
diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index 6f12ecd..c2c7dab 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -492,6 +492,7 @@ static int lg_input_mapped(struct hid_device *hdev, struct hid_input *hi,
 		case USB_DEVICE_ID_LOGITECH_G27_WHEEL:
 		case USB_DEVICE_ID_LOGITECH_WII_WHEEL:
 		case USB_DEVICE_ID_LOGITECH_MOMO_WHEEL2:
+		case USB_DEVICE_ID_LOGITECH_VIBRATION_WHEEL:
 			field->application = HID_GD_MULTIAXIS;
 			break;
 		default:
@@ -639,6 +640,8 @@ static const struct hid_device_id lg_devices[] = {
 		.driver_data = LG_NOGET | LG_FF4 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOMO_WHEEL2),
 		.driver_data = LG_FF4 },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_VIBRATION_WHEEL),
+		.driver_data = LG_FF2 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G25_WHEEL),
 		.driver_data = LG_FF4 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_DFGT_WHEEL),
diff --git a/drivers/hid/hid-lg2ff.c b/drivers/hid/hid-lg2ff.c
index 1a42eaa..0e3fb1a 100644
--- a/drivers/hid/hid-lg2ff.c
+++ b/drivers/hid/hid-lg2ff.c
@@ -95,7 +95,7 @@ int lg2ff_init(struct hid_device *hid)
 
 	hid_hw_request(hid, report, HID_REQ_SET_REPORT);
 
-	hid_info(hid, "Force feedback for Logitech RumblePad/Rumblepad 2 by Anssi Hannula <anssi.hannula@gmail.com>\n");
+	hid_info(hid, "Force feedback for Logitech variant 2 rumble devices by Anssi Hannula <anssi.hannula@gmail.com>\n");
 
 	return 0;
 }
-- 
1.8.1.5
