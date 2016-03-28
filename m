From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] HID: wacom: Support switching from vendor-defined input format on G9 and G11
Date: Mon, 28 Mar 2016 13:10:50 -0700
Message-ID: <1459195850-11128-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36127 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbcC1ULA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Mar 2016 16:11:00 -0400
Received: by mail-pf0-f169.google.com with SMTP id u190so145602742pfb.3
        for <linux-input@vger.kernel.org>; Mon, 28 Mar 2016 13:11:00 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ping Cheng <pinglinux@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

A tablet PC booted into Windows may have its pen/touch hardware switched
into "Wacom mode" similar to what we do with explicitly-supported hardware.
Some devices appear to maintain this state across reboots, preventing their
use with the generic HID driver. This patch adds support for the vendor-
defined "input format" feature report of G9 and G11 chips and has the HID
codepath always attempt to reset the device back to an appropriate format.

Fixes: https://sourceforge.net/p/linuxwacom/bugs/307/
Fixes: https://sourceforge.net/p/linuxwacom/bugs/310/
Fixes: https://github.com/linuxwacom/input-wacom/issues/15

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_sys.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/hid/wacom_wac.h | 13 ++++++++++--
 2 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 68a5609..d7ef7b0 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -152,6 +152,32 @@ static void wacom_feature_mapping(struct hid_device *hdev,
 		hid_data->inputmode = field->report->id;
 		hid_data->inputmode_index = usage->usage_index;
 		break;
+
+	/* The vendor-defined application collections leave most usages
+	 * as null (0x0000), making them much more difficult to match...
+	 */
+	case HID_UP_DIGITIZER:
+		if (field->application == WACOM_G9_DIGITIZER ||
+		    field->application == WACOM_G11_DIGITIZER) {
+			if (field->report->id == 0x0B) {
+				hid_data->inputformat = field->report->id;
+				hid_data->inputformat_index = 0;
+				hid_data->inputformat_value = 0; /* 0: HID; 1: Vendor-defined */
+			}
+		}
+		break;
+
+	case WACOM_G9_PAGE:
+	case WACOM_G11_PAGE:
+		if (field->application == WACOM_G9_TOUCHSCREEN ||
+		    field->application == WACOM_G11_TOUCHSCREEN) {
+			if (field->report->id == 0x03) {
+				hid_data->inputformat = field->report->id;
+				hid_data->inputformat_index = 0;
+				hid_data->inputformat_value = 0; /* 0: HID; 4: Vendor-defined */
+			}
+		}
+		break;
 	}
 }
 
@@ -322,6 +348,25 @@ static int wacom_hid_set_device_mode(struct hid_device *hdev)
 	return 0;
 }
 
+static int wacom_hid_set_device_format(struct hid_device *hdev)
+{
+	struct wacom *wacom = hid_get_drvdata(hdev);
+	struct hid_data *hid_data = &wacom->wacom_wac.hid_data;
+	struct hid_report *r;
+	struct hid_report_enum *re;
+
+	if (hid_data->inputformat < 0)
+		return 0;
+
+	re = &(hdev->report_enum[HID_FEATURE_REPORT]);
+	r = re->report_id_hash[hid_data->inputformat];
+	if (r) {
+		r->field[0]->value[hid_data->inputformat_index] = hid_data->inputformat_value;
+		hid_hw_request(hdev, r, HID_REQ_SET_REPORT);
+	}
+	return 0;
+}
+
 static int wacom_set_device_mode(struct hid_device *hdev, int report_id,
 		int length, int mode)
 {
@@ -414,8 +459,14 @@ static int wacom_query_tablet_data(struct hid_device *hdev,
 	if (hdev->bus == BUS_BLUETOOTH)
 		return wacom_bt_query_tablet_data(hdev, 1, features);
 
-	if (features->type == HID_GENERIC)
-		return wacom_hid_set_device_mode(hdev);
+	if (features->type == HID_GENERIC) {
+		int err;
+		err = wacom_hid_set_device_mode(hdev);
+		if (err)
+			return err;
+		err = wacom_hid_set_device_format(hdev);
+		return err;
+	}
 
 	if (features->device_type & WACOM_DEVICETYPE_TOUCH) {
 		if (features->type > TABLETPC) {
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 25baa7f..37d5dec 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -84,6 +84,12 @@
 #define WACOM_DEVICETYPE_WL_MONITOR     0x0008
 
 #define WACOM_VENDORDEFINED_PEN		0xff0d0001
+#define WACOM_G9_PAGE			0xff090000
+#define WACOM_G9_DIGITIZER		(WACOM_G9_PAGE | 0x02)
+#define WACOM_G9_TOUCHSCREEN		(WACOM_G9_PAGE | 0x11)
+#define WACOM_G11_PAGE			0xff110000
+#define WACOM_G11_DIGITIZER		(WACOM_G11_PAGE | 0x02)
+#define WACOM_G11_TOUCHSCREEN		(WACOM_G11_PAGE | 0x11)
 
 #define WACOM_PEN_FIELD(f)	(((f)->logical == HID_DG_STYLUS) || \
 				 ((f)->physical == HID_DG_STYLUS) || \
@@ -193,8 +199,11 @@ struct wacom_shared {
 };
 
 struct hid_data {
-	__s16 inputmode;	/* InputMode HID feature, -1 if non-existent */
-	__s16 inputmode_index;	/* InputMode HID feature index in the report */
+	__s16 inputmode;		/* InputMode HID feature, -1 if non-existent */
+	__s16 inputmode_index;		/* InputMode HID feature index in the report */
+	__s16 inputformat;		/* Vendor-defined "input format" feature, -1 if non-existent */
+	__s16 inputformat_index;	/* Vendor-defined "input format" feature index in the report */
+	__u8  inputformat_value;	/* Value expected by device to switch to HID mode */
 	bool inrange_state;
 	bool invert_state;
 	bool tipswitch;
-- 
2.7.3

