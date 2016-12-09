From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 3/4 v2] HID: wacom: generic: Pad supports more than buttons
Date: Thu,  8 Dec 2016 22:05:44 -0800
Message-ID: <1481263544-7044-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34997 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752070AbcLIGFz (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 9 Dec 2016 01:05:55 -0500
Received: by mail-pf0-f194.google.com with SMTP id i88so599516pfk.2
        for <linux-input@vger.kernel.org>; Thu, 08 Dec 2016 22:05:54 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org, jason.gerecke@wacom.com, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <ping.cheng@wacom.com>

From: Ping Cheng <pinglinux@gmail.com>

Make sure everything reported from pad are registered

Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
Reviewed-By: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 29d2610..7a748a7 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1538,14 +1538,17 @@ static void wacom_wac_pad_usage_mapping(struct hid_device *hdev,
 	case WACOM_HID_WD_ACCELEROMETER_X:
 		__set_bit(INPUT_PROP_ACCELEROMETER, input->propbit);
 		wacom_map_usage(input, usage, field, EV_ABS, ABS_X, 0);
+		features->device_type |= WACOM_DEVICETYPE_PAD;
 		break;
 	case WACOM_HID_WD_ACCELEROMETER_Y:
 		__set_bit(INPUT_PROP_ACCELEROMETER, input->propbit);
 		wacom_map_usage(input, usage, field, EV_ABS, ABS_Y, 0);
+		features->device_type |= WACOM_DEVICETYPE_PAD;
 		break;
 	case WACOM_HID_WD_ACCELEROMETER_Z:
 		__set_bit(INPUT_PROP_ACCELEROMETER, input->propbit);
 		wacom_map_usage(input, usage, field, EV_ABS, ABS_Z, 0);
+		features->device_type |= WACOM_DEVICETYPE_PAD;
 		break;
 	case WACOM_HID_WD_BUTTONHOME:
 	case WACOM_HID_WD_BUTTONUP:
@@ -1557,18 +1560,23 @@ static void wacom_wac_pad_usage_mapping(struct hid_device *hdev,
 				wacom_numbered_button_to_key(features->numbered_buttons),
 				0);
 		features->numbered_buttons++;
+		features->device_type |= WACOM_DEVICETYPE_PAD;
 		break;
 	case WACOM_HID_WD_TOUCHONOFF:
 		wacom_map_usage(input, usage, field, EV_SW, SW_MUTE_DEVICE, 0);
+		features->device_type |= WACOM_DEVICETYPE_PAD;
 		break;
 	case WACOM_HID_WD_TOUCHSTRIP:
 		wacom_map_usage(input, usage, field, EV_ABS, ABS_RX, 0);
+		features->device_type |= WACOM_DEVICETYPE_PAD;
 		break;
 	case WACOM_HID_WD_TOUCHSTRIP2:
 		wacom_map_usage(input, usage, field, EV_ABS, ABS_RY, 0);
+		features->device_type |= WACOM_DEVICETYPE_PAD;
 		break;
 	case WACOM_HID_WD_TOUCHRING:
 		wacom_map_usage(input, usage, field, EV_ABS, ABS_WHEEL, 0);
+		features->device_type |= WACOM_DEVICETYPE_PAD;
 		break;
 	}
 
@@ -1578,6 +1586,7 @@ static void wacom_wac_pad_usage_mapping(struct hid_device *hdev,
 				wacom_numbered_button_to_key(features->numbered_buttons),
 				0);
 		features->numbered_buttons++;
+		features->device_type |= WACOM_DEVICETYPE_PAD;
 		break;
 	}
 }
-- 
1.8.3.1

