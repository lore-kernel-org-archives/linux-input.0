From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v3 17/18] HID: wacom: generic: Extend pad support
Date: Wed, 19 Oct 2016 18:03:53 -0700
Message-ID: <20161020010354.4049-17-killertofu@gmail.com>
References: <20161006212231.31440-1-killertofu@gmail.com>
 <20161020010354.4049-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36772 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755704AbcJTBFS (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 19 Oct 2016 21:05:18 -0400
Received: by mail-pf0-f194.google.com with SMTP id r16so3827106pfg.3
        for <linux-input@vger.kernel.org>; Wed, 19 Oct 2016 18:05:18 -0700 (PDT)
In-Reply-To: <20161020010354.4049-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <ping.cheng@wacom.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, Jason Gerecke <killertofu@gmail.com>

The HID specification that the MobileStudio Pro follows includes usages
for several values that would be good to support so that future devices
"just work" out of the box. Extend the HID_GENERIC pad codepath to handle
these usages.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_wac.c | 15 +++++++++++++++
 drivers/hid/wacom_wac.h |  5 +++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index f3edecf..0723ba8 100644
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
@@ -1512,6 +1514,9 @@ static void wacom_map_usage(struct input_dev *input, struct hid_usage *usage,
 	case EV_MSC:
 		input_set_capability(input, EV_MSC, code);
 		break;
+	case EV_SW:
+		input_set_capability(input, EV_SW, code);
+		break;
 	}
 }
 
@@ -1546,11 +1551,21 @@ static void wacom_wac_pad_usage_mapping(struct hid_device *hdev,
 	case WACOM_HID_WD_BUTTONDOWN:
 	case WACOM_HID_WD_BUTTONLEFT:
 	case WACOM_HID_WD_BUTTONRIGHT:
+	case WACOM_HID_WD_BUTTONCENTER:
 		wacom_map_usage(input, usage, field, EV_KEY,
 				wacom_numbered_button_to_key(features->numbered_buttons),
 				0);
 		features->numbered_buttons++;
 		break;
+	case WACOM_HID_WD_TOUCHONOFF:
+		wacom_map_usage(input, usage, field, EV_SW, SW_MUTE_DEVICE, 0);
+		break;
+	case WACOM_HID_WD_TOUCHSTRIP:
+		wacom_map_usage(input, usage, field, EV_ABS, ABS_RX, 0);
+		break;
+	case WACOM_HID_WD_TOUCHSTRIP2:
+		wacom_map_usage(input, usage, field, EV_ABS, ABS_RY, 0);
+		break;
 	case WACOM_HID_WD_TOUCHRING:
 		wacom_map_usage(input, usage, field, EV_ABS, ABS_WHEEL, 0);
 		break;
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 7418c97..a54a301 100644
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

