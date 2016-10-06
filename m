From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 18/19] HID: wacom: generic: Extend pad support
Date: Thu,  6 Oct 2016 14:22:30 -0700
Message-ID: <20161006212231.31440-19-killertofu@gmail.com>
References: <20161006212231.31440-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36519 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935088AbcJFVXI (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 6 Oct 2016 17:23:08 -0400
Received: by mail-qk0-f195.google.com with SMTP id z190so1660936qkc.3
        for <linux-input@vger.kernel.org>; Thu, 06 Oct 2016 14:23:08 -0700 (PDT)
In-Reply-To: <20161006212231.31440-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <ping.cheng@wacom.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, Jason Gerecke <killertofu@gmail.com>

The HID specification that the MobileStudio Pro follows includes usages
for several values that would be good to support so that future devices
"just work" out of the box. Extend the HID_GENERIC pad codepath to handle
these usages.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 15 +++++++++++++++
 drivers/hid/wacom_wac.h |  5 +++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index f75ffae..4f449a0 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1457,6 +1457,8 @@ static int wacom_equivalent_usage(int usage)
 		    usage == WACOM_HID_WD_SERIALHI ||
 		    usage == WACOM_HID_WD_TOOLTYPE ||
 		    usage == WACOM_HID_WD_DISTANCE ||
+		    usage == WACOM_HID_WD_TOUCHSTRIP ||
+		    usage == WACOM_HID_WD_TOUCHSTRIP2 ||
 		    usage == WACOM_HID_WD_TOUCHRING ||
 		    usage == WACOM_HID_WD_TOUCHRINGSTATUS) {
 			return usage;
@@ -1513,6 +1515,9 @@ static void wacom_map_usage(struct input_dev *input, struct hid_device *hdev,
 	case EV_MSC:
 		input_set_capability(input, EV_MSC, code);
 		break;
+	case EV_SW:
+		input_set_capability(input, EV_SW, code);
+		break;
 	}
 }
 
@@ -1547,11 +1552,21 @@ static void wacom_wac_pad_usage_mapping(struct hid_device *hdev,
 	case WACOM_HID_WD_BUTTONDOWN:
 	case WACOM_HID_WD_BUTTONLEFT:
 	case WACOM_HID_WD_BUTTONRIGHT:
+	case WACOM_HID_WD_BUTTONCENTER:
 		wacom_map_usage(input, hdev, usage, field, EV_KEY,
 				wacom_numbered_button_to_key(features->numbered_buttons),
 				0);
 		features->numbered_buttons++;
 		break;
+	case WACOM_HID_WD_TOUCHONOFF:
+		wacom_map_usage(input, hdev, usage, field, EV_SW, SW_MUTE_DEVICE, 0);
+		break;
+	case WACOM_HID_WD_TOUCHSTRIP:
+		wacom_map_usage(input, hdev, usage, field, EV_ABS, ABS_RX, 0);
+		break;
+	case WACOM_HID_WD_TOUCHSTRIP2:
+		wacom_map_usage(input, hdev, usage, field, EV_ABS, ABS_RY, 0);
+		break;
 	case WACOM_HID_WD_TOUCHRING:
 		wacom_map_usage(input, hdev, usage, field, EV_ABS, ABS_WHEEL, 0);
 		break;
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index fa5b772..f70f7fd 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -96,6 +96,8 @@
 #define WACOM_HID_WD_SERIALHI           (WACOM_HID_UP_WACOMDIGITIZER | 0x5c)
 #define WACOM_HID_WD_TOOLTYPE           (WACOM_HID_UP_WACOMDIGITIZER | 0x77)
 #define WACOM_HID_WD_DISTANCE           (WACOM_HID_UP_WACOMDIGITIZER | 0x0132)
+#define WACOM_HID_WD_TOUCHSTRIP         (WACOM_HID_UP_WACOMDIGITIZER | 0x0136)
+#define WACOM_HID_WD_TOUCHSTRIP2        (WACOM_HID_UP_WACOMDIGITIZER | 0x0137)
 #define WACOM_HID_WD_TOUCHRING          (WACOM_HID_UP_WACOMDIGITIZER | 0x0138)
 #define WACOM_HID_WD_TOUCHRINGSTATUS    (WACOM_HID_UP_WACOMDIGITIZER | 0x0139)
 #define WACOM_HID_WD_ACCELEROMETER_X    (WACOM_HID_UP_WACOMDIGITIZER | 0x0401)
@@ -104,11 +106,14 @@
 #define WACOM_HID_WD_BATTERY_CHARGING   (WACOM_HID_UP_WACOMDIGITIZER | 0x0404)
 #define WACOM_HID_WD_BATTERY_LEVEL      (WACOM_HID_UP_WACOMDIGITIZER | 0x043b)
 #define WACOM_HID_WD_EXPRESSKEY00       (WACOM_HID_UP_WACOMDIGITIZER | 0x0910)
+#define WACOM_HID_WD_EXPRESSKEYCAP00    (WACOM_HID_UP_WACOMDIGITIZER | 0x0950)
 #define WACOM_HID_WD_BUTTONHOME         (WACOM_HID_UP_WACOMDIGITIZER | 0x0990)
 #define WACOM_HID_WD_BUTTONUP           (WACOM_HID_UP_WACOMDIGITIZER | 0x0991)
 #define WACOM_HID_WD_BUTTONDOWN         (WACOM_HID_UP_WACOMDIGITIZER | 0x0992)
 #define WACOM_HID_WD_BUTTONLEFT         (WACOM_HID_UP_WACOMDIGITIZER | 0x0993)
 #define WACOM_HID_WD_BUTTONRIGHT        (WACOM_HID_UP_WACOMDIGITIZER | 0x0994)
+#define WACOM_HID_WD_BUTTONCENTER       (WACOM_HID_UP_WACOMDIGITIZER | 0x0995)
+#define WACOM_HID_WD_TOUCHONOFF         (WACOM_HID_UP_WACOMDIGITIZER | 0x0996)
 #define WACOM_HID_WD_FINGERWHEEL        (WACOM_HID_UP_WACOMDIGITIZER | 0x0d03)
 #define WACOM_HID_WD_OFFSETLEFT         (WACOM_HID_UP_WACOMDIGITIZER | 0x0d30)
 #define WACOM_HID_WD_OFFSETTOP          (WACOM_HID_UP_WACOMDIGITIZER | 0x0d31)
-- 
2.10.0

