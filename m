From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH 1/1] HID: waltop: Extend barrel button fix
Date: Sun, 20 May 2012 21:23:36 +0300
Message-ID: <1337538216-7406-1-git-send-email-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50096 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755640Ab2ETSXz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 May 2012 14:23:55 -0400
Received: by bkcji2 with SMTP id ji2so3383791bkc.19
        for <linux-input@vger.kernel.org>; Sun, 20 May 2012 11:23:54 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>, DIGImend-users <digimend-users@lists.sourceforge.net>, "Eduardo H. Silva" <hoboprimate@gmail.com>, Nikolai Kondrashov <spbnick@gmail.com>

Extend Waltop barrel button fix to all models: ignore reported pressure when a
barrel button is pressed, because it is rarely correct. Report zero pressure in
such cases instead.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
---
 drivers/hid/hid-waltop.c |   45 +++++++--------------------------------------
 1 file changed, 7 insertions(+), 38 deletions(-)

diff --git a/drivers/hid/hid-waltop.c b/drivers/hid/hid-waltop.c
index 9a48438..745e4e9 100644
--- a/drivers/hid/hid-waltop.c
+++ b/drivers/hid/hid-waltop.c
@@ -638,28 +638,10 @@ static __u8 sirius_battery_free_tablet_rdesc_fixed[] = {
 	0xC0                /*  End Collection                      */
 };
 
-struct waltop_state {
-	u8 pressure0;
-	u8 pressure1;
-};
-
 static int waltop_probe(struct hid_device *hdev,
 			const struct hid_device_id *id)
 {
 	int ret;
-	struct waltop_state *s;
-
-	s = kzalloc(sizeof(*s), GFP_KERNEL);
-	if (s == NULL) {
-		hid_err(hdev, "can't allocate device state\n");
-		ret = -ENOMEM;
-		goto err;
-	}
-
-	s->pressure0 = 0;
-	s->pressure1 = 0;
-
-	hid_set_drvdata(hdev, s);
 
 	ret = hid_parse(hdev);
 	if (ret) {
@@ -675,7 +657,6 @@ static int waltop_probe(struct hid_device *hdev,
 
 	return 0;
 err:
-	kfree(s);
 	return ret;
 }
 
@@ -732,27 +713,18 @@ static __u8 *waltop_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 static int waltop_raw_event(struct hid_device *hdev, struct hid_report *report,
 		     u8 *data, int size)
 {
-	/* If this is a pen input report of a tablet with PID 0038 */
-	if (hdev->product == USB_DEVICE_ID_WALTOP_PID_0038 &&
-	    report->type == HID_INPUT_REPORT &&
-	    report->id == 16 &&
-	    size == 8) {
-		struct waltop_state *s = hid_get_drvdata(hdev);
-
+	/* If this is a pen input report */
+	if (report->type == HID_INPUT_REPORT && report->id == 16 && size >= 8) {
 		/*
-		 * Ignore maximum pressure reported when a barrel button is
-		 * pressed.
+		 * Ignore reported pressure when a barrel button is pressed,
+		 * because it is rarely correct.
 		 */
 
 		/* If a barrel button is pressed */
 		if ((data[1] & 0xF) > 1) {
-			/* Use the last known pressure */
-			data[6] = s->pressure0;
-			data[7] = s->pressure1;
-		} else {
-			/* Remember reported pressure */
-			s->pressure0 = data[6];
-			s->pressure1 = data[7];
+			/* Report zero pressure */
+			data[6] = 0;
+			data[7] = 0;
 		}
 	}
 
@@ -806,10 +778,7 @@ static int waltop_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 static void waltop_remove(struct hid_device *hdev)
 {
-	struct waltop_state *s = hid_get_drvdata(hdev);
-
 	hid_hw_stop(hdev);
-	kfree(s);
 }
 
 static const struct hid_device_id waltop_devices[] = {
-- 
1.7.10

