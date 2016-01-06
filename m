From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] HID: wacom: Use correct report to query pen ID from INTUOSHT2 devices
Date: Wed,  6 Jan 2016 13:25:53 -0800
Message-ID: <1452115553-3129-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33205 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbcAFV0E (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Jan 2016 16:26:04 -0500
Received: by mail-pa0-f53.google.com with SMTP id cy9so240346020pac.0
        for <linux-input@vger.kernel.org>; Wed, 06 Jan 2016 13:26:04 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

Unlike other tablets which are compatible with the wacom_intuos_irq handler,
INTUOSHT2 devices provide pen ID with report ID 8 instead of 5. To ensure
wacom_intuos_schedule_prox_event works as intended for these tablets, we
must be sure it uses the correct report ID in this case.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 6 +++++-
 drivers/hid/wacom_wac.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index f706604..3aeddc2 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -439,11 +439,15 @@ exit:
 static void wacom_intuos_schedule_prox_event(struct wacom_wac *wacom_wac)
 {
 	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
+	struct wacom_features *features = &wacom_wac->features;
 	struct hid_report *r;
 	struct hid_report_enum *re;
 
 	re = &(wacom->hdev->report_enum[HID_FEATURE_REPORT]);
-	r = re->report_id_hash[WACOM_REPORT_INTUOS_ID1];
+	if (features->type == INTUOSHT2)
+		r = re->report_id_hash[WACOM_REPORT_INTUOSHT2_ID];
+	else
+		r = re->report_id_hash[WACOM_REPORT_INTUOS_ID1];
 	if (r) {
 		hid_hw_request(wacom->hdev, r, HID_REQ_GET_REPORT);
 	}
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 3f60192..25baa7f 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -70,6 +70,7 @@
 #define WACOM_REPORT_DEVICE_LIST	16
 #define WACOM_REPORT_INTUOS_PEN		16
 #define WACOM_REPORT_REMOTE		17
+#define WACOM_REPORT_INTUOSHT2_ID	8
 
 /* device quirks */
 #define WACOM_QUIRK_BBTOUCH_LOWRES	0x0001
-- 
2.6.3

