From: Matjaz Hegedic <matjaz.hegedic@gmail.com>
Subject: [PATCH] HID: asus: fix special key support for ASUS I2C keyboards
Date: Sun,  5 Mar 2017 01:50:34 +0100
Message-ID: <1488675034-7220-1-git-send-email-matjaz.hegedic@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35760 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752186AbdCEAv3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 4 Mar 2017 19:51:29 -0500
Received: by mail-wr0-f195.google.com with SMTP id u108so13545010wrb.2
        for <linux-input@vger.kernel.org>; Sat, 04 Mar 2017 16:51:28 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, Matjaz Hegedic <matjaz.hegedic@gmail.com>

On some ASUS notebooks (EeeBook X205TA, VivoBook E200HA) the built-in
keyboard uses a vendor-specific HID Usage Page for its special keys
(airplane mode, brightness, volume, etc.) which require remapping.
This cannot be resolved without a kernel driver (eg. udev/hwdb).
In addition, sloppy vendor implementation produces two tables
almost full of dummy usages, which misrepresent this devices'
capabilities and causes X to see it as a pointer/joystick device.
This patch adds the appropriate re-mappings and ignores the incorrect
dummy values.

Signed-off-by: Matjaz Hegedic <matjaz.hegedic@gmail.com>
---
 drivers/hid/hid-asus.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 70b12f8..a6492ec 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1,12 +1,14 @@
 /*
  *  HID driver for Asus notebook built-in keyboard.
- *  Fixes small logical maximum to match usage maximum.
+ *  Fixes small logical maximum to match usage maximum,
+ *  adds special key support, and ignores dummy usages.
  *
  *  Currently supported devices are:
  *    EeeBook X205TA
  *    VivoBook E200HA
  *
  *  Copyright (c) 2016 Yusuke Fujimaki <usk.fujimaki@gmail.com>
+ *  Copyright (c) 2017 Matjaz Hegedic <matjaz.hegedic@gmail.com>
  *
  *  This module based on hid-ortek by
  *  Copyright (c) 2010 Johnathon Harris <jmharris@gmail.com>
@@ -36,8 +38,11 @@ MODULE_AUTHOR("Yusuke Fujimaki <usk.fujimaki@gmail.com>");
 MODULE_AUTHOR("Brendan McGrath <redmcg@redmandi.dyndns.org>");
 MODULE_AUTHOR("Victor Vlasenko <victor.vlasenko@sysgears.com>");
 MODULE_AUTHOR("Frederik Wenigwieser <frederik.wenigwieser@gmail.com>");
+MODULE_AUTHOR("Matjaz Hegedic <matjaz.hegedic@gmail.com>");
 MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 
+#define HID_UP_ASUSVENDOR    0xff310000
+
 #define FEATURE_REPORT_ID 0x0d
 #define INPUT_REPORT_ID 0x5d
 
@@ -63,15 +68,20 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define QUIRK_NO_INIT_REPORTS		BIT(1)
 #define QUIRK_SKIP_INPUT_MAPPING	BIT(2)
 #define QUIRK_IS_MULTITOUCH		BIT(3)
+#define QUIRK_NO_CONSUMER_USAGES	BIT(4)
 
 #define KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT | \
-						 QUIRK_NO_INIT_REPORTS)
+						 QUIRK_NO_INIT_REPORTS | \
+						 QUIRK_NO_CONSUMER_USAGES)
 #define TOUCHPAD_QUIRKS			(QUIRK_NO_INIT_REPORTS | \
 						 QUIRK_SKIP_INPUT_MAPPING | \
 						 QUIRK_IS_MULTITOUCH)
 
 #define TRKID_SGN       ((TRKID_MAX + 1) >> 1)
 
+#define asus_map_key_clear(c)	hid_map_usage_clear(hi, usage, bit, \
+		max, EV_KEY, (c))
+
 struct asus_drvdata {
 	unsigned long quirks;
 	struct input_dev *input;
@@ -213,6 +223,42 @@ static int asus_input_mapping(struct hid_device *hdev,
 		return -1;
 	}
 
+	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_ASUSVENDOR) {
+		switch (usage->hid & HID_USAGE) {
+		case 0x10:
+			asus_map_key_clear(KEY_BRIGHTNESSDOWN); break;
+		case 0x20:
+			asus_map_key_clear(KEY_BRIGHTNESSUP); break;
+		case 0x35:
+			asus_map_key_clear(KEY_DISPLAY_OFF); break;
+		case 0x6b:
+			asus_map_key_clear(KEY_F21); break;
+		case 0x6c:
+			asus_map_key_clear(KEY_SLEEP); break;
+		case 0x88:
+			asus_map_key_clear(KEY_RFKILL);	break;
+		default:
+			/* ASUS lazily declares 256 usages, ignore the rest */
+			return -1;
+		}
+		return 1;
+	}
+
+	if (drvdata->quirks & QUIRK_NO_CONSUMER_USAGES &&
+		(usage->hid & HID_USAGE_PAGE) == HID_UP_CONSUMER) {
+		switch (usage->hid & HID_USAGE) {
+		case 0xe2: /* Mute */
+		case 0xe9: /* Volume up */
+		case 0xea: /* Volume down */
+			return 0;
+		default:
+			/* Ignore dummy Consumer usages which make the
+			 * keyboard incorrectly appear as a pointer device.
+			 */
+			return -1;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.7.4

