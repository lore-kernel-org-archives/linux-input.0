From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 3/3] HID: wacom: Report touch width/height/orientation for GENERIC devices
Date: Tue, 21 Jul 2015 11:07:25 -0700
Message-ID: <1437502045-29927-3-git-send-email-killertofu@gmail.com>
References: <1437502045-29927-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36693 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933274AbbGUSHn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jul 2015 14:07:43 -0400
Received: by pachj5 with SMTP id hj5so124200902pac.3
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2015 11:07:43 -0700 (PDT)
In-Reply-To: <1437502045-29927-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Aaron Skomra <skomra@gmail.com>, linux-input@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

The HID_DG_WIDTH and HID_DG_HEIGHT usages report with width and height of
contacts. From this information, a crude determination of orientation is
also possible. This patch reports all three to userspace if a device
reports this usage.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 09fe5d6..280deb2 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1497,6 +1497,13 @@ static void wacom_wac_finger_usage_mapping(struct hid_device *hdev,
 			wacom_map_usage(input, usage, field, EV_ABS,
 					ABS_MT_POSITION_Y, 4);
 		break;
+	case HID_DG_WIDTH:
+	case HID_DG_HEIGHT:
+		features->last_slot_field = usage->hid;
+		wacom_map_usage(input, usage, field, EV_ABS, ABS_MT_TOUCH_MAJOR, 0);
+		wacom_map_usage(input, usage, field, EV_ABS, ABS_MT_TOUCH_MINOR, 0);
+		input_set_abs_params(input, ABS_MT_ORIENTATION, 0, 1, 0, 0);
+		break;
 	case HID_DG_CONTACTID:
 		features->last_slot_field = usage->hid;
 		break;
@@ -1545,6 +1552,13 @@ static void wacom_wac_finger_slot(struct wacom_wac *wacom_wac,
 				 hid_data->x);
 		input_report_abs(input, mt ? ABS_MT_POSITION_Y : ABS_Y,
 				 hid_data->y);
+
+		if (test_bit(ABS_MT_TOUCH_MAJOR, input->absbit)) {
+			input_report_abs(input, ABS_MT_TOUCH_MAJOR, max(hid_data->width, hid_data->height));
+			input_report_abs(input, ABS_MT_TOUCH_MINOR, min(hid_data->width, hid_data->height));
+			if (hid_data->width != hid_data->height)
+				input_report_abs(input, ABS_MT_ORIENTATION, hid_data->width <= hid_data->height ? 0 : 1);
+		}
 	}
 }
 
@@ -1561,6 +1575,12 @@ static int wacom_wac_finger_event(struct hid_device *hdev,
 	case HID_GD_Y:
 		wacom_wac->hid_data.y = value;
 		break;
+	case HID_DG_WIDTH:
+		wacom_wac->hid_data.width = value;
+		break;
+	case HID_DG_HEIGHT:
+		wacom_wac->hid_data.height = value;
+		break;
 	case HID_DG_CONTACTID:
 		wacom_wac->hid_data.id = value;
 		break;
-- 
2.4.6

