From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] HID: wacom: generic: add 5 tablet touch keys
Date: Mon, 12 Dec 2016 15:46:25 -0800
Message-ID: <1481586385-4555-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34416 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752497AbcLLXqo (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 12 Dec 2016 18:46:44 -0500
Received: by mail-pg0-f65.google.com with SMTP id e9so2437952pgc.1
        for <linux-input@vger.kernel.org>; Mon, 12 Dec 2016 15:46:44 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, dmitry.torokhov@gmail.com, benjamin.tissoires@redhat.com, jason.gerecke@wacom.com, Ping Cheng <pingc@wacom.com>, Ping Cheng <ping.cheng@wacom.com>

Wacom Cintiq Pro [1] is a series of display tablets. They support
5 touch keys on the tablet. Those keys represent specific functions.
They turn display off; bring up OSD; bring up On Screen Keyboard;
bring up desktop control panel; and turn touch on/off.

The most left touch key, that turns display on/off, is controlled by
firmware. When the display is off, the mode is on. Otherwise, the
mode is off. So, it works like a switch. That's why we introduced a
new switch: SW_INDIRECT.

Other four touch keys are true software keys. We use the existing
KEY_BUTTONCONFIG and KEY_CONTROLPANEL for OSD and control panel. But,
we have to request two new keys: KEY_ONSCREEN_KEYBOARD and KEY_MUTE_DEVICE
since none of the existing keys support those two actions.

[1] http://www.wacom.com/en-us/products/pen-displays/wacom-cintiq-pro

Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
---
 drivers/hid/wacom_wac.c                | 20 ++++++++++++++++++++
 drivers/hid/wacom_wac.h                |  5 +++++
 include/linux/mod_devicetable.h        |  2 +-
 include/uapi/linux/input-event-codes.h |  6 +++++-
 4 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index b1a9a3c..f47be36 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1578,6 +1578,26 @@ static void wacom_wac_pad_usage_mapping(struct hid_device *hdev,
 		wacom_map_usage(input, usage, field, EV_ABS, ABS_WHEEL, 0);
 		features->device_type |= WACOM_DEVICETYPE_PAD;
 		break;
+	case WACOM_HID_WD_INDIRECT:
+		wacom_map_usage(input, usage, field, EV_SW, SW_INDIRECT, 0);
+		features->device_type |= WACOM_DEVICETYPE_PAD;
+		break;
+	case WACOM_HID_WD_BUTTONCONFIG:
+		wacom_map_usage(input, usage, field, EV_KEY, KEY_BUTTONCONFIG, 0);
+		features->device_type |= WACOM_DEVICETYPE_PAD;
+		break;
+	case WACOM_HID_WD_ONSCREEN_KEYBOARD:
+		wacom_map_usage(input, usage, field, EV_KEY, KEY_ONSCREEN_KEYBOARD, 0);
+		features->device_type |= WACOM_DEVICETYPE_PAD;
+		break;
+	case WACOM_HID_WD_CONTROLPANEL:
+		wacom_map_usage(input, usage, field, EV_KEY, KEY_CONTROLPANEL, 0);
+		features->device_type |= WACOM_DEVICETYPE_PAD;
+		break;
+	case WACOM_HID_WD_MUTE_DEVICE:
+		wacom_map_usage(input, usage, field, EV_KEY, KEY_MUTE_DEVICE, 0);
+		features->device_type |= WACOM_DEVICETYPE_PAD;
+		break;
 	}
 
 	switch (equivalent_usage & 0xfffffff0) {
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index fb0e50a..a96184f 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -105,6 +105,11 @@
 #define WACOM_HID_WD_ACCELEROMETER_Z    (WACOM_HID_UP_WACOMDIGITIZER | 0x0403)
 #define WACOM_HID_WD_BATTERY_CHARGING   (WACOM_HID_UP_WACOMDIGITIZER | 0x0404)
 #define WACOM_HID_WD_BATTERY_LEVEL      (WACOM_HID_UP_WACOMDIGITIZER | 0x043b)
+#define WACOM_HID_WD_INDIRECT           (WACOM_HID_UP_WACOMDIGITIZER | 0x0980)
+#define WACOM_HID_WD_MUTE_DEVICE        (WACOM_HID_UP_WACOMDIGITIZER | 0x0981)
+#define WACOM_HID_WD_CONTROLPANEL       (WACOM_HID_UP_WACOMDIGITIZER | 0x0982)
+#define WACOM_HID_WD_ONSCREEN_KEYBOARD  (WACOM_HID_UP_WACOMDIGITIZER | 0x0983)
+#define WACOM_HID_WD_BUTTONCONFIG       (WACOM_HID_UP_WACOMDIGITIZER | 0x0986)
 #define WACOM_HID_WD_EXPRESSKEY00       (WACOM_HID_UP_WACOMDIGITIZER | 0x0910)
 #define WACOM_HID_WD_EXPRESSKEYCAP00    (WACOM_HID_UP_WACOMDIGITIZER | 0x0950)
 #define WACOM_HID_WD_BUTTONHOME         (WACOM_HID_UP_WACOMDIGITIZER | 0x0990)
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index ed84c07..342ddd6 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -291,7 +291,7 @@ struct pcmcia_device_id {
 #define INPUT_DEVICE_ID_LED_MAX		0x0f
 #define INPUT_DEVICE_ID_SND_MAX		0x07
 #define INPUT_DEVICE_ID_FF_MAX		0x7f
-#define INPUT_DEVICE_ID_SW_MAX		0x0f
+#define INPUT_DEVICE_ID_SW_MAX		0x1f
 
 #define INPUT_DEVICE_ID_MATCH_BUS	1
 #define INPUT_DEVICE_ID_MATCH_VENDOR	2
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index d6d071f..c9633c8 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -641,6 +641,9 @@
  * e.g. teletext or data broadcast application (MHEG, MHP, HbbTV, etc.)
  */
 #define KEY_DATA			0x275
+/* same as SW_MUTE_DEVICE but triggered by a key */
+#define KEY_MUTE_DEVICE			0x278 /* set = device disabled */
+#define KEY_ONSCREEN_KEYBOARD		0x279
 
 #define BTN_TRIGGER_HAPPY		0x2c0
 #define BTN_TRIGGER_HAPPY1		0x2c0
@@ -781,7 +784,8 @@
 #define SW_LINEIN_INSERT	0x0d  /* set = inserted */
 #define SW_MUTE_DEVICE		0x0e  /* set = device disabled */
 #define SW_PEN_INSERTED		0x0f  /* set = pen inserted */
-#define SW_MAX			0x0f
+#define SW_INDIRECT		0x10  /* set = not a direct input device */
+#define SW_MAX			0x1f
 #define SW_CNT			(SW_MAX+1)
 
 /*
-- 
2.7.4

