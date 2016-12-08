From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 3/4] HID: wacom: generic: Pad supports more than buttons
Date: Wed,  7 Dec 2016 16:18:41 -0800
Message-ID: <1481156321-5356-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35657 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932827AbcLHASz (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Dec 2016 19:18:55 -0500
Received: by mail-pg0-f68.google.com with SMTP id p66so24946848pga.2
        for <linux-input@vger.kernel.org>; Wed, 07 Dec 2016 16:18:55 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, benjamin.tissoires@redhat.com, Ping Cheng <pingc@wacom.com>, Ping Cheng <ping.cheng@wacom.com>

Make sure everything reported from pad are registered

Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
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
2.7.4

