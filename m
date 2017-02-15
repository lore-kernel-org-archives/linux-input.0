From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 3/3] HID: wacom: generic: support touch on/off softkey
Date: Tue, 14 Feb 2017 21:27:45 -0800
Message-ID: <1487136465-5255-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34531 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbdBOF1z (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 15 Feb 2017 00:27:55 -0500
Received: by mail-pf0-f193.google.com with SMTP id o64so6894024pfb.1
        for <linux-input@vger.kernel.org>; Tue, 14 Feb 2017 21:27:55 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org, benjamin.tissoires@gmail.com, dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>, Ping Cheng <ping.cheng@wacom.com>

Wacom Cintiq Pro has a softkey to turn touch on/off. Since it is
a softkey, hardware/firmware still reports touch events no matter
what state the softkey is. We need to ignore touch events when
the key is in off mode.

Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
---
 drivers/hid/wacom_sys.c |  4 +++-
 drivers/hid/wacom_wac.c | 18 +++++++++++++++++-
 drivers/hid/wacom_wac.h |  2 ++
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index b3272c6..953e690 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2100,8 +2100,10 @@ static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
 		wacom_wac->shared->touch_input = wacom_wac->touch_input;
 	}
 
-	if (wacom_wac->has_mute_touch_switch)
+	if (wacom_wac->has_mute_touch_switch) {
 		wacom_wac->shared->has_mute_touch_switch = true;
+		wacom_wac->shared->is_touch_on = true;
+	}
 
 	if (wacom_wac->shared->has_mute_touch_switch &&
 	    wacom_wac->shared->touch_input) {
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 0c544e7..5276dbe 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1732,6 +1732,7 @@ static void wacom_wac_pad_usage_mapping(struct hid_device *hdev,
 		features->device_type |= WACOM_DEVICETYPE_PAD;
 		break;
 	case WACOM_HID_WD_TOUCHONOFF:
+	case WACOM_HID_WD_MUTE_DEVICE:
 		/*
 		 * This usage, which is used to mute touch events, comes
 		 * from the pad packet, but is reported on the touch
@@ -1824,6 +1825,7 @@ static void wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field
 	struct wacom_features *features = &wacom_wac->features;
 	unsigned equivalent_usage = wacom_equivalent_usage(usage->hid);
 	int i;
+	bool is_touch_on = value;
 
 	/*
 	 * Avoid reporting this event and setting inrange_state if this usage
@@ -1843,10 +1845,17 @@ static void wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field
 			input_event(input, usage->type, usage->code, 0);
 		break;
 
+	case WACOM_HID_WD_MUTE_DEVICE:
+		if (wacom_wac->shared->touch_input && value) {
+			wacom_wac->shared->is_touch_on = !wacom_wac->shared->is_touch_on;
+			is_touch_on = wacom_wac->shared->is_touch_on;
+		}
+
+		/* fall through*/
 	case WACOM_HID_WD_TOUCHONOFF:
 		if (wacom_wac->shared->touch_input) {
 			input_report_switch(wacom_wac->shared->touch_input,
-					    SW_MUTE_DEVICE, !value);
+					    SW_MUTE_DEVICE, !is_touch_on);
 			input_sync(wacom_wac->shared->touch_input);
 		}
 		break;
@@ -2205,6 +2214,13 @@ static void wacom_wac_finger_slot(struct wacom_wac *wacom_wac,
 	bool prox = hid_data->tipswitch &&
 		    report_touch_events(wacom_wac);
 
+	if (wacom_wac->shared->has_mute_touch_switch &&
+	    !wacom_wac->shared->is_touch_on) {
+		if (!wacom_wac->shared->touch_down)
+			return;
+		prox = 0;
+	}
+
 	wacom_wac->hid_data.num_received++;
 	if (wacom_wac->hid_data.num_received > wacom_wac->hid_data.num_expected)
 		return;
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index d9669c6..839bd4b 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -121,6 +121,7 @@
 #define WACOM_HID_WD_EXPRESSKEY00       (WACOM_HID_UP_WACOMDIGITIZER | 0x0910)
 #define WACOM_HID_WD_EXPRESSKEYCAP00    (WACOM_HID_UP_WACOMDIGITIZER | 0x0950)
 #define WACOM_HID_WD_MODE_CHANGE        (WACOM_HID_UP_WACOMDIGITIZER | 0x0980)
+#define WACOM_HID_WD_MUTE_DEVICE        (WACOM_HID_UP_WACOMDIGITIZER | 0x0981)
 #define WACOM_HID_WD_CONTROLPANEL       (WACOM_HID_UP_WACOMDIGITIZER | 0x0982)
 #define WACOM_HID_WD_ONSCREEN_KEYBOARD  (WACOM_HID_UP_WACOMDIGITIZER | 0x0983)
 #define WACOM_HID_WD_BUTTONCONFIG       (WACOM_HID_UP_WACOMDIGITIZER | 0x0986)
@@ -274,6 +275,7 @@ struct wacom_shared {
 	struct hid_device *pen;
 	struct hid_device *touch;
 	bool has_mute_touch_switch;
+	bool is_touch_on;
 };
 
 struct hid_data {
-- 
1.8.3.1

