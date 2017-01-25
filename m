From: Aaron Armstrong Skomra <skomra@gmail.com>
Subject: [PATCH 4/8] HID: wacom: generic: remove input_event_flag
Date: Wed, 25 Jan 2017 12:08:38 -0800
Message-ID: <1485374922-3417-5-git-send-email-skomra@gmail.com>
References: <1485374922-3417-1-git-send-email-skomra@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34349 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751787AbdAYUJc (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 25 Jan 2017 15:09:32 -0500
Received: by mail-pg0-f65.google.com with SMTP id 3so2782483pgj.1
        for <linux-input@vger.kernel.org>; Wed, 25 Jan 2017 12:09:32 -0800 (PST)
In-Reply-To: <1485374922-3417-1-git-send-email-skomra@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, jkosina@suse.cz, benjamin.tissoires@redhat.com, pinglinux@gmail.com, killertofu@gmail.com
Cc: Aaron Armstrong Skomra <skomra@gmail.com>, Aaron Skomra <aaron.skomra@wacom.com>

Input_event_flag duplicates the information we track
in wacom_wac->hid_data.inrange_state for the pad.

Signed-off-by: Aaron Skomra <aaron.skomra@wacom.com>
---
 drivers/hid/wacom_wac.c | 9 +--------
 drivers/hid/wacom_wac.h | 1 -
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index ef29f7a..f6825d2 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1773,7 +1773,6 @@ static void wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
 	struct input_dev *input = wacom_wac->pad_input;
-	struct wacom_features *features = &wacom_wac->features;
 	unsigned equivalent_usage = wacom_equivalent_usage(usage->hid);
 
 	if (wacom_equivalent_usage(field->physical) == HID_DG_TABLETFUNCTIONKEY) {
@@ -1785,7 +1784,6 @@ static void wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field
 		break;
 
 	default:
-		features->input_event_flag = true;
 		input_event(input, usage->type, usage->code, value);
 		break;
 	}
@@ -1823,20 +1821,15 @@ static void wacom_wac_pad_report(struct hid_device *hdev,
 {
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
-	struct wacom_features *features = &wacom_wac->features;
 	struct input_dev *input = wacom_wac->pad_input;
 	bool active = wacom_wac->hid_data.inrange_state != 0;
 
 	/* report prox for expresskey events */
 	if (wacom_equivalent_usage(report->field[0]->physical) == HID_DG_TABLETFUNCTIONKEY) {
-		features->input_event_flag = true;
 		input_event(input, EV_ABS, ABS_MISC, active ? PAD_DEVICE_ID : 0);
-	}
-
-	if (features->input_event_flag) {
-		features->input_event_flag = false;
 		input_sync(input);
 	}
+
 }
 
 static void wacom_wac_pen_usage_mapping(struct hid_device *hdev,
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index d3482de..dac95ba 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -243,7 +243,6 @@ struct wacom_features {
 	int pktlen;
 	bool check_for_hid_type;
 	int hid_type;
-	bool input_event_flag;
 };
 
 struct wacom_shared {
-- 
2.7.4

